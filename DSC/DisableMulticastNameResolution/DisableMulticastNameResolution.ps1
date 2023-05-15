<#
    .SYNOPSIS
        If the registry key value EnableMulticast under the key
        'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' does not exist,
        creates it with the DWord value 1 (Disabled).

        If the registry key value EnableMulticast under the key
        'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' already exists,
        overwrites it with the DWord value 1 (Disabled).
#>
Configuration DisableMulticastNameResolution
{
    Import-DscResource -ModuleName 'PSDscResources'

    Node localhost
    {
        Registry DNSClientEnableMulticast
        {
            Key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient'
            Ensure = 'Present'
            ValueName = 'EnableMulticast'
            ValueType = 'DWord'
            ValueData = '1'
            Force = $true
        }
    }
}

DisableMulticastNameResolution