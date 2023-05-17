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

    $file = Join-Path $folders.outputFolder $configuration.package
    $blobName =  $configuration.name + '_' + ($configuration.version -replace '\.', '_') + '.zip'
    $blobExists = (Get-AzStorageBlob -Container $storageContainerName -Context $storageContext -Blob $blobName -ErrorAction SilentlyContinue)

    if (!$blobExists) {
        Write-Host "Uploading $blobName to $storageContainerName..."
        Set-AzStorageBlobContent -Container $storageContainerName -Context $storageContext -File $file -Blob $blobName
        Write-Host "$blobName uploaded successfully."

    } else {
        Write-Host "$blobName already exists in $storageContainerName. Skipping upload."
    }
}
