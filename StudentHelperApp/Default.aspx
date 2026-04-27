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
        .person3-row { background: #fff5e6; }
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
            helper</strong>. Use the Login/Signup page to create a Member account and access protected features, or ask
            your instructor to create a Staff account for you.
        </p>

        <p><strong>How to test this application:</strong></p>
        <ul>
            <li>Use the navigation links below to reach each feature's TryIt page.</li>
            <li>Member and Staff pages are protected and require login.</li>
        </ul>

        <p><strong>Login Instructions:</strong></p>
        <ul>
            <li>Member: Click "Login / Signup", create a new account, then log in.</li>
            <li>Staff: Username = <strong>TA</strong>, Password = <strong>Cse445!</strong></li>
        </ul>

        <div class="nav">
            <asp:HyperLink ID="lnkLogin" runat="server"
                NavigateUrl="~/Login.aspx" Text="Login / Signup" />
            <asp:HyperLink ID="lnkTryItGpa" runat="server"
                NavigateUrl="~/TryItGpa.aspx" Text="TryIt &ndash; GPA Calculator" />
            <asp:HyperLink ID="lnkTryItConverter" runat="server"
                NavigateUrl="~/TryItUnitConverter.aspx" Text="TryIt &ndash; Unit Converter" />
            <asp:HyperLink ID="lnkTryItSession" runat="server"
                NavigateUrl="~/TryItSession.aspx" Text="TryIt &ndash; Session State" />
            <asp:HyperLink ID="lnkTryItValidation" runat="server"
                NavigateUrl="~/TryItValidation.aspx" Text="TryIt &ndash; Validation" />
            <asp:HyperLink ID="lnkTryItStudyHelper" runat="server"
                NavigateUrl="~/TryItStudyHelper.aspx" Text="TryIt &ndash; Study Helper" />
            <asp:HyperLink ID="lnkMember" runat="server"
                NavigateUrl="~/Member.aspx" Text="Member Page" />
            <asp:HyperLink ID="lnkStaff" runat="server"
                NavigateUrl="~/Staff.aspx" Text="Staff Page" />
            <asp:Button ID="btnShowLog" runat="server"
                Text="Show Startup Log" OnClick="btnShowLog_Click" />
        </div>

        <asp:Label ID="lblLog" runat="server" CssClass="note"></asp:Label>
    </div>

    <div class="panel">
        <h2>Application and Components Summary Table</h2>
        <p class="small">
            Combined table &mdash; Person 1: Nia Verma &nbsp;|&nbsp; Person 2: Diana Torres &nbsp;|&nbsp; Person 3: Dens Sumesh
        </p>

        <table>
            <tr>
                <th>Provider name</th>
                <th>Page / component type</th>
                <th>Component description</th>
                <th>Inputs / outputs</th>
                <th>TryIt link</th>
            </tr>

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

            <tr class="person3-row">
                <td>Dens Sumesh</td>
                <td>Session State</td>
                <td>
                    Stores temporary study plan data (course names, credit hours, study
                    time allocations) in server-side session state so data persists across
                    page navigations within the same session.
                </td>
                <td>
                    Input: Course data entered by user<br />
                    Output: Persisted data displayed after navigation
                </td>
                <td><a href="TryItSession.aspx">TryIt &ndash; Session</a></td>
            </tr>
            <tr class="person3-row">
                <td>Dens Sumesh</td>
                <td>DLL Class Library (ValidationLib)</td>
                <td>
                    Input validation utilities for password strength, email format,
                    numeric range checking, grade list validation, and HTML sanitization.
                </td>
                <td>
                    Input: String values to validate<br />
                    Output: ValidationResult (IsValid bool + Message string)
                </td>
                <td><a href="TryItValidation.aspx">TryIt &ndash; Validation</a></td>
            </tr>
            <tr class="person3-row">
                <td>Dens Sumesh</td>
                <td>WCF Service (.svc) &mdash; StudyHelperService</td>
                <td>
                    Study Helper REST service that generates study time allocations based on
                    courses, credit hours, and available weekly hours.
                </td>
                <td>
                    GenerateStudyPlan(StudyPlanRequest) &rarr; StudyPlan<br />
                    GetStudyRecommendation(creditHours) &rarr; string<br />
                    HealthCheck() &rarr; string
                </td>
                <td><a href="TryItStudyHelper.aspx">TryIt &ndash; Study Helper</a></td>
            </tr>

        </table>
    </div>

</form>
</body>
</html>
