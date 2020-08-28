$VMName = 'Test'

$NewVMParam = @{

  Name = $VMName

  MemoryStartUpBytes = 1GB

  Path = "C:\ProgramData\Microsoft\Windows\Hyper-V"

  #SwitchName =  "Internal"

  NewVHDPath =  "C:\Users\Public\Documents\Hyper-V\Virtual  Hard Disks\MS01B.vhdx"

  NewVHDSizeBytes =  20GB 

  ErrorAction =  'Stop'

  Verbose =  $True

  }

  $SetVMParam = @{

  ProcessorCount =  1

  DynamicMemory =  $True

  MemoryMinimumBytes =  512MB

  MemoryMaximumBytes =  1Gb

  ErrorAction =  'Stop'

  PassThru =  $True

  Verbose =  $True

  }

  $NewVHDParam = @{

  Path = 'C:\Users\Public\Documents\Hyper-V\Virtual Hard  Disks\MS01B_Data.vhdx'

  Dynamic =  $True

  SizeBytes =  60GB

  ErrorAction =  'Stop'

  Verbose =  $True

  }

  $AddVMHDDParam = @{

  Path = 'C:\Users\Public\Documents\Hyper-V\Virtual Hard  Disks\MS01B_Data.vhdx'

  ControllerType =  'SCSI'

  ControllerLocation =  1

  }

  $VMDVDParam = @{

  VMName =  $VMName

  Path = 'c:\Users\abrailko\Documents\server_win.iso'

  ErrorAction =  'Stop'

  Verbose =  $True

  }

  $AddVMNICParam = @{

  SwitchName =  'External'

  }

$pc = 'dvnlap179'


    New-VM -ComputerName $pc @NewVMParam 
    Set-VM -ComputerName $pc -Name $VMName @SetVMParam 
    New-VHD -ComputerName $pc -Name $VMName @NewVHDParam
    Add-VMHardDiskDrive -ComputerName $pc -Name $VMName @AddVMHDDParam
    Set-VMDvdDrive -ComputerName $pc -Name $VMName @VMDVDParam 
    Add-VMNetworkAdapter -Name $VMName @AddVMNICParam 
    Start-VM -ComputerName $pc -Name $VMName -Verbose
    #Start-VM

#$script = { Get-VM -Name $VMName}

#$cred = Get-Credential -Credential quietdvn\abrailko
#Invoke-command -ComputerName $pc -Credential $cred -ScriptBlock {$script}

#New-VM -ComputerName $pc @NewVMParam 