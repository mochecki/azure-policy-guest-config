<#
    .SYNOPSIS
        The following DSC package is configuring ciphers in the operating system according to KPMG Global Standard.
        After running this package, ciphers will be configured in the below way:
            - AES 128/128 ===> enabled
            - AES 256/256 ===> enabled
            - DES 56/56 ===> disabled
            - NULL ===> disabled
            - RC2 128/128 ===> disabled
            - RC2 40/128 ===> disabled
            - RC2 56/128 ===> disabled
            - RC4 128/128 ===> disabled
            - RC4 40/128 ===> disabled
            - RC4 56/128 ===> disabled
            - RC4 64/128 ===> disabled
            - Triple DES 168 ===> disabled
            - Set Ciphers Suites in the following order:
                |->     TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
                |->     TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
                |->     TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
                |->     TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
                |->     TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
                |->     TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
                |->     TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
                |->     TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
                |->     TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
                |->     TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
                |->     TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
                |->     TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
                |->     TLS_RSA_WITH_AES_256_GCM_SHA384
                |->     TLS_RSA_WITH_AES_128_GCM_SHA256
                |->     TLS_RSA_WITH_AES_256_CBC_SHA256
                |->     TLS_RSA_WITH_AES_128_CBC_SHA256
                |->     TLS_RSA_WITH_AES_256_CBC_SHA
                |->     TLS_RSA_WITH_AES_128_CBC_SHA
#>

Configuration ConfigureCiphers
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        # Enable AES 128/128 Cipher
        Registry Enable_AES_128_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 128/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }

        # Enable AES 256/256 Cipher
        Registry Enable_AES_256_256
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 256/256'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            Hex = $true
            ValueData = '0xffffffff'
            Force = $true
        }

        # Disable DES 56/56 Cipher
        Registry Disable_DES_56_56
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable NULL Cipher
        Registry Disable_Null
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable RC2 128/128 Cipher
        Registry Disable_RC2_128_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable RC2 40/128 Cipher
        Registry Disable_RC2_40_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable RC2 56/128 Cipher
        Registry Disable_RC2_56_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable RC4 128/128 Cipher
        Registry Disable_RC4_128_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable RC4 40/128 Cipher
        Registry Disable_RC4_40_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable RC4 56/128 Cipher
        Registry Disable_RC4_56_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable RC4 64/128 Cipher
        Registry Disable_RC4_64_128
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Disable Triple DES 168 Cipher
        Registry Disable_Triple_DES_168
        {
            Key = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168'
            Ensure = 'Present'
            ValueName = 'Enabled'
            ValueType = 'DWord'
            ValueData = '0'
            Force = $true
        }

        # Order Cipher Suites
        Registry Set_Order_Cipher_Suites
        {
            Key = 'HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002'
            Ensure = 'Present'
            ValueName = 'Functions'
            ValueType = 'String'
            ValueData = 'TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA256,TLS_RSA_WITH_AES_128_CBC_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA'
            Force = $true
        }
    }
}

ConfigureCiphers