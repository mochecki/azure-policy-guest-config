enum Ensure {
    Absent
    Present
}

[DscResource()]
class DscWindowsFeature {
    [DscProperty(Key)]
    [string] $FeatureName

    [DscProperty()]
    [Ensure] $Ensure

    [DscWindowsFeature] Get() {
        $this.SetPath()
        $features = $this.FeatureName.Split(",")
        $counter = 0
        $status = Get-WindowsFeature -Name $features
        foreach ($s in $status) {
            switch ($s.InstallState) {
                "Installed" { $this.Ensure = [Ensure]::Present }
                default { $counter++ }
            }
        }
        if ($counter -gt 0) {
            $this.Ensure = [Ensure]::Absent
        }
        return $this
    }
    
    [void] Set() {
        $this.SetPath()
        $features = $this.FeatureName.Split(",")
        if ($this.Ensure -eq "Present") {
            Install-WindowsFeature -Name $features -Verbose
        }
        else {
            Uninstall-WindowsFeature -Name $features -Remove -Verbose
        }
    }
    
    [bool] Test() {
        $this.SetPath()
        $features = $this.FeatureName.Split(",")
        $counter = 0
        $status = Get-WindowsFeature -Name $features

        if ($this.Ensure -eq "Present") {
            foreach ($s in $status) {
                switch ($s.InstallState) {
                    "Installed" {}
                    default { $counter++ }
                }
            }
        }
        
        if ($this.Ensure -eq "Absent") {
            foreach ($s in $status) {
                switch ($s.InstallState) {
                    "Removed" {}
                    default { $counter++ }
                }
            }
        }        
        
        if ($counter -gt 0) {
            return $false
        }
        return $true
    }

    [void] SetPath() {
        $env:PSModulePath += ";C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules"
    }
}