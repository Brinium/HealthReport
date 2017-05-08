param (
	[Parameter(Mandatory=$true)]
    [string]$identifier,
	[Parameter(Mandatory=$true)]
    [System.Collections.Generic.List``1[HealthCheck.ReportItem]]$reports
 )

 ."$PSScriptRoot\..\Lib_ReportClasses.ps1"
 ."$PSScriptRoot\..\Lib_SqlServer.ps1"

$jobTags = "ErrRC01","SecPayIRCA","SecPayIRCS","SecPayIRCT","Sam";
$server = "MELSQLV02";
$database = "NovaPark_Std_PRD";

$connectionString = "Server=$server;Database=$database;Trusted_Connection=True;";
$query = @"
 SELECT jq.[JobQueueID]
      ,jq.[QueueTag]
      ,jq.[JobTag]
      ,jq.[Description]
      ,jq.[Executable]
      ,jq.[DependentOn]
      ,jq.[Status]
      ,jq.[Started]
      ,jq.[Finished]
FROM [dbo].[JobQueue] AS jq
INNER JOIN 
(  
  SELECT
        [JobTag]
        ,MAX([Started]) AS LastStarted
  FROM [dbo].[JobQueue]
  WHERE [JobTag] IN ('$($jobTags -join "','")')
  GROUP BY [JobTag]
) AS ljq ON jq.[JobTag] = ljq.[JobTag] AND jq.[Started] = ljq.[LastStarted]
"@

$report = New-Object HealthCheck.ReportItem;
$report.DisplayName = "Vic Scheduler Jobs";
$report.Description = "Check if Vic Job have run successfully";
$report.LogLocation = "";
$report.DateRan = [DateTime]::Now;
$report.Health = [HealthCheck.Status]::Success;
$report.SubItems = [HealthCheck.ReportSubItem[]]@();

try
{
    $jobs = (Invoke-Query -query $query -connectionString $connectionString);

    foreach($jobTag in $jobTags) 
    {
        $sub = New-Object HealthCheck.ReportSubItem;
        $sub.DisplayName = "$jobTag";
        $sub.Description = "$jobTag conditions have not yet been tested";
        $sub.DateRan = [DateTime]::Now;
        $sub.Health = [HealthCheck.Status]::Warning;

        $item = $jobs | ? {$_.JobTag -eq $jobTag};
        if($item)
        {
            if(-not $item.Finished)
            {
                $sub.Description = "$jobTag was started but not finished. Started: $($item.Started). Status: $($item.Status)";
                $sub.Health = [HealthCheck.Status]::Error;
                $report.Health = [HealthCheck.Status]::Error;
            }
            elseif($item.Finished -and $item.Finished -lt [DateTime]::Now.AddDays(-1))
            {
                $sub.Description = "$jobTag was started and finished, but not in the last 24 hours. Started: $($item.Started). Finished: $($item.Finished). Status: $($item.Status)";
                $sub.Health = [HealthCheck.Status]::Error;
                $report.Health = [HealthCheck.Status]::Error;
            }
            elseif(-not ($item.Status) -or $item.Status -ne 255)
            {
                $sub.Description = "$jobTag was started but not finished, but not successfully. Started: $($item.Started). Finished: $($item.Finished). Status: $($item.Status)";
                $sub.Health = [HealthCheck.Status]::Error;
                $report.Health = [HealthCheck.Status]::Error;
            }
            else
            {
                $sub.Description = "$jobTag was started and finished successfully. Started: $($item.Started). Finished: $($item.Finished). Status: $($item.Status)";
                $sub.Health = [HealthCheck.Status]::Success;
            }
        }
        else
        {
            $sub.Description = "$jobTag has not been started";
            $sub.Health = [HealthCheck.Status]::Error;
            $report.Health = [HealthCheck.Status]::Error;
        }
        $report.SubItems.Add($sub) | Out-Null;
    }
            
}
catch
{
    Write-Warning "Error querying database"
    Write-Error $_;
    $report.Description = "$_";
    $report.Health = [HealthCheck.Status]::Error;
    exit;
}


$reports.Add($report);

