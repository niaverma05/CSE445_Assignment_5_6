<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs"
    Inherits="StudentHelperApp.Login"
    ContentType="text/html; charset=utf-8" %>

<%@ Register Src="~/UnitConverterControl.ascx"
    TagPrefix="uc" TagName="UnitConverterControl" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Login – StudentHelperApp</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 0;
            background: #f0f4f8;
            color: #222;
        }
        .page-wrap {
            max-width: 480px;
            margin: 60px auto;
            background: #fff;
            padding: 32px;
            border: 1px solid #ccd;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        h2 { margin-top: 0; color: #1a3a5c; }
        .field { margin-bottom: 14px; }
        .field label {
            display: block;
            font-weight: bold;
            margin-bottom: 4px;
            color: #1a3a5c;
        }
        .field input[type=text],
        .field input[type=password] {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #aab;
            border-radius: 5px;
            font-size: 1em;
            box-sizing: border-box;
        }
        .remember-row {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 18px;
            font-size: 0.95em;
            color: #444;
        }
        .btn-row { display: flex; gap: 10px; margin-bottom: 14px; }
        .btn-primary {
            background: #1a3a5c;
            color: #fff;
            border: none;
            padding: 9px 22px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
        }
        .btn-secondary {
            background: #4a6fa5;
            color: #fff;
            border: none;
            padding: 9px 22px;
            border-radius: 5px;
            font-size: 1em;
            cursor: pointer;
        }
        .msg-error  { color: #c00; font-weight: bold; margin-top: 8px; }
        .msg-success { color: #0a7a3a; font-weight: bold; margin-top: 8px; }
        .cookie-info {
            margin-top: 18px;
            padding: 10px 14px;
            background: #f0f6ff;
            border: 1px solid #b0c8e8;
            border-radius: 6px;
            font-size: 0.9em;
            color: #1a3a5c;
        }
        .divider {
            border: none;
            border-top: 1px solid #dde;
            margin: 22px 0;
        }
        .back-link { font-size: 0.9em; }
        .back-link a { color: #4a6fa5; }
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="page-wrap">

    <p class="back-link"><a href="Default.aspx">&larr; Back to Home</a></p>
    <h2>StudentHelperApp Login</h2>

    <!-- ===== Username field ===== -->
    <div class="field">
        <label for="<%= txtUsername.ClientID %>">Username</label>
        <asp:TextBox ID="txtUsername" runat="server" placeholder="Enter username" />
    </div>

    <!-- ===== Password field ===== -->
    <div class="field">
        <label for="<%= txtPassword.ClientID %>">Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"
            placeholder="Enter password" />
    </div>

    <!-- ===== Remember me checkbox ===== -->
    <div class="remember-row">
        <asp:CheckBox ID="chkRemember" runat="server" />
        <label for="<%= chkRemember.ClientID %>">
            Remember my username (stored in cookie)
        </label>
    </div>

    <div class="btn-row">
        <asp:Button ID="btnLogin"  runat="server" Text="Log In"
            CssClass="btn-primary"  OnClick="btnLogin_Click" />
        <asp:Button ID="btnSignup" runat="server" Text="Sign Up as Member"
            CssClass="btn-secondary" OnClick="btnSignup_Click" />
    </div>

    <asp:Label ID="lblMessage" runat="server" />

    <hr class="divider" />

    <div class="cookie-info">
        <strong>Cookie Status:</strong><br />
        <asp:Label ID="lblCookieInfo" runat="server" />
    </div>

    <hr class="divider" />

    <div style="font-size:0.88em; color:#555;">
        <strong>Test credentials:</strong><br />
        Member: username <code>test1</code> / password <code>test1pass</code><br />
        Staff &nbsp;: username <code>TA</code> &nbsp;&nbsp;&nbsp;/ password <code>Cse445!</code>
    </div>

</div>
</form>
</body>
</html>
