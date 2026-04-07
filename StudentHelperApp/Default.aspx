<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="StudentHelperApp._Default" %>

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
        }
        h1, h2 {
            margin-top: 0;
        }
        .nav {
            margin: 18px 0 24px 0;
        }
        .nav a, .nav input {
            margin-right: 10px;
            margin-bottom: 8px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 12px;
        }
        th, td {
            border: 1px solid #999;
            padding: 10px;
            vertical-align: top;
        }
        th {
            background: #efefef;
            text-align: left;
        }
        .small {
            color: #666;
            font-size: 0.95em;
        }
        .note {
            display: block;
            margin-top: 10px;
            color: #0a5;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <h1>StudentHelperApp</h1>
        <p>
            StudentHelperApp is a student support site focused on GPA calculation and course-planning helpers.
        </p>

        <div class="nav">
            <asp:HyperLink ID="lnkTryIt" runat="server" NavigateUrl="~/TryItGpa.aspx" Text="Calculate GPA" />
            <asp:HyperLink ID="lnkMember" runat="server" NavigateUrl="~/Member.aspx" Text="Member" />
            <asp:HyperLink ID="lnkStaff" runat="server" NavigateUrl="~/Staff.aspx" Text="Staff" />
            <asp:Button ID="btnShowLog" runat="server" Text="Click me!" OnClick="btnShowLog_Click" />
        </div>

        <asp:Label ID="lblLog" runat="server" CssClass="note"></asp:Label>

        <h2>Application and Components Summary Table</h2>
        <p class="small">
            Nia's Assignment 5
        </p>

        <table>
            <tr>
                <th>Provider name</th>
                <th>Page / component type</th>
                <th>Component description</th>
                <th>Inputs / outputs</th>
                <th>TryIt link</th>
            </tr>
            <tr>
                <td>Nia Verma</td>
                <td>ASPX page (Default.aspx)</td>
                <td>
                    Public landing page that explains the app, shows the component directory, and links to testing pages
                    and future Member/Staff pages.
                </td>
                <td>Input: none<br />Output: app overview and links</td>
                <td>N/A</td>
            </tr>
            <tr>
                <td>Nia Verma</td>
                <td>DLL class library</td>
                <td>
                    GPA calculator logic that converts letter grades and credits into GPA.
                </td>
                <td>
                    Input: comma-separated grades and credits<br />
                    Output: numeric GPA
                </td>
                <td><a href="TryItGpa.aspx">Click me!</a></td>
            </tr>
            <tr>
                <td>Nia Verma</td>
                <td>Global.asax</td>
                <td>
                    Application start event handler that writes a startup entry to App_Data/startup.log.
                </td>
                <td>Input: none<br />Output: startup log entry</td>
                <td><a href="#" onclick="return false;">Click me!</a></td>
            </tr>
            <tr>
                <td>Nia Verma</td>
                <td>ASMX web service</td>
                <td>
                    GPA calculator service that computes GPA and returns study advice.
                </td>
                <td>
                    Input: grades CSV, credits CSV<br />
                    Output: GPA and advice
                </td>
                <td><a href="TryItGpa.aspx">Click me!</a></td>
            </tr>
        </table>
    </div>
</form>
</body>
</html>