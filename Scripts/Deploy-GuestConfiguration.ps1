<#
.SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>


[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string] $storageAccountName,

    [Parameter(Mandatory=$true)]
    [string] $storageContainerName
)

. "$PSScriptRoot/Helpers/Get-Folders.ps1"
. "$PSScriptRoot/Helpers/Get-Configurations.ps1"

$InformationPreference = 'Continue'

$folders = Get-Folders

Write-Information ""
Write-Information "==================================================================================================="
Write-Information "Read global settings from '$($folders.configurationFile)'."
Write-Information "==================================================================================================="

$configurations = Get-Configurations $folders.outputConfigurationFile

Write-Information "Configuration counts: $($configurations.Count)"
Write-Information ""


Write-Information ""
Write-Information "==================================================================================================="
Write-Information "Processing $($configurations.Count) configurations"
Write-Information "==================================================================================================="
Write-Information ""


# Connect to Azure Storage Account
$storageAccount = Get-AzStorageAccount -Name $storageAccountName
$storageContext = $storageAccount.Context

# Check if the storage container exists, create it if necessary
if (!(Get-AzStorageContainer -Name $storageContainerName -Context $storageContext -ErrorAction SilentlyContinue)) {
    New-AzStorageContainer -Name $storageContainerName -Context $storageContext -Permission Blob
}

foreach ($configuration in $configurations) {
    
    Write-Information "- Configuration: $($configuration.name)  Version: $($configuration.version)"

    $blobName = $artifact.Name
    $blobPath = "$($artifact.Directory.Name)/$blobName"
    $blobExists = (Get-AzStorageBlob -Container $storageContainerName -Context $storageContext -Blob $configuration.package -ErrorAction SilentlyContinue)

    if (!$blobExists) {
        Write-Host "Uploading $blobName to $storageContainerName..."
        Set-AzStorageBlobContent -Container $storageContainerName -Context $storageContext -File $artifact.FullName -Blob $configuration.package
        Write-Host "$blobName uploaded successfully."
    } else {
        Write-Host "$blobName already exists in $storageContainerName. Skipping upload."
    }
    
    # If the blob does not exist, copy the file to the storage account
    if (!$blobExists) {
        Write-Host "Copying file $filePath to storage account..."
        Set-AzStorageBlobContent -Context $context `
                                    -Container $ContainerName `
                                    -File $filePath `
                                    -Blob $blobName `
                                    -Force
        Write-Host "File $filePath copied to storage account."
    }
    else {
        Write-Host "File $filePath already exists in the storage account."
    }

    $PolicyConfig2      = @{
        PolicyId      = [guid]::NewGuid()
        ContentUri    = $contenturi
        DisplayName   = $configuration.DisplayName
        Description   = $configuration.Description
        Path          = $folders.outputFolder
        Platform      = 'Windows'
        PolicyVersion = $configuration.version
        Mode          = 'ApplyAndAutoCorrect'
      }
      
    New-GuestConfigurationPolicy @PolicyConfig2
}
