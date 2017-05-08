function Test-AssemblyLoaded { 
    Param(
        [parameter(Mandatory=$true)]
        [string]$assemblyName,
        [parameter(Mandatory=$true)]
        [System.IO.FileInfo]$assemlbyFile,
        [bool]$report = $false
    ) 

    $assembly = [System.AppDomain]::CurrentDomain.GetAssemblies() | Where {$_ -match $assemblyName};
    if($assembly -eq $null)
    {
        if($report) {
            Write-Output "Loading $AssemblyName assembly.";
            [Reflection.Assembly]::LoadFile($assemlbyFile) | Format-List;
        }
        else
        {
            [Reflection.Assembly]::LoadFile($assemlbyFile);
        }
    }
}