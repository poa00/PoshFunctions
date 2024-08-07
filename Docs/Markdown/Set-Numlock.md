---
external help file: poshfunctions-help.xml
Module Name: poshfunctions
online version: 
schema: 2.0.0
---

# Set-Numlock

## SYNOPSIS

Sets the state of the NumLock button. If you pass $true to function it will turn on NumLock.

## SYNTAX

### On (Default)

```
Set-Numlock [-Confirm] [-On] [-WhatIf] [<CommonParameters>]
```

### Off

```
Set-Numlock [-Confirm] [-Off] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION

Sets the state of the NumLock button.
If you pass $true to function it will turn on NumLock.
It first determines the state of the NumLock and then acts accordingly.


## EXAMPLES

### Example 1: EXAMPLE 1

```
Set-NumLock -On
```

Will turn on the NumLock





### Example 2: EXAMPLE 2

```
Set-NumLock -Off
```

Will turn off the NumLock






## PARAMETERS

### -Confirm

{{ Fill Confirm Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -Off

A switch parameter to determine if you want the NumLock off.

```yaml
Type: SwitchParameter
Parameter Sets: Off
Aliases: 
Accepted values: 

Required: True (None) False (Off)
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -On

A switch parameter to determine if you want the NumLock on.

```yaml
Type: SwitchParameter
Parameter Sets: On
Aliases: 
Accepted values: 

Required: True (None) False (On)
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```

### -WhatIf

{{ Fill WhatIf Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi
Accepted values: 

Required: True (None) False (All)
Position: Named
Default value: 
Accept pipeline input: False
Accept wildcard characters: False
DontShow: False
```


### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## OUTPUTS

### 


## NOTES

Inspiration: # Inspired by https://gallery.technet.microsoft.com/on-off-keyboad-lock-keys-6ba9885c
Changes:     Created function to set on or off the NumLock.
Requires use of helper function Test-IsNumLock


## RELATED LINKS

[Wscript.Shell] ()

