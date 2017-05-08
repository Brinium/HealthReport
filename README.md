# HealthReport
Health Report built with powershell

Create Scripts to produce a report summary.
Save them in \Scripts folder like "/src/Scripts/Func_TestReportScript.ps1"

For each report script add them to the following function in "/src/App_HealthCheckReport.ps1"

```
function Get-ReportScriptList()
{
    $scripts = New-Object "System.Collections.Generic.List``1[Tenix.HealthCheck.ReportScript]";

    $scripts.Add((New-Object Tenix.HealthCheck.ReportScript("Test1", "Test", "$PSScriptRoot\Scripts\Func_TestReportScript.ps1", $false)));
    $scripts.Add((New-Object Tenix.HealthCheck.ReportScript(...,...,"$PSScriptRoot\Scripts\....ps1")));

    return $scripts;
}
```

Note: Curently the email report html displays badly in Outlook. I still need to write IE5 compatable CSS so that this displays correctly.
