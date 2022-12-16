$Prefix = ".xx_"
$VMName = "Odin"
$User = "xxx"
$Path = "C:\Users\$User\_VM"
$Hori = 2560
$Vert = 1440
$CPU = 2
$Mem = 2048MB
$Size = 64GB
$OS = "ubuntu-22.04.1-live-server-amd64.iso"

$VM = @{
    VMName = $VMName
    Path = $Path
    Version = "10.0"
    Generation = 2
    MemoryStartupBytes = $Mem
    SwitchName = "External"
    NewVHDPath = "$Path\$VMName\Virtual Hard Disks\$VMName.vhdx"
    NewVHDSizeBytes = $Size
}
New-VM @VM

$CD = @{
    VMName = $VMName
    Path = "$Path\$OS"
}
Add-VMDvdDrive @CD

$FW = @{
    VMName = $VMName
    EnableSecureBoot = "Off"
    BootOrder = (Get-VMFirmware $VMName).BootOrder[2], #DVD
                (Get-VMFirmware $VMName).BootOrder[1], #HDD
                (Get-VMFirmware $VMName).BootOrder[0]  #PXE
}
Set-VMFirmware @FW

$VID = @{
    VMName = $VMName
    HorizontalResolution = $Hori
    VerticalResolution = $Vert
    ResolutionType = "Single"
}
Set-VMVideo @VID

$SET = @{
    VMName = $VMName
    StaticMemory = $true
    ProcessorCount = $CPU
    CheckpointType = "Disabled"
    AutoMaticStartAction = "Nothing"
    AutomaticStopAction = "Shutdown"
    NewVMName = "$Prefix$VMName"
}
Set-VM @SET

Start-VM -VMName "$Prefix$VMName"
