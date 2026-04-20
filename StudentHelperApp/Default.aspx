<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="StudentHelperApp._Default" ContentType="text/html; charset=utf-8" %>

<%@ Register Src="~/UnitConverterControl.ascx"
    TagPrefix="uc" TagName="UnitConverterControl" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>StudentHelperApp</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 24px;
            background: #f8f8f8;
            color: #222;
        }
        .panel {
            max-width: 1150px;
            background: #fff;
            padding: 24px;
            border: 1px solid #ddd;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        h1, h2 { margin-top: 0; }
        .nav { margin: 18px 0 24px 0; }
        .nav a, .nav input { margin-right: 10px; margin-bottom: 8px; }
        table { width: 100%; border-collapse: collapse; margin-top: 12px; }
        th, td { border: 1px solid #999; padding: 10px; vertical-align: top; }
        th { background: #efefef; text-align: left; }
        .small { color: #666; font-size: 0.95em; }
        .note { display: block; margin-top: 10px; color: #0a5; white-space: pre-wrap; }
        .person1-row { background: #fafafa; }
        .person2-row { background: #f0f6ff; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <h1>StudentHelperApp</h1>
        <p>
            StudentHelperApp is a student support site with two main tools:
            a <strong>GPA Calculator</strong> and a
            <strong>Unit Converter</strong>, plus a <strong>study-planning
            helper</strong>. Sign up as a Member to save your data, or ask
            your instructor to create a Staff account for you.
        </p>
        <p><strong>How to test this application:</strong></p>
        <ul>
            <li>Use the navigation links below to reach each feature's TryIt page.</li>
            <li>Member and Staff pages are available in Assignment 6.</li>
        </ul>

        <div class="nav">
            <asp:HyperLink ID="lnkTryItGpa" runat="server"
                NavigateUrl="~/TryItGpa.aspx" Text="TryIt &ndash; GPA Calculator" />
            <asp:HyperLink ID="lnkTryItConverter" runat="server"
                NavigateUrl="~/TryItUnitConverter.aspx" Text="TryIt &ndash; Unit Converter" />
            <asp:HyperLink ID="lnkMember" runat="server"
                NavigateUrl="~/Member.aspx" Text="Member Page" />
            <asp:HyperLink ID="lnkStaff" runat="server"
                NavigateUrl="~/Staff.aspx" Text="Staff Page" />
            <asp:Button ID="btnShowLog" runat="server"
                Text="Show Startup Log" OnClick="btnShowLog_Click" />
        </div>

        <asp:Label ID="lblLog" runat="server" CssClass="note"></asp:Label>
    </div>

    <!-- ===== Application and Components Summary Table ===== -->
    <div class="panel">
        <h2>Application and Components Summary Table</h2>
        <p class="small">
            Combined table &mdash; Person 1: Nia Verma &nbsp;|&nbsp; Person 2: Diana Torres
        </p>

        <table>
            <tr>
                <th>Provider name</th>
                <th>Page / component type</th>
                <th>Component description</th>
                <th>Inputs / outputs</th>
                <th>TryIt link</th>
            </tr>

            <!-- ===== Person 1 rows ===== -->
            <tr class="person1-row">
                <td>Nia Verma</td>
                <td>ASPX page (Default.aspx)</td>
                <td>Public landing page that explains the app, shows the component
                    directory, and links to testing pages and future Member/Staff pages.</td>
                <td>Input: none<br />Output: app overview and links</td>
                <td>N/A (this page)</td>
            </tr>
            <tr class="person1-row">
                <td>Nia Verma</td>
                <td>DLL class library (StudentHelperLib)</td>
                <td>GPA calculator logic: converts letter grades and credits into GPA.</td>
                <td>Input: comma-separated grades and credits<br />Output: numeric GPA (double)</td>
                <td><a href="TryItGpa.aspx">TryIt &ndash; GPA</a></td>
            </tr>
            <tr class="person1-row">
                <td>Nia Verma</td>
                <td>Global.asax event handler</td>
                <td>Application_Start writes a timestamped entry to App_Data/startup.log.</td>
                <td>Input: none (fires on app start)<br />Output: log file entry</td>
                <td><asp:Button ID="btnShowLogInTable" runat="server"
                        Text="Show Log" OnClick="btnShowLog_Click" /></td>
            </tr>
            <tr class="person1-row">
                <td>Nia Verma</td>
                <td>ASMX web service (GpaService.asmx)</td>
                <td>GPA web service: computes GPA and returns study advice.</td>
                <td>
                    CalculateGpa(gradesCsv, creditsCsv) &rarr; double<br />
                    GetAdvice(gpa) &rarr; string<br />
                    HealthCheck() &rarr; string
                </td>
                <td><a href="TryItGpa.aspx">TryIt &ndash; GPA</a></td>
            </tr>

            <!-- ===== Person 2 rows ===== -->
            <tr class="person2-row">
                <td>Diana Torres</td>
                <td>User Control (.ascx) &mdash; UnitConverterControl</td>
                <td>
                    Reusable input panel for unit conversion. Embeds a value input,
                    From/To dropdowns, and a Convert button. Calls the WCF service
                    and displays the result. Also reads/writes the preferences cookie.
                </td>
                <td>
                    Input: numeric value, fromUnit string, toUnit string<br />
                    Output: converted result displayed in label
                </td>
                <td><a href="TryItUnitConverter.aspx">TryIt &ndash; Converter</a></td>
            </tr>
            <tr class="person2-row">
                <td>Diana Torres</td>
                <td>Cookie &mdash; UnitConverterPrefs</td>
                <td>
                    HTTP cookie that stores the user's last conversion value and unit
                    selections (LastValue, LastFrom, LastTo). The form is pre-filled
                    from this cookie on the next visit. Expires in 30 days.
                </td>
                <td>
                    Written by: UnitConverterControl after each successful conversion<br />
                    Read by: UnitConverterControl on Page_Load (non-postback)<br />
                    Sub-keys: LastValue, LastFrom, LastTo
                </td>
                <td><a href="TryItUnitConverter.aspx#cookie">TryIt &ndash; Cookie section</a></td>
            </tr>
            <tr class="person2-row">
                <td>Diana Torres</td>
                <td>WCF Service (.svc) &mdash; UnitConverterService</td>
                <td>
                    SOAP/WSDL service deployed on WebStrar. Converts between miles/km,
                    lbs/kg, &deg;F/&deg;C, feet/meters, and gallons/liters.
                </td>
                <td>
                    ConvertUnits(double value, string fromUnit, string toUnit) &rarr; double<br />
                    GetSupportedUnits() &rarr; string<br />
                    HealthCheck() &rarr; string
                </td>
                <td><a href="TryItUnitConverter.aspx">TryIt &ndash; Service section</a></td>
            </tr>

        </table>
    </div>

</form>
</body>
</html>
