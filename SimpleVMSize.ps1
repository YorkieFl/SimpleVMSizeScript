$results = @()
Get-VM | ForEach-Object {
  $vm = $_
  Get-VMHardDiskDrive -VMName $vm.Name | ForEach-Object {
    $vhd = Get-VHD $_.Path
    $results += New-Object PSObject -Property @{
      "Virtual Machine" = $vm.Name
      "VHD Name" = $vhd.Path
      "VHD Size (GB)" = [Math]::Round($vhd.FileSize/1GB, 2)
      "VHD Size Used (GB)" = [Math]::Round($vhd.Size/1GB, 2)
      "VHD Type" = if ($vhd.Dynamic) { "Dynamically Expanding" } else { "Fixed" }
    }
  }
}
$results | Format-Table
