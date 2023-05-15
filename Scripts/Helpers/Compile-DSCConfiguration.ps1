function Compile-DSCConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)] [string] $file,
        [Parameter(Mandatory = $true)] [string] $output
    )

    $configFile = Get-Content -Path $file | ConvertFrom-Json

    return $configFile.configurations
}