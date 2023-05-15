<#
    .SYNOPSIS
        This DSC configuration is disabling NetBios option fo reach attached NIC into the Virtual Machine.

        Ensure = Disabled -> Netbios service will be disabled on a target virtual machine
        Ensure = Enabled -> Netbios service will be enabled on a taget virtual machine
#>

Configuration DisableNetbiosOnNic {
    Import-DscResource -ModuleName DscNicNetbios

    Node localhost {
        DscNicNetbios disableNetbios {
            RegistryPath = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters\Interfaces'
            Ensure = 'Disabled'
        }
    }
}

DisableNetbiosOnNic