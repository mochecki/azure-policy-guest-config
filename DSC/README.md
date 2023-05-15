# KPMG Global Server Configuration Standard

This document contains detailed information about each PowerShell DSC definition that is a part of the KPMG Global Server Configuration Standard.

## PowerShell DSC Modules Dependency

The below table contains information about the used `modules` for created PowerShell DSC Definitions.

| Name | Version | Notes
|------|---------|------|
| [DscNicNetbios](../customDscResources/DscNicNetbios/DscNicNetbios.psm1) | 0.0.1 | Custom module |
| [DscWindowsFeature](../customDscResources/DscWindowsFeature/DscWindowsFeature.psm1) | 0.0.1 | Custom module |
| [PSDscResources](https://github.com/PowerShell/PSDscResources) | 2.12.0.0 | `n/a` |

## Used DSC Resources

The below table contains information about used `DSC Resources` for created PowerShell DSC Definitions.

| Name | DSC Module |
|------|------------|
| [DscNicNetbios](../customDscResources/DscNicNetbios/DscNicNetbios.psm1) | DscNicNetbios |
| [DscWindowsFeature](../customDscResources/DscWindowsFeature/DscWindowsFeature.psm1) | DscWindowsFeature |
| [MsiPackage](https://github.com/PowerShell/PSDscResources#msipackage) | PSDscResources |
| [Registry](https://github.com/PowerShell/PSDscResources#registry) | PSDscResources |

## [configureCiphers](./configureCiphers/configureCiphers.ps1)
This DSC package is is configuring ciphers in the operating system according to KPMG Global Standard. 
After running this package, ciphers will be configured in the below way:
- AES 128/128 = ENABLED
- AES 256/256 = ENABLED
- DES 56/56 = DISABLED
- NULL = DISABLED
- RC2 128/128 = DISABLED
- RC2 40/128 = DISABLED
- RC2 56/128 = DISABLED
- RC4 128/128 = DISABLED
- RC4 40/128 = DISABLED
- RC4 56/128 = DISABLED
- RC4 64/128 = DISABLED
- Triple DES 168 = DISABLED

All of the above changes are enforced in the following registry key: `HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\***`

`*** -> Cipher name`

Moreover, this package is set Ciphers Suites in the following order:
- TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
- TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
- TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
- TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
- TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
- TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
- TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
- TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
- TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
- TLS_RSA_WITH_AES_256_GCM_SHA384
- TLS_RSA_WITH_AES_128_GCM_SHA256
- TLS_RSA_WITH_AES_256_CBC_SHA256
- TLS_RSA_WITH_AES_128_CBC_SHA256
- TLS_RSA_WITH_AES_256_CBC_SHA
- TLS_RSA_WITH_AES_128_CBC_SHA

All of the above changes are enforced in the following registry key: `HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002`

> **Used modules:**
> - PSDscResources
>
>  **Used DSC Resource:**
> - Registry

***

## [configureClientProtocols](./configureClientProtocols/configureClientProtocols.ps1)
This DSC package is configuring client protocols in the operating system according to KPMG Global Standard.
After running this package, the following protocols will be configured in the below way:
- Multi-Protocol Unified Hello = DISABLED
- PCT 1.0 = DISABLED
- SSL 2.0 = DISABLED
- SSL 3.0 = DISABLED
- TLS 1.0 = DISABLED
- TLS 1.1 = DISABLED
- TLS 1.2 = ENABLED

All of the above changes are enforced in the following registry key: `HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\***\Client`

`*** -> Protocol name`

> **Used modules:**
> - PSDscResources
>
>  **Used DSC Resource:**
> - Registry

***

## [configureHashes](./configureHashes/configureHashes.ps1)
This DSC package is configuring Hashes in the operating system according to KPMG Global Standard.
After running this package, the following Hashes will be configured:
- MD5 = DISABLED
- SHA = DISABLED
- SHA256 = ENABLED
- SHA384 = ENABLED
- SHA512 = ENABLED

All of the above changes are enforced in the following registry key: `HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\***`

`*** -> Hash name`

> **Used modules:**
> - PSDscResources
>
>  **Used DSC Resource:**
> - Registry

***

## [configureKeyExchangeAlgorithms](./configureKeyExchangeAlgorithms/configureKeyExchangeAlgorithms.ps1)
This DSC package is configuring Key Exchange Algorithms in the operating system according to KPMG Global Standard.
After running this package, the following Key Exchange Algorithms will be configured:
- Diffie-Hellman = ENABLED
- ECDH = ENABLED
- PKCS = DISABLED

All of the above changes are enforced in the following registry key: `'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\***`

`*** -> Algorithm name`

Moreover, this DSC package is enforcing best practicies for Diffie-Hellman algorithm and apply the following properties:
- Server Min Key Bit Length = 2048
- Client Min Key Bit Length = 2048

All of the above changes are enforced in the following registry key: `HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman`

> **Used modules:**
> - PSDscResources
>
>  **Used DSC Resource:**
> - Registry

***

## [configureServerProtocols](./configureServerProtocols/configureServerProtocols.ps1)
This DSC package is configuring server protocols in the operating system according to KPMG Global Standard.
After running this package, the following protocols will be configured in the below way:
- Multi-Protocol Unified Hello = DISABLED
- PCT 1.0 = DISABLED
- SSL 2.0 = DISABLED
- SSL 3.0 = DISABLED
- TLS 1.0 = DISABLED
- TLS 1.1 = DISABLED
- TLS 1.2 = ENABLED

All of the above changes are enforced in the following registry key: `HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\***\Server`

`*** -> Protocol name`

> **Used modules:**
> - PSDscResources
>
>  **Used DSC Resource:**
> - Registry

***

## [disableMulticastNameResolution](./disableMulticastNameResolution/disableMulticastNameResolution.ps1)
This DSC package is disabling multicast name resolution for DNSClient according to KPMG Global Standard.

Affected registry key: `HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient`

> **Used modules:**
> - PSDscResources
>
>  **Used DSC Resource:**
> - Registry

***

## [disableNetbiosOnNic](./disableNetbiosOnNic/disableNetbiosOnNic.ps1)
This DSC package is disabling NetBios option fo reach attached NIC into the Virtual Machine.

Affected registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces\***`

`*** -> Interface GUID (Dynamic value)`

> **Used modules:**
> - DscNicNetbios
>
>  **Used DSC Resource:**
> - DscNicNetbios

***

## [installLaps](./installLaps/installLaps.ps1)
This DSC package installs LAPS Agent on each virtual machine. <br/>
The MSI file is downloaded from Storage Account (MSI has been shared by the EWT Engineering Team).<br/>
Additional security level is in place -> the `hash` value of file is checked before start installing to avoid installing suspicious application.<br/>

> **Used modules:**
> - PSDscResources
>
>  **Used DSC Resource:**
> - MsiPackage

***

## [installWindowsFeatures](./installWindowsFeatures/installWindowsFeatures.ps1)
This DSC package installs the following Windows Server Role(s)/Feature(s):
- File and Storage Services -> `FileAndStorage-Services`
  - Storage Services -> `Storage-Services`
- .NET Framework 4.7 Features -> `NET-Framework-45-Features` 
  - .NET Framework 4.7 -> `NET-Framework-45-Core`
- Windows PowerShell -> `PowerShellRoot`
  - Windows PowerShell 5.1 -> `PowerShell`
- WoW64 Support -> `WoW64-Support`
- Windows Defender Antivirus -> `Windows-Defender`

> **Used modules:**
> - DscWindowsFeature
>
>  **Used DSC Resource:**
> - DscWindowsFeature

***

## [removeWindowsFeatures](./removeWindowsFeatures/removeWindowsFeatures.ps1)
This DSC package removes the following Windows Server Role(s)/Feature(s):
- Remote Assistance -> `Remote-Assistance`
- SMB 1.0/CIFS File Sharing Support -> `FS-SMB1`
- WINS Server -> `WINS`
- Wireless LAN Service -> `Wireless-Networking`

> **Used modules:**
> - DscWindowsFeature
>
>  **Used DSC Resource:**
> - DscWindowsFeature