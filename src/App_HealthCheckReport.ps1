."$PSScriptRoot\Lib_ReportClasses.ps1";

#region Variables and Arguments
$emailTo = "user@email.com"; # List of users to email your report to (separate by comma)
$emailFrom = "no_reply";
$emailServer = "email.com"; #enter your own SMTP server DNS name / IP address here
$emailSubject = "Health Report"

$htmlFilePath = "$PSScriptRoot\report.html";

function Get-ReportScriptList()
{
    $scripts = New-Object "System.Collections.Generic.List``1[Tenix.HealthCheck.ReportScript]";

    $scripts.Add((New-Object Tenix.HealthCheck.ReportScript("Test1", "Test", "H:\Sam\Code\Powershell\HealthReport\Scripts\Func_TestReportScript.ps1", $false)));

    return $scripts;
}

function Run-Script()
{
    PARAM
    (
		[Parameter(Mandatory=$true)]
        [Tenix.HealthCheck.ReportScript]$script,
		[Parameter(Mandatory=$true)]
        [System.Collections.Generic.List``1[Tenix.HealthCheck.ReportItem]]$reports
    )
    
    &"$($script.Location)"  "$($script.Id)" $reports
}

function Display-Report
{
    PARAM
    (
		[Parameter(Mandatory=$true)]
        [System.Collections.Generic.List``1[Tenix.HealthCheck.ReportItem]]$reports
    )

    $saveHtmlFileScript = "$PSScriptRoot\Func_SaveHtmlReportFile.ps1";
    &"$saveHtmlFileScript" $reports $htmlFilePath;    

    $emailScript = "$PSScriptRoot\Func_SendHtmlReportEmail.ps1";
    &"$emailScript" $reports $emailSubject $emailTo $emailFrom $emailServer;    
}

$reports = New-Object "System.Collections.Generic.List``1[Tenix.HealthCheck.ReportItem]";
$reports.Add((New-Object Tenix.HealthCheck.ReportItem -Property @{ DisplayName="Health Check Report"; DateRan = [System.DateTime]::Now }))

$scripts = Get-ReportScriptList;

foreach($script in $scripts)# | where $_.CanRunConcurrent -eq $false))
{
    Run-Script -script $script $reports;
}

$reports.RemoveAt(0);

$reports | Format-Table

Display-Report -reports $reports
