enum Ensure {
    Enabled
    Disabled
}

[DscResource()]
class DscNicNetbios {
    [DscProperty(Key)]
    [string] $RegistryPath

    [DscProperty()]
    [Ensure] $Ensure

    hidden [DscNicNetbios] $CachedCurrentState

    [DscNicNetbios] Get() {
        $CurrentState = [DscNicNetbios]::new()
        $CurrentState.RegistryPath = $this.RegistryPath
        $CurrentState.Ensure = $this.Ensure
        $this.CachedCurrentState = $CurrentState
        $path = $this.RegistryPath.Insert(0,"Registry::")
        $currentNicSettings = Get-ChildItem -Path $path
        [int[]]$configObj = @()      
        foreach ($nicSetting in $currentNicSettings) {
            $tmp = $nicSetting.Name.Insert(0,"Registry::")
            $netbiosTmp = Get-ItemProperty -Path $tmp
            $configObj += $netbiosTmp.NetbiosOptions           
        }

        switch ($configObj) {
            2 { $CurrentState.Ensure = [Ensure]::Disabled }
			default { $CurrentState.Ensure = [Ensure]::Enabled }
        }

        $this.CachedCurrentState = $CurrentState
        return $CurrentState
    }
    
    [bool] Test() {
        $counter = 0
        $path = $this.RegistryPath.Insert(0,"Registry::")
        $currentNicSettings = Get-ChildItem -Path $path     
        foreach ($nicSetting in $currentNicSettings) {
            $tmp = $nicSetting.Name.Insert(0,"Registry::")
            $netbiosTmp = Get-ItemProperty -Path $tmp
            if ($netbiosTmp.NetbiosOptions -ne 2) {
                $counter++
            }                       
        }

        if ($counter -eq 0 -and $this.Ensure -eq "Disabled")
        {
            return $true
        }
        elseif ($counter -eq 0 -and $this.Ensure -eq "Enabled") {
            return $false
        }
        elseif ($counter -gt 0 -and $this.Ensure -eq 'Enabled') {
            return $true
        }
        elseif ($counter -gt 0 -and $this.Ensure -eq "Disabled") {
            return $false
        }
        else {
            return $false
        }
    }

    [void] Set() {
        $path = $this.RegistryPath.Insert(0,"Registry::")
        $currentNicSettings = Get-ChildItem -Path $path
        if ($this.Ensure -eq "Disabled") {
            foreach ($nicSetting in $currentNicSettings) {
                $tmp = $nicSetting.Name.Insert(0,"Registry::")
                Set-ItemProperty -Path $tmp -Name NetbiosOptions -Value 2 -Verbose
            }
        }
        else {
            foreach ($nicSetting in $currentNicSettings) {
                $tmp = $nicSetting.Name.Insert(0,"Registry::")
                Set-ItemProperty -Path $tmp -Name NetbiosOptions -Value 1 -Verbose
            }
        }
    }
}