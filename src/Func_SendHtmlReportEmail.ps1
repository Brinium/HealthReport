param (
	[Parameter(Mandatory=$true,Position=0)]
    [System.Collections.Generic.List``1[Tenix.HealthCheck.ReportItem]]$reports,
    [Parameter(Mandatory=$true,
               Position = 1,
               HelpMessage="Email subject")]
    [String]$subject,    
    [Parameter(Mandatory=$true,
               Position = 2,
               HelpMessage="To email addresses")]    
    [String[]]$to = "user@domain.com",
    [Parameter(Mandatory=$true,
               Position = 3,
               HelpMessage="From email address")]    
    [String]$from = "Admin@domain.com",
    [Parameter(Mandatory=$true,
               Position = 4,
               HelpMessage="Smtp email server")]   
    [String]$smtpServer ="smtprelay.domain.com"
 )

 ."$PSScriptRoot\Lib_ReportClasses.ps1"
 ."$PSScriptRoot\Lib_HtmlSupport.ps1"
  
# Assemble the HTML Header and CSS for our Report
$htmlHeader = Get-HtmlHeader;

$htmlReport = Get-ReportHtml $reports;
    
$htmlFooter = Get-HtmlFooter;

$htmlMessage = $htmlHeader + $htmlReport + $htmlFooter
# Save the report out to a file in the current path

$args = @{
    To         =$to
    Body       =$htmlMessage
    Subject    =$subject
    SmtpServer =$smtpServer
    From       =$from
    BodyAsHtml =$True
    }
Send-MailMessage @args