$src = "C:\Users\abrailko.QUIETDVN\Downloads\server_win.iso" 

$pc = 'dvnlap179'
#$cred = Get-Credential -Credential quietdvn\abrailko
$file_location = 'c:\Users\abrailko\Documents'
$VM_name = 'Test'
$pc = 'dvnlap179'
$virt_HD = 'C:\Users\Public\Documents\Hyper-V\Virtual Hard  Disks\MS01B_Data.vhdx'
$VHDPath = "C:\Users\Public\Documents\Hyper-V\Virtual  Hard Disks\MS01B.vhdx"

function Remove-MyVM {

    $Exists = get-vm -ComputerName $pc -name $VM_name -ErrorAction SilentlyContinue  
    write $Exists "++++++++++"
    If ($Exists){  
     Write "VM is there"  
     Stop-VM -ComputerName $pc -Name $VMName -Force
     Invoke-Command -ComputerName $pc -ScriptBlock {Remove-Item -Path "C:\Users\Public\Documents\Hyper-V\Virtual  Hard Disks\MS01B.vhdx" -Force}
     Invoke-Command -ComputerName $pc -ScriptBlock {Remove-Item -Path 'C:\Users\Public\Documents\Hyper-V\Virtual Hard  Disks\MS01B_Data.vhdx' -Force}
     Remove-VMHardDiskDrive -ComputerName $pc -VMName $VM_Name  -ControllerType 'SCSI' -ControllerLocation 1 -ControllerNumber 1
     Remove-VM -ComputerName $pc -Name $VM_Name -Force
    }  
    Else {  
     Write "VM not there"  
      Invoke-Command -ComputerName $pc -ScriptBlock {Remove-Item -Path "C:\Users\Public\Documents\Hyper-V\Virtual  Hard Disks\MS01B.vhdx" -Force}
    }  
    
  
    #$tmp = Get-VM -ComputerName $pc -Name $VM_Name
    
    #Invoke-Command -ComputerName $pc -ScriptBlock {Remove-Item $VHDPath}
    
  


    
    
}

function Create-MyVM {
    param (
        $VM_name
    )

   

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
  $VM_name
  $SetVMParam = @{

  Name = $VM_name

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

  SizeBytes =  30GB

  ErrorAction =  'Stop'

  Verbose =  $True

  }

  $AddVMHDDParam = @{

  Path = 'C:\Users\Public\Documents\Hyper-V\Virtual Hard  Disks\MS01B_Data.vhdx'

  ControllerType =  'SCSI'

  ControllerLocation =  1

  }

  $VMDVDParam = @{

  VMName =  $VM_name

  Path = 'c:\Users\abrailko\Documents\server_win.iso'

  ErrorAction =  'Stop'

  Verbose =  $True

  }

  $AddVMNICParam = @{

  Name = $VM_name

  SwitchName =  'External'

  }

$pc = 'dvnlap179'
$SetVMParam | ForEach-Object { $_}

    $VM = New-VM -ComputerName $pc @NewVMParam 
    Set-VM  -ComputerName $pc @SetVMParam 
    New-VHD -ComputerName $pc @NewVHDParam
    Add-VMHardDiskDrive -ComputerName $pc -VMName $VM_name @AddVMHDDParam
    Set-VMDvdDrive -ComputerName $pc @VMDVDParam 
    Add-VMNetworkAdapter -ComputerName $pc -VMName $VM_name @AddVMNICParam 
    Start-VM -ComputerName $pc -Name $VM_name -Verbose
}

function Stop-MyVM {
    Stop-VM -ComputerName $pc -Name $VMName
}


function Show-Menu {
    param (
        [string]$title = 'My Menu'
    )

    #Clear-Host
    Write-Output "=================MENU==================="
    Write-Output "1: Press '1' to Remove VM"
    Write-Output "2: Press '2' to Setup VM"
    Write-Output "3: Press '3' to Stop VM"
    Write-Output "4: Press 'q' to quit"

}

do{
    Show-Menu
    $input = Read-Host 'Make a selection'
    switch($input){
        '1' {Remove-MyVM}
        '2' {Create-MyVM ($VM_name)}
    }

} until ($input -eq 'q')