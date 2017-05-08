."$PSScriptRoot\Lib_ReportClasses.ps1";

#region Variables and Arguments
$emailTo = "user@email.com"; # List of users to email your report to (separate by comma)
$emailFrom = "no_reply";
$emailServer = "email.com"; #enter your own SMTP server DNS name / IP address here
$emailSubject = "Health Report"

$htmlFilePath = "$PSScriptRoot\report.html";

function Get-ScriptToRun()
{
    $scripts = New-Object "System.Collections.Generic.List``1[HealthCheck.ReportScript]";

    $scripts.Add((New-Object HealthCheck.ReportScript("Test1", "Test", "$PSScriptRoot\Scripts\Func_TestReportScript.ps1", $false)));

    return $scripts;
}

function Run-Script()
{
    PARAM
    (
		[Parameter(Mandatory=$true)]
        [HealthCheck.ReportScript]$script,
		[Parameter(Mandatory=$true)]
        [System.Collections.Generic.List``1[HealthCheck.ReportItem]]$reports
    )
    
    Write-Host "Run Script `"$($script.DisplayName)`""
    &"$($script.Location)"  "$($script.Id)" $reports
}

function Display-Report
{
    PARAM
    (
		[Parameter(Mandatory=$true)]
        [System.Collections.Generic.List``1[HealthCheck.ReportItem]]$reports
    )

    Write-Host "Save Html File $htmlFilePath"
    $saveHtmlFileScript = "$PSScriptRoot\Func_SaveHtmlReportFile.ps1";
    &"$saveHtmlFileScript" $reports $htmlFilePath;    

    Write-Host "Send email"
    $emailScript = "$PSScriptRoot\Func_SendHtmlReportEmail.ps1";
    #&"$emailScript" $reports $emailSubject $emailTo $emailFrom $emailServer;    
}

$reports = New-Object "System.Collections.Generic.List``1[HealthCheck.ReportItem]";
$reports.Add((New-Object HealthCheck.ReportItem -Property @{ DisplayName="Health Check Report"; DateRan = [System.DateTime]::Now }))

$scripts = Get-ScriptToRun;

foreach($script in $scripts)# | where $_.CanRunConcurrent -eq $false))
{
    Run-Script -script $script $reports;
}

$reports.RemoveAt(0);

$reports | Format-Table

Display-Report -reports $reports
