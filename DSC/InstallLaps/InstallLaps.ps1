<#
    .SYNOPSIS
        The following DSC Package installs LAPS Agent on each virtual machine.
#>

Configuration InstallLaps
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost  
    {
        MsiPackage Laps
        {
            ProductId = '{EA8CB806-C109-4700-96B4-F1F268E5036C}'
            FileHash = '077BD456389F3F51633A1F26F1DBFD5F'
            HashAlgorithm = 'MD5'
            Path = 'https://guestconfigmvp001.blob.core.windows.net/msi-packages/LAPS.x64.msi?sp=r&st=2023-04-12T15:44:47Z&se=2024-12-31T00:44:47Z&spr=https&sv=2021-12-02&sr=b&sig=G7g4Vc16MM2FUf3NwT7w7xJay%2FORHH%2B%2FvaMbOSoYgbQ%3D'
            Ensure = 'Present'
        }
    }
}

InstallLaps