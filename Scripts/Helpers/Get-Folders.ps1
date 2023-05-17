function Get-Folders {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)] [string] $definitionsRootFolder,
        [Parameter(Mandatory = $false)] [string] $outputFolder,
        [Parameter(Mandatory = $false)] [string] $inputFolder
    )

    if ($definitionsRootFolder -eq "") {
        if ($null -eq $env:DSC_DEFINITIONS_FOLDER) {
            $definitionsRootFolder = "$PSScriptRoot/../../DSC"
        }
        else {
            $definitionsRootFolder = $env:DSC_DEFINITIONS_FOLDER
        }
    }
    $configurationFile = "$definitionsRootFolder/configuration.jsonc"

    if ($outputFolder -eq "") {
        if ($null -eq $env:DSC_OUTPUT_FOLDER) {
            $outputFolder = "$PSScriptRoot/../../Output"
        }
        else {
            $outputFolder = $env:DSC_OUTPUT_FOLDER
        }
    }
    
    $outputConfigurationFile = "$outputFolder/configuration-plan.json"

    if ($inputFolder -eq "") {
        if ($null -eq $env:DSC_INPUT_FOLDER) {
            $inputFolder = $outputFolder
        }
        else {
            $inputFolder = $env:DSC_INPUT_FOLDER
        }
    }

    $folders = @{
        definitionsRootFolder = $definitionsRootFolder
        configurationFile    = $configurationFile
        outputConfigurationFile = $outputConfigurationFile
        outputFolder          = $outputFolder
        inputFolder           = $inputFolder
    }

    return $folders
}