<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Member.aspx.cs"
    Inherits="StudentHelperApp.Member"
    ContentType="text/html; charset=utf-8" %>

<%@ Register Src="~/UnitConverterControl.ascx"
    TagPrefix="uc" TagName="UnitConverterControl" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Member Page – StudentHelperApp</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 24px;
            background: #f0f4f8;
            color: #222;
        }
        .panel {
            max-width: 860px;
            background: #fff;
            padding: 28px;
            border: 1px solid #ccd;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        h1, h2 { margin-top: 0; color: #1a3a5c; }
        .welcome-bar {
            background: #1a3a5c;
            color: #fff;
            padding: 12px 18px;
            border-radius: 7px;
            margin-bottom: 18px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-logout {
            background: #c0392b;
            color: #fff;
            border: none;
            padding: 6px 16px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 0.95em;
        }
        .back-link a { color: #4a6fa5; font-size: 0.9em; }
        .cookie-box {
            background: #f0f6ff;
            border: 1px solid #b0c8e8;
            border-radius: 6px;
            padding: 12px 16px;
            font-size: 0.92em;
            color: #1a3a5c;
            margin-top: 10px;
        }
        .section-label {
            background: #1a3a5c;
            color: #fff;
            padding: 5px 12px;
            border-radius: 5px;
            display: inline-block;
            margin-bottom: 10px;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">

    <div class="welcome-bar">
        <span>
            Welcome, <strong><asp:Label ID="lblUsername" runat="server" /></strong>!
            You are logged in as a Member.
        </span>
        <asp:Button ID="btnLogout" runat="server" Text="Log Out"
            CssClass="btn-logout" OnClick="btnLogout_Click" />
    </div>

    <!-- Main member panel -->
    <div class="panel">
        <p class="back-link"><a href="Default.aspx">&larr; Back to Home</a></p>
        <h1>Member Page</h1>
        <p>
            As a member you have access to the <strong>Unit Converter</strong> tool below.
            Your last-used conversion preferences are saved automatically via cookie.
        </p>

        <span class="section-label">Unit Converter Tool</span>
        <uc:UnitConverterControl ID="ucMemberConverter" runat="server" />

        <div class="cookie-box">
            <strong>Cookie status:</strong><br />
            <asp:Label ID="lblMemberCookieStatus" runat="server" />
        </div>
    </div>

    <!-- Session info panel -->
    <div class="panel">
        <span class="section-label">Session Info</span>
        <h2>Your Session</h2>
        <p>
            <strong>Session key:</strong> User<br />
            <strong>Session value:</strong>
            <asp:Label ID="lblSessionInfo" runat="server" /><br />
            <strong>Session ID:</strong>
            <asp:Label ID="lblSessionId" runat="server" />
        </p>
    </div>

</form>
</body>
</html>
