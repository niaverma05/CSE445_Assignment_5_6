<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Staff.aspx.cs"
    Inherits="StudentHelperApp.Staff"
    ContentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Staff Page – StudentHelperApp</title>
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
            background: #2c3e50;
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
        }
        .back-link a { color: #4a6fa5; font-size: 0.9em; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #999; padding: 9px; vertical-align: top; }
        th { background: #e8eef5; text-align: left; }
        .section-label {
            background: #2c3e50;
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
            Staff Portal &mdash; logged in as <strong><asp:Label ID="lblStaffName" runat="server" /></strong>
        </span>
        <asp:Button ID="btnLogout" runat="server" Text="Log Out"
            CssClass="btn-logout" OnClick="btnLogout_Click" />
    </div>

    <div class="panel">
        <p class="back-link"><a href="Default.aspx">&larr; Back to Home</a></p>
        <h1>Staff Page</h1>
        <p>
            This page is restricted to authorized staff only.
            Access is granted by the administrator via <code>Staff.xml</code>.
        </p>

        <span class="section-label">Staff Session Info</span>
        <p>
            <strong>Logged in as:</strong>
            <asp:Label ID="lblStaffSession" runat="server" /><br />
            <strong>Session ID:</strong>
            <asp:Label ID="lblSessionId" runat="server" />
        </p>

        <!-- Registered members table -->
        <span class="section-label">Registered Members</span>
        <asp:GridView ID="gvMembers" runat="server"
            AutoGenerateColumns="false"
            EmptyDataText="No members registered yet."
            style="margin-top:10px;">
            <Columns>
                <asp:BoundField DataField="Username" HeaderText="Username" />
                <asp:BoundField DataField="Registered" HeaderText="Registered" />
            </Columns>
        </asp:GridView>
    </div>

</form>
</body>
</html>
