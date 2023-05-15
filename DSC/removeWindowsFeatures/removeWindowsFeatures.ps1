<#
    .SYNOPSIS
        Disables the Windows optional features:
            - Remote Assistance (Remote-Assistance)
            - SMB 1.0/CIFS File Sharing Support (FS-SMB1) (Removed by default)
            - WINS Server (WINS)
            - Wireless LAN Service (Wireless-Networking)
        
        and removes all files associated with these features.

#>

Configuration RemoveWindowsFeatures {
    Import-DscResource -ModuleName DscWindowsFeature

    Node localhost {
        DscWindowsFeature features {
            FeatureName = "FS-SMB1,Remote-Assistance,WINS,Wireless-Networking"
            Ensure = "Absent"
        }
    }
}
RemoveWindowsFeatures