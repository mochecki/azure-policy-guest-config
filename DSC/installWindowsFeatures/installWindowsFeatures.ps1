<#
    .SYNOPSIS
        Installing the following Windows Server Features:
            - File and Storage Services -> FileAndStorage-Services
	            - Storage Services -> Storage-Services
            - .NET Framework 4.7 Features -> NET-Framework-45-Features  
                - .NET Framework 4.7 -> NET-Framework-45-Core
            - Windows PowerShell -> PowerShellRoot
                - Windows PowerShell 5.1 -> PowerShell
            - WoW64 Support -> WoW64-Support
            - Windows Defender Antivirus -> Windows-Defender
#>

Configuration InstallWindowsFeatures {
    Import-DscResource -ModuleName DscWindowsFeature

    Node localhost {
        DscWindowsFeature features {
            FeatureName = "FileAndStorage-Services,Storage-Services,NET-Framework-45-Features,NET-Framework-45-Core,PowerShellRoot,PowerShell,WoW64-Support,Windows-Defender"
            Ensure = "Present"
        }
    }
}
InstallWindowsFeatures