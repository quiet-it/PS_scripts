$pc = 'dvnlap179'
if ($cred -eq $null){
    Invoke-Command -ComputerName $pc -Credential $cred -ScriptBlock {$args[0]}
} else{
 $cred = Get-Credential -Credential quietdvn\abrailko
}


#function Exec{
   # param (
   #     $args
   # )

 
#}