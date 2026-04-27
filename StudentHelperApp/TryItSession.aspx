<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TryItSession.aspx.cs" Inherits="StudentHelperApp.TryItSession" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>TryIt - Session State</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 24px;
            background: #f5f6fa;
            color: #222;
        }
        .panel {
            max-width: 900px;
            margin: 0 auto;
            background: #fff;
            padding: 24px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        h1 { margin-top: 0; }
        label { font-weight: bold; display: block; margin-top: 12px; }
        input[type="text"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-top: 4px;
            margin-bottom: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            padding: 8px 16px;
            margin-right: 8px;
            margin-top: 10px;
            background: #4a6fa5;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn:hover { background: #3a5f95; }
        .btn-clear { background: #c0392b; }
        .btn-clear:hover { background: #a93226; }
        .result {
            margin-top: 16px;
            padding: 14px;
            background: #f0f4f8;
            border: 1px solid #d0d8e0;
            border-radius: 5px;
            white-space: pre-wrap;
        }
        .info { color: #555; font-size: 0.95em; }
        a.back { display: inline-block; margin-bottom: 16px; color: #4a6fa5; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <a class="back" href="Default.aspx">&larr; Back to Default</a>

        <h1>Session State TryIt</h1>
        <p class="info">
            This page demonstrates server-side session state management.
            Add courses to your study plan. The data is stored in the ASP.NET Session
            and persists across postbacks and page navigations within the same browser session.
        </p>
        <p class="info">
            <strong>How to test:</strong> Add a few courses, then navigate to another TryIt page
            and come back. Your courses will still be here. Click "Clear Session" to reset.
        </p>

        <label for="txtCourseName">Course Name</label>
        <asp:TextBox ID="txtCourseName" runat="server" placeholder="e.g., CSE445" />

        <label for="txtCreditHours">Credit Hours</label>
        <asp:TextBox ID="txtCreditHours" runat="server" placeholder="e.g., 3" />

        <label for="txtStudyHours">Planned Study Hours/Week</label>
        <asp:TextBox ID="txtStudyHours" runat="server" placeholder="e.g., 6" />

        <div>
            <asp:Button ID="btnAddCourse" runat="server" Text="Add to Session"
                CssClass="btn" OnClick="btnAddCourse_Click" />
            <asp:Button ID="btnClearSession" runat="server" Text="Clear Session"
                CssClass="btn btn-clear" OnClick="btnClearSession_Click" />
        </div>

        <asp:Label ID="lblStatus" runat="server" CssClass="info" />

        <h2>Current Session Data</h2>
        <asp:Label ID="lblSessionId" runat="server" CssClass="info" />
        <div class="result">
            <asp:Literal ID="litSessionData" runat="server" />
        </div>
    </div>
</form>
</body>
</html>
