<#
    .SYNOPSIS
        The following DSC package is configuring server protocols in the operating system according to KPMG Global Standard.
        After running this package, the following protocols will be configured in the below way:
            - Multi-Protocol Unified Hello ===> disabled
            - PCT 1.0 ===> disabled
            - SSL 2.0 ===> disabled
            - SSL 3.0 ===> disabled
            - TLS 1.0 ===> disabled
            - TLS 1.1 ===> disabled
            - TLS 1.2 ===> enabled
#>
Configuration ConfigureServerProtocols
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        # Disable Multi-Protocol Unified Hello
        Registry MultiProtocol_Unified_Hello_Server_Enabled
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\Multi-Protocol Unified Hello\Server'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        Registry MultiProtocol_Unified_Hello_Server_DisabledByDefault
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\Multi-Protocol Unified Hello\Server'
            Ensure = 'Present'
            ValueName = 'DisabledByDefault'
            ValueType = 'DWord'
            ValueData = '1'
            Force = $true
        }

        # Disable PCT 1.0
        Registry PCT_10_Server_Enabled
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Server'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        Registry PCT_10_Server_DisabledByDefault
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0\Server'
            Ensure = 'Present'
            ValueName = 'DisabledByDefault'
            ValueType = 'DWord'
            ValueData = '1'
            Force = $true
        }

        # Disable SSL 2.0
        Registry SSL_20_Server_Enabled
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        Registry SSL_20_Server_DisabledByDefault
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server'
            Ensure = 'Present'
            ValueName = 'DisabledByDefault'
            ValueType = 'DWord'
            ValueData = '1'
            Force = $true
        }

        # Disable SSL 3.0
        Registry SSL_30_Server_Enabled
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        Registry SSL_30_Server_DisabledByDefault
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server'
            Ensure = 'Present'
            ValueName = 'DisabledByDefault'
            ValueType = 'DWord'
            ValueData = '1'
            Force = $true
        }

        # Disable TLS 1.0
        Registry TLS_10_Server_Enabled
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        Registry TLS_10_Server_DisabledByDefault
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server'
            Ensure = 'Present'
            ValueName = 'DisabledByDefault'
            ValueType = 'DWord'
            ValueData = '1'
            Force = $true
        }

        # Disable TLS 1.1
        Registry TLS_11_Server_Enabled
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        Registry TLS_11_Server_DisabledByDefault
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server'
            Ensure = 'Present'
            ValueName = 'DisabledByDefault'
            ValueType = 'DWord'
            ValueData = '1'
            Force = $true
        }

        # Enable TLS 1.2
        Registry TLS_12_Server_Enabled
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }

        Registry TLS_12_Server_DisabledByDefault
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
            Ensure = 'Present'
            ValueName = 'DisabledByDefault'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }
    }
}

ConfigureServerProtocols