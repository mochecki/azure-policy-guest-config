function Get-Configurations {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [string] $file
    )

    $configFile = Get-Content -Path $file | ConvertFrom-Json

    return $configFile.configurations
}