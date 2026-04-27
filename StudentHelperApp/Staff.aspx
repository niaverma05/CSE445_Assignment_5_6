<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="StudentHelperApp.Staff" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>Staff Page</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; background: #f5f6fa; }
        .panel {
            max-width: 600px; margin: 0 auto; background: #fff;
            padding: 24px; border: 1px solid #ddd; border-radius: 10px;
            text-align: center;
        }
        a.back { display: inline-block; margin-bottom: 16px; color: #4a6fa5; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="panel">
        <a class="back" href="Default.aspx">&larr; Back to Default</a>
        <h1>Staff Page</h1>
        <p>This page will require staff authorization in Assignment 6.</p>
        <p>Staff credentials (TA / Cse445!) and Staff.xml will be added.</p>
    </div>
</form>
</body>
</html>
