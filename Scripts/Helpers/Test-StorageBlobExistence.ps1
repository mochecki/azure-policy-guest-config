function Test-StorageBlobExistence {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)]
        [string]$SubscriptionId,

        [Parameter(Mandatory=$true)]
        [string]$ResourceGroupName,

        [Parameter(Mandatory=$true)]
        [string]$StorageAccountName,

        [Parameter(Mandatory=$true)]
        [string]$ContainerName,

        [Parameter(Mandatory=$true)]
        [string]$JsonFilePath,

        [Parameter(Mandatory=$true)]
        [string]$TenantId,

        [Parameter(Mandatory=$true)]
        [string]$ClientId,

        [Parameter(Mandatory=$true)]
        [string]$ClientSecret
    )

    $blobExists = Get-AzStorageBlob -Context $context -Container $ContainerName -Blob $BlobName -ErrorAction SilentlyContinue
    if ($blobExists) {
        return $true
    }
    else {
        return $false
    }
}
