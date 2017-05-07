param (
	[Parameter(Mandatory=$true)]
    [string]$identifier,
	[Parameter(Mandatory=$true)]
    [System.Collections.Generic.List``1[Tenix.HealthCheck.ReportItem]]$reports
 )

 ."$PSScriptRoot\..\Lib_ReportClasses.ps1"

$report = New-Object Tenix.HealthCheck.ReportItem;
$report.DisplayName = "Test 1";
$report.Description = "Test 1 Description";
$report.LogLocation = "C:\temp\HealthReport\Logs\test1.txt";
$report.DateRan = [DateTime]::Now;
$report.Health = [Tenix.HealthCheck.Status]::Warning;
$report.SubItems = [Tenix.HealthCheck.ReportSubItem[]]@();
 
$sub = New-Object Tenix.HealthCheck.ReportSubItem;
$sub.DisplayName = "Sub 1";
$sub.Description = "Sub 1 Description";
$sub.LogLocation = "C:\temp\HealthReport\Logs\testsub1.txt";
$sub.DateRan = [DateTime]::Now.AddDays(-1);
$sub.Health = [Tenix.HealthCheck.Status]::Success;
$report.SubItems.Add($sub) | Out-Null;

$sub = New-Object Tenix.HealthCheck.ReportSubItem;
$sub.DisplayName = "Sub 2";
$sub.Description = "Sub 2 Description";
$sub.LogLocation = "";
$sub.DateRan = [DateTime]::Now.AddDays(-1);
$sub.Health = [Tenix.HealthCheck.Status]::Warning;
$report.SubItems.Add($sub) | Out-Null;

$sub = New-Object Tenix.HealthCheck.ReportSubItem;
$sub.DisplayName = "Sub 3";
$sub.Description = "Sub 3 Description";
$sub.LogLocation = "C:\temp\HealthReport\Logs\testsub3.txt";
$sub.DateRan = [DateTime]::Now.AddDays(-1);
$sub.Health = [Tenix.HealthCheck.Status]::Error;
$report.SubItems.Add($sub) | Out-Null;

$reports.Add($report);

$report2 = New-Object Tenix.HealthCheck.ReportItem;
$report2.DisplayName = "Test 2";
$report2.Description = "Test 2 Description";
$report2.LogLocation = "C:\temp\HealthReport\Logs\test2.txt";
$report2.DateRan = [DateTime]::Now;
$report2.Health = [Tenix.HealthCheck.Status]::Success;
$report2.SubItems = [Tenix.HealthCheck.ReportSubItem[]]@();

$sub = New-Object Tenix.HealthCheck.ReportSubItem;
$sub.DisplayName = "Test 2 Sub 1";
$sub.Description = "Test 2 Sub 1 Description";
$sub.LogLocation = "C:\temp\HealthReport\Logs\testsub1.txt";
$sub.DateRan = [DateTime]::Now.AddDays(-1);
$sub.Health = [Tenix.HealthCheck.Status]::Success;
$report2.SubItems.Add($sub) | Out-Null;

$reports.Add($report2);

$report3 = New-Object Tenix.HealthCheck.ReportItem;
$report3.DisplayName = "Test 3";
$report3.Description = "Test 3 Description";
$report3.LogLocation = "C:\temp\HealthReport\Logs\test2.txt";
$report3.DateRan = [DateTime]::Now;
$report3.Health = [Tenix.HealthCheck.Status]::Success;
$report3.SubItems = [Tenix.HealthCheck.ReportSubItem[]]@();

$sub = New-Object Tenix.HealthCheck.ReportSubItem;
$sub.DisplayName = "Test 3 Sub 1";
$sub.Description = "Test 3 Sub 1 Description";
$sub.LogLocation = "C:\temp\HealthReport\Logs\testsub1.txt";
$sub.DateRan = [DateTime]::Now.AddDays(-1);
$sub.Health = [Tenix.HealthCheck.Status]::Success;
$report3.SubItems.Add($sub) | Out-Null;

$reports.Add($report3);

