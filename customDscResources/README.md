# Custom DSC Resources
This document contains information about custom DSC Resources that have been created to create DSC packages.

| Name | Version | Notes
|------|---------|------|
| [DscNicNetbios](../customDscResources/DscNicNetbios/DscNicNetbios.psm1) | 0.0.1 | Custom module |
| [DscWindowsFeature](../customDscResources/DscWindowsFeature/DscWindowsFeature.psm1) | 0.0.1 | Custom module |

## [DscNicNetbios](./DscNicNetbios/DscNicNetbios.psm1)

This custom DSC Resource Class is responsible for enabling or disabling the NetBIOS option on each network interface card attached to a virtual machine.

### Requirements

- To use that module, please invoke the `Helpers.ps1` script located in the module folder, to import the module path into the PowerShell environment variable (`$env:PSModulePath`).
- Target machine must be running a Windows Server 2012 or later, or Nano Server.

### Parameters
| Type | Name | Property | Description | Values |
|------|------|----------|-------------|--------|
| `String` | RegistryPath | `Key` | The registry key path where the NetBIOS flag can be enabled or disabled. | n/a |
| `String` | Ensure | `Write` | Specifies whether the NetBIOS option should be disabled or not. <br/> To disable this option, specify this property as `Disabled`. <br/>To enable NetBIOS option, set this property as `Enabled`.<br/>This property does not have any default value, so it must be specified according to the desired state! | `Enabled` <br/> `Disabled` |

***

## [DscWindowsFeature](./DscWindowsFeature/DscWindowsFeature.psm1)
This custom DSC Resource Class is responsbile for managing Windows Server Role(s) and Feature(s) on a virtual machine.

### Requirements

- To use that module, please invoke the `Helpers.ps1` script located in the module folder, to import the module path into the PowerShell environment variable (`$env:PSModulePath`).
- Target machine must be running a Windows Server 2012 or later, or Nano Server.

### Parameters
| Type | Name | Property | Description | Values |
|------|------|----------|-------------|--------|
| `String` | FeatureName | `Key` | The name or list of names of Windows Server Role(s)/Feature(s) to install/remove. | n/a |
| `String` | Ensure | `Write` | Specifies whether the Windows Server Role(s)/Feature(s) should be enabled or disabled. <br/> To disable Windows Server Role(s)/Feature(s), specify this property as `Absent`. <br/>To enable Windows Server Role(s)/Feature(s), set this property as `Present`.<br/>This property does not have any default value, so it must be specified according to the desired state! | `Absent` <br/> `Present` |