param (
	[Parameter(Mandatory=$true,Position=1)]
    [System.Collections.Generic.List``1[HealthCheck.ReportItem]]$reports,
	[Parameter(Mandatory=$true,Position=2)]
    [string]$filePath
 )

 ."$PSScriptRoot\Lib_ReportClasses.ps1"
 ."$PSScriptRoot\Lib_HtmlSupport.ps1"
  
# Assemble the HTML Header and CSS for our Report
$htmlDefinition = Get-HtmlIe8Definition;

$htmlHeader = Get-HtmlIe8Header-WithCss;

$htmlReport = Get-ReportHtml $reports;
    
$htmlFooter = Get-HtmlFooter;

$htmlMessage = $htmlDefinition + $htmlHeader + $htmlReport + $htmlFooter

# Save the report out to a file in the current path
Write-ReportHtmlFile $htmlMessage $filePath
