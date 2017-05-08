 ."$PSScriptRoot\Lib_ReportClasses.ps1"

function Get-HtmlIe8Definition
{
    $css = @"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
"@;
    return $css;
}

function Get-HtmlIe8Css
{
    $css = @"
    
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        #report {
            width: 650px;
        }

        table {
            color: #4d4d4d;
            font-size: 12px;
            background: #eaebec;
            border-collapse: collapse;
        }

            table.group {
                width: 100%;
                margin: 20px;
                -moz-border-radius: 3px;
                -webkit-border-radius: 3px;
                border-radius: 3px;
                border: #808080 1px solid;
                padding: 0;
            }

            table.content {
                width: 100%;
                margin: 0px;
            }

            table tr {
                border: none;
            }
                table tr.group-detail {
                    border-top: #808080 2px solid;
                }

                table tr.group-content {
                    padding: 0;
                }

                table tr.group-content, table tr.content-log {
                    background: #fafafa;
                }


            table th {
                text-align: center;
                border: none;
                padding: 5px 9px 5px 9px;
                background: #ededed;
            }

                table th:first-child {
                    text-align: left;
                }

            table td {
                text-align: center;
                padding-top: 4px;
                padding-right: 0;
                padding-bottom: 2px;
                border: none;
            }

            table td.group-content {
                text-align: center;
                padding-top: 0;
                padding-right: 0;
                padding-bottom: 0;
                border: none;
            }

                table td:first-child {
                    text-align: left;
                    padding-left: 6px;
                }

            table td p {
                margin-top: 5px;
                margin-bottom: 5px
            }

            .group-detail, .content-detail {
                font-weight: bold;
            }

            .Success {
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=85)"; /* IE 8 */
                filter: alpha(opacity=85); /* IE 5-7 */
                -moz-opacity: 0.85; /* Netscape */
                -khtml-opacity: 0.85; /* Safari 1.x */
                opacity: 0.85; /* Good browsers */
                background: #5DE61C;
            }

            .Warning {
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=95)"; /* IE 8 */
                filter: alpha(opacity=95); /* IE 5-7 */
                -moz-opacity: 0.95; /* Netscape */
                -khtml-opacity: 0.95; /* Safari 1.x */
                opacity: 0.95; /* Good browsers */
                background: #E6A51C;
            }

            .Error {
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=85)"; /* IE 8 */
                filter: alpha(opacity=85); /* IE 5-7 */
                -moz-opacity: 0.85; /* Netscape */
                -khtml-opacity: 0.85; /* Safari 1.x */
                opacity: 0.85; /* Good browsers */
                background: #E6401C;
            }

"@;
    return $css;
}

function Get-HtmlIe5Css
{
    $css = @"
    
        body {
            font-family: Arial, Helvetica, sans-serif;
        }

        #report {
            width: 650px;
        }

        table {
            color: #4d4d4d;
            font-size: 12px;
            background: #eaebec;
            border-collapse: collapse;
        }

            table.group {
                width: 100%;
                margin: 20px;
                -moz-border-radius: 3px;
                -webkit-border-radius: 3px;
                border-radius: 3px;
                border: #808080 1px solid;
                padding: 0;
            }

            table.content {
                width: 100%;
                margin: 0px;
            }

            table tr {
                border: none;
            }
                table tr.group-detail {
                    border-top: #808080 2px solid;
                }

                table tr.group-content {
                    padding: 0;
                }

                table tr.group-content, table tr.content-log {
                    background: #fafafa;
                }


            table th {
                text-align: center;
                border: none;
                padding: 5px 9px 5px 9px;
                background: #ededed;
            }

                table th:first-child {
                    text-align: left;
                }

            table td {
                text-align: center;
                padding-top: 4px;
                padding-right: 0;
                padding-bottom: 2px;
                border: none;
            }

            table td.group-content {
                text-align: center;
                padding-top: 0;
                padding-right: 0;
                padding-bottom: 0;
                border: none;
            }

                table td:first-child {
                    text-align: left;
                    padding-left: 6px;
                }

            table td p {
                margin-top: 5px;
                margin-bottom: 5px
            }

            .group-detail, .content-detail {
                font-weight: bold;
            }

            .Success {
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=85)"; /* IE 8 */
                filter: alpha(opacity=85); /* IE 5-7 */
                -moz-opacity: 0.85; /* Netscape */
                -khtml-opacity: 0.85; /* Safari 1.x */
                opacity: 0.85; /* Good browsers */
                background: #5DE61C;
            }

            .Warning {
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=95)"; /* IE 8 */
                filter: alpha(opacity=95); /* IE 5-7 */
                -moz-opacity: 0.95; /* Netscape */
                -khtml-opacity: 0.95; /* Safari 1.x */
                opacity: 0.95; /* Good browsers */
                background: #E6A51C;
            }

            .Error {
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=85)"; /* IE 8 */
                filter: alpha(opacity=85); /* IE 5-7 */
                -moz-opacity: 0.85; /* Netscape */
                -khtml-opacity: 0.85; /* Safari 1.x */
                opacity: 0.85; /* Good browsers */
                background: #E6401C;
            }

"@;
    return $css;
}

function Get-HtmlIe8Header-WithCss
{
    $headerHtml = @"
<html>
<head>
    <title>Health Check</title>
    <style type="text/css">
    $(Get-HtmlIe8Css)
    </style>
</head>
<body>

"@;
    return $headerHtml;
}

function Get-HtmlIe5Header-WithCss
{
    $headerHtml = @"
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
    <title>Health Check</title>
    <style type="text/css">
    $(Get-HtmlIe5Css)
    </style>
</head>
<body>

"@;
    return $headerHtml;
}

function Get-ReportHtml
{
    param (
	    [Parameter(Mandatory=$true,Position=1)]
        [System.Collections.Generic.List``1[HealthCheck.ReportItem]]$reports
     )

    $reportHtml = @"
    <div id="report">
        <table class="group">
            <tr>
                <th width="60%">Name</th>
                <th width="80">Date Ran</th>
                <th width="50">Health</th>
            </tr>

"@;

    foreach($report in $reports)
    {
	    $reportHtml += @"
            <tr class="group-detail $($report.Health)">
                <td>$($report.DisplayName)</td>
                <td>$($report.DateRan)</td>
                <td>$($report.Health)</td>
            </tr>
            <tr class="group-content">
                <td colspan="3" class="group-content $($report.Health)">
                    <table class="content">
                        <colgroup>
                            <col width="60%">
                            <col width="80">
                            <col width="50">
                        </colgroup>

"@;

        foreach($sub in $report.SubItems)
        {
            $logUrlHtml = if($sub.LogLocation) { "<a href=`"$($sub.LogLocation)`" target=`"_blank`">$($sub.LogLocation)</a>" } else {""}
            $reportHtml += @"
                        <tr class="content-detail $($sub.Health)">
                            <td>$($sub.DisplayName)</td>
                            <td>$($sub.DateRan)</td>
	                        <td>$($sub.Health)</td>
                        </tr>
                        <tr class="content-log">
                            <td colspan="3">
                                <p>$($logUrlHtml)</p>
                                <p>$($sub.Description)</p>
                            </td>
                        </tr>

"@;
        }
    
	    $reportHtml += @"
                    </table>
                </td>
            </tr>

"@;
    }
    
	$reportHtml += @"
        </table>
    </div>

"@;
    return $reportHtml
}

function Get-HtmlFooter
{
    $footerHtml = @"
</body>
</html>

"@;
    return $footerHtml;
}

function Write-ReportHtmlFile
{
    param (
	    [Parameter(Mandatory=$true,Position=1)]
        [string]$html,
	    [Parameter(Mandatory=$true,Position=2)]
        [string]$filePath
     )
    $html | Out-File $filePath;
}
