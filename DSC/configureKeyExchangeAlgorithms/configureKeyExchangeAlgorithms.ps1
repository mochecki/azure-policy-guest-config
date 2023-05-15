<#
    .SYNOPSIS
        The following DSC package is configuring Key Exchange Algorithms in the operating system according to KPMG Global Standard.
        After running this package, the following Key Exchange Algorithms will be configured:
            - Diffie-Hellman ===> enabled
                |-> Server Min Key Bit Length == 2048
                |-> Client Min Key Bit Length == 2048
            - ECDH ===> enabled
            - PKCS ===> disabled
#>
Configuration ConfigureKeyExchangeAlgorithms
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        # Enable Diffie-Hellman Key Exchange Algorithm
        Registry Enable_Diffie_Hellman_Algorithm
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }

        # Configure Diffie-Hellman Key Exchange Algorithm property => Server Min Key Bit Length == 2048
        Registry Configure_Diffie_Hellman_Server_Min_Key_Bit_Length
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman'
            Ensure = 'Present'
            ValueName = 'ServerMinKeyBitLength'
            ValueType = 'DWord'
            ValueData = '2048'
            Force = $true
        }

        # Configure Diffie-Hellman Key Exchange Algorithm property => Client Min Key Bit Length == 2048
        Registry Configure_Diffie_Hellman_Client_Min_Key_Bit_Length
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman'
            Ensure = 'Present'
            ValueName = 'ClientMinKeyBitLength'
            ValueType = 'DWord'
            ValueData = '2048'
            Force = $true
        }

        # Enable ECDH Key Exchange Algorithm
        Registry Enable_ECDH_Algorithm
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\ECDH'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }

        # Disable PKCS Key Exchange Algorithm
        Registry Enable_PKCS_Algorithm
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }   
    }
}

ConfigureKeyExchangeAlgorithms