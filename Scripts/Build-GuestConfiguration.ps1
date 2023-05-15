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
)

. "$PSScriptRoot/Helpers/Get-Folders.ps1"
. "$PSScriptRoot/Helpers/Get-Configurations.ps1"


$InformationPreference = 'Continue'

Install-Module PSDesiredStateConfiguration -Force
Install-Module PSDscResources -Force
Install-Module GuestConfiguration -Force

. "$PSScriptRoot/../customDscResources/DscNicNetbios/Helpers.ps1"
. "$PSScriptRoot/../customDscResources/DscWindowsFeature/Helpers.ps1"

#Get-Module -ListAvailable

$folders = Get-Folders

Write-Information ""
Write-Information "==================================================================================================="
Write-Information "Read global settings from '$($folders.configurationFile)'."
Write-Information "==================================================================================================="

$configurations = Get-Configurations $folders.configurationFile

Write-Information "Configuration counts: $($configurations.Count)"
Write-Information "Output folder: $($folders.outputFolder)"
Write-Information ""


Write-Information ""
Write-Information "==================================================================================================="
Write-Information "Processing $($configurations.Count) configurations"
Write-Information "==================================================================================================="
Write-Information ""


$plan = [System.Collections.ArrayList]::new()

foreach ($configuration in $configurations) {
    
    Write-Information "- Configuration: $($configuration.name)  Version: $($configuration.version)"

    $configurationFolder = Join-Path $folders.definitionsRootFolder $configuration.name
    $configurationScript = Join-Path $configurationFolder $configuration.file
    if (Test-Path $configurationScript) {



        $null = . $configurationScript
        $compileOutput = & $configuration.name -OutputPath $configurationFolder
        $configuration | Add-Member -NotePropertyName "MOF" -NotePropertyValue $compileOutput

        $package = New-GuestConfigurationPackage -Name $configuration.name -Version $configuration.version -Configuration $configuration.MOF -Type $configuration.type -Force -Path $folders.outputFolder
        
        $addedEntry = @{
            name    = $configuration.name
            version = $configuration.version
            type    = $configuration.type
            package = Split-Path $package.Path -Leaf
        } 
        $null = $plan.Add($addedEntry)

    } else {
        Write-Warning "     [Warning] Path not found: $path"
        Write-Warning "     [Warning] Skipping configuration"
    }
}

$planFile =  "$($folders.outputFolder)/configuration-plan.json"
if ($plan.Count -gt 0) {
    Write-Information "   DSC package deployment required; writing Policy plan file '$planFile'"
    if (-not (Test-Path $planFile)) {
        $null = (New-Item $planFile -Force)
    }
    $null = $plan | ConvertTo-Json -Depth 100 | Out-File -FilePath $planFile -Force
}
else {
    if (Test-Path $planFile) {
        $null = (Remove-Item $planFile)
    }
    Write-Information "    Skipping DSC package deployment stage/step - no changes"
}

