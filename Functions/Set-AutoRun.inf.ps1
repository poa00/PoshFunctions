function Set-AutoRun.inf {
<#
.SYNOPSIS
    Creates an AutoRun.inf for a drive. Can set icon, label. Either an icon or label must be specified
.DESCRIPTION
    Creates an AutoRun.inf for a drive. Can set icon, label. Either an icon or label must be specified
.PARAMETER Path
    The path to the drive. Must begin with a drive letter followed by a colon ':'. Defaults to $pwd
.PARAMETER Label
    A string up to 32 characters that will represent the label for the drive
.PARAMETER Icon
    A path to an icon file (.ico). File must exist and it is copied to the root of the Path specified
#>

    [CmdletBinding()]
    param (
        [ValidateScript({
            if ($_ -notmatch '^[a-z]:') {
                throw 'ERROR: Path specified must begin with a drive letter followed by a colon (ex. X:)'
                $false
            } else {
                $true
            }
        })]
        [string] $Path = $pwd,

        [ValidateScript({
            if ($_.Length -gt 32) {
                throw 'ERROR: Maximum label length is 32 characters'
                $false
            } else {
                $true
            }
        })]
        [string] $Label = '',

        [ValidateScript({
            if ((Test-Path $_) -and ($_ -match '\.ico$')) {
                $true
            } else {
                if (-not (Test-Path $_)) {
                    throw "ERROR: Icon specified [$_] does not exist."
                } else {
                    throw 'ERROR: Icon must have .ico extension.'
                }
                $false
            }
        })]
        [string] $Icon = ''
    )

    begin {
        Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
        $DriveLetter = "$($Path.Substring(0,2))\"
        if (-not (Test-Path -Path $DriveLetter)) {
            throw "ERROR: Drive [$DriveLetter] does not exist"
            break
        }
        if ((-not $Label) -and (-not $Icon)) {
            throw 'ERROR: Either -Label, -Icon, or both must be specified'
        }
    }

    process {
        $AutoRun_inf = Join-Path -Path $DriveLetter -ChildPath 'AutoRun.inf'
        if (-not (Test-Path -Path $AutoRun_inf)) {
            Set-Content -Path $AutoRun_inf -Value $null
        }
        if ($Label) {
            Set-PrivateProfileString -File $AutoRun_inf -Section 'AutoRun' -Key 'Label' -Value $Label
        }
        if ($Icon) {
            $Icon = Resolve-Path -Path $Icon
            $IconFile = Get-Item -Path $Icon
            Copy-Item -Path (Get-Item -Path $Icon) -Destination $DriveLetter
            Set-PrivateProfileString -File $AutoRun_inf -Section 'AutoRun' -Key 'Icon' -Value $IconFile.Name
        }
        Add-FileAttribute -Path $AutoRun_inf -FileAttribute 'Hidden', 'System'
    }

    end {
        Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
    }
}
