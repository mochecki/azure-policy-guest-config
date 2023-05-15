<#
    .SYNOPSIS
        The following DSC package is configuring Hashes in the operating system according to KPMG Global Standard.
        After running this package, the following Hashes will be configured:
            - MD5 ===> disabled
            - SHA ===> disabled
            - SHA256 ===> enabled
            - SHA384 ===> enabled
            - SHA512 ===> enabled
#>
Configuration ConfigureHashes
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        # Disable MD5 Hash
        Registry Disable_MD5
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable SHA Hash
        Registry Disable_SHA
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Enable SHA256 Hash
        Registry Enable_SHA256
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA256'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }

        # Enable SHA384 Hash
        Registry Enable_SHA384
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA384'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }

        # Enable SHA512 Hash
        Registry Enable_SHA512
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA512'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }
    }
}

ConfigureHashes