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
    [string] $storageResourceGroup,

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
Write-Information "Read global settings from '$($folders.outputConfigurationFile)'."
Write-Information "==================================================================================================="

$configurations = Get-Configurations $folders.outputConfigurationFile

Write-Information "Configuration counts: $($configurations.Count)"
Write-Information ""

Write-Information "Connecting to $storageAccountName..."
# Connect to Azure Storage Account
$storageAccount = Get-AzStorageAccount -Name $storageAccountName -ResourceGroupName $storageResourceGroup
$storageContext = $storageAccount.Context

Write-Information "Checking if $storageContainerName container exists..."
# Check if the storage container exists, create it if necessary
if (!(Get-AzStorageContainer -Name $storageContainerName -Context $storageContext -ErrorAction SilentlyContinue)) {
    Write-Information "$storageContainerName does not exists... creating"
    New-AzStorageContainer -Name $storageContainerName -Context $storageContext -Permission Blob

    Write-Information "$storageContainerName created successfully."
} else {
    Write-Information "$storageContainerName container already exists in $storageAccountName. Skipping creation."
}

Write-Information ""
Write-Information "==================================================================================================="
Write-Information "Processing $($configurations.Count) configurations"
Write-Information "==================================================================================================="
Write-Information ""

$expiryTime = (Get-Date).AddYears(5)
$policyStage = "no"

foreach ($configuration in $configurations) {
    
    Write-Information "- Configuration: $($configuration.name)  Version: $($configuration.version)"

    $file = Join-Path $folders.outputFolder $configuration.package
    $blobName =  $configuration.name + '_' + ($configuration.version -replace '\.', '_') + '.zip'
    $blobExists = (Get-AzStorageBlob -Container $storageContainerName -Context $storageContext -Blob $blobName -ErrorAction SilentlyContinue)

    if (!$blobExists) {
        Write-Host "Uploading $blobName to $storageContainerName..."
        Set-AzStorageBlobContent -Container $storageContainerName -Context $storageContext -File $file -Blob $blobName

        $sasToken = New-AzStorageBlobSASToken -Container $storageContainerName -Blob $blobName -Context $storageContext -Permission r -ExpiryTime $expiryTime
        $blobUrl = $storageAccount.PrimaryEndpoints.Blob.ToString() + $storageContainerName + '/' + $blobName + $sasToken

        $PolicyConfig      = @{
            PolicyId      = [guid]::NewGuid().ToString()
            ContentUri    = $blobUrl
            DisplayName   = $configuration.name
            Description   = $configuration.name
            Path          = "./Output"
            Platform      = 'Windows'
            PolicyVersion = $configuration.version
            Mode          = 'ApplyAndAutoCorrect'
          }
          
        New-GuestConfigurationPolicy @PolicyConfig
          
        Write-Host "$blobName uploaded successfully."

        $policyStage = "yes"
    } else {
        Write-Host "$blobName already exists in $storageContainerName. Skipping upload."
    }
}

Write-Host "##vso[task.setvariable variable=deployPolicy;isOutput=true]$($policyStage)"

