function Get-ScheduledTaskUser {
    <#
.SYNOPSIS
    Get a list of scheduled tasks and the user context that they run under. By default excluded system tasks
.DESCRIPTION
    Get a list of scheduled tasks and the user context that they run under. By default excluded system tasks
.PARAMETER ComputerName
    An array of computer names. Defaults to $env:COMPUTERNAME. Aliased to 'CN', 'Server'
.PARAMETER IncludeSystem
    Switch to include the system scheduled tasks. Aliased to 'IS'
.PARAMETER IncludeInteractive
    Switch to include interactive only tasks. Aliased to 'II'
.NOTES
    Unless the -IncludeSystem switch is specified the following will be excluded from the output:
        'Administrator',
        'Administrators',
        'Authenticated Users',
        'Everyone',
        'INTERACTIVE',
        'LOCAL SERVICE',
        'NETWORK SERVICE',
        'Run As User',
        'SYSTEM',
        'Users'
#>

    [CmdletBinding()]
    [outputtype('psobject')]
    param (
        [Alias('CN', 'Server')]
        [string[]] $ComputerName = $env:COMPUTERNAME,

        [Alias('IS')]
        [switch] $IncludeSystem,

        [Alias('II')]
        [switch] $IncludeInteractive

    )

    begin {
        Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
        Write-Verbose -Message "ComputerName [$($ComputerName -join ', ')]"
        Write-Verbose -Message "IncludeSystem [$IncludeSystem], IncludeInteractive [$IncludeInteractive]"
        $System = @(
            'Administrator',
            'Administrators',
            'Authenticated Users',
            'Everyone',
            'INTERACTIVE',
            'LOCAL SERVICE',
            'NETWORK SERVICE',
            'Run As User',
            'SYSTEM',
            'Users'
        )
    }

    process {
        foreach ($curComputer in $ComputerName) {
            Write-Verbose -Message "Processing [$curComputer]"
            [array] $task = schtasks.exe /query /s $curComputer /V /FO CSV | ConvertFrom-Csv
            if (-not $IncludeSystem) {
                Write-Verbose -Message 'Excluding system tasks'
                $task = $task | Where-Object { $_.'Run As User' -notin $System -and $null -ne $_.'Run As User' }
            }
            if (-not $IncludeInteractive) {
                $task = $task | Where-Object { $_.'Logon Mode' -ne 'Interactive Only' }
            }
            $task | Where-Object { $_.Hostname -ne 'Hostname' } | Select-Object -Property @{Name = 'ComputerName'; Expr = { $_.HostName } },
                TaskName, Status, @{Name = 'RunAsUser'; Expr = { $_.'Run As User' } }, @{Name='LogonMode'; Expr = { $_.'Logon Mode'}}
        }
    }

    end {
        Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
    }
}
