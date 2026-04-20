<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TryItUnitConverter.aspx.cs" Inherits="StudentHelperApp.TryItUnitConverter" ContentType="text/html; charset=utf-8" %>

<%@ Register Src="~/UnitConverterControl.ascx"
    TagPrefix="uc" TagName="UnitConverterControl" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <title>TryIt &ndash; Unit Converter (Person 2)</title>
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
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-bottom: 24px;
        }
        h1, h2 { margin-top: 0; color: #1a3a5c; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #999; padding: 9px; vertical-align: top; }
        th { background: #e8eef5; text-align: left; }
        .note { color: #0a7a3a; font-weight: bold; }
        .section-label {
            background: #1a3a5c; color: #fff;
            padding: 6px 12px; border-radius: 5px;
            display: inline-block; margin-bottom: 10px;
        }
        pre { background: #f4f4f4; padding: 10px; border-radius: 5px; font-size: 0.88em; }
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="panel">
    <h1>TryIt Page &mdash; Person 2 Components</h1>
    <p>
        This page lets the grader test all components built by <strong>Diana Torres</strong>.
        Each section below corresponds to one row in the Application &amp; Components Summary Table.
    </p>
    <p><a href="Default.aspx">&larr; Back to Default Page</a></p>
</div>

<!-- ===== User Control ===== -->
<div class="panel">
    <span class="section-label">Component 1 &mdash; User Control (.ascx)</span>
    <h2>UnitConverterControl</h2>
    <p>
        <strong>What it is:</strong> A reusable ASP.NET User Control (<code>UnitConverterControl.ascx</code>)
        that provides a self-contained unit-conversion form. It can be dropped onto any ASPX page
        by registering it with <code>&#x25;@ Register</code>.<br /><br />
        <strong>How to test:</strong> Enter a number, choose From and To units, click <em>Convert</em>.
        The result appears below the button. The cookie section updates to confirm the preference was saved.
    </p>

    <uc:UnitConverterControl ID="ucConverter" runat="server" />
</div>

<!-- ===== Cookie Component ===== -->
<div class="panel">
    <span class="section-label">Component 2 &mdash; Cookie</span>
    <h2>Cookie: Saved Unit Preferences</h2>
    <p>
        <strong>What it does:</strong> After each successful conversion the User Control above writes
        an HTTP cookie named <code>UnitConverterPrefs</code> that stores the last value, From unit,
        and To unit. On the next visit the form is automatically pre-filled from this cookie.<br /><br />
        <strong>How to test:</strong>
    </p>
    <ol>
        <li>Convert a value using the form above (e.g. 50 miles &rarr; km).</li>
        <li>The green cookie status text confirms the cookie was written.</li>
        <li>Click the button below to read the current raw cookie values from <code>Request.Cookies</code>.</li>
        <li>Refresh the page &mdash; the form will be pre-filled with your last entries.</li>
        <li>Click <em>Clear Saved Preferences</em> in the converter to expire the cookie.</li>
    </ol>

    <asp:Button ID="btnShowCookie" runat="server" Text="Read Cookie Values Now"
        OnClick="btnShowCookie_Click"
        style="background:#1a3a5c; color:#fff; padding:6px 16px;
               border:none; border-radius:5px; cursor:pointer;" />
    <br /><br />
    <asp:Label ID="lblCookieRaw" runat="server" />
</div>

<!-- =====  WCF Service ===== -->
<div class="panel">
    <span class="section-label">Component 3 &mdash; WCF Service (.svc)</span>
    <h2>UnitConverterService</h2>
    <p>
        <strong>What it is:</strong> A WCF SOAP service deployed on WebStrar.<br />
        <strong>Operations:</strong>
    </p>
    <table>
        <tr>
            <th>Operation</th>
            <th>Parameters</th>
            <th>Return type</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>ConvertUnits</td>
            <td>double value, string fromUnit, string toUnit</td>
            <td>double</td>
            <td>Converts value between supported units (miles/km, lbs/kg, &deg;F/&deg;C, feet/meters, gallons/liters)</td>
        </tr>
        <tr>
            <td>GetSupportedUnits</td>
            <td>(none)</td>
            <td>string</td>
            <td>Returns comma-separated list of all supported unit tokens</td>
        </tr>
        <tr>
            <td>HealthCheck</td>
            <td>(none)</td>
            <td>string</td>
            <td>Confirms the service is running</td>
        </tr>
    </table>

    <br />
    <p><strong>Direct service test (calls HealthCheck + GetSupportedUnits):</strong></p>
    <asp:Button ID="btnServiceHealth" runat="server" Text="Call Service Health Check"
        OnClick="btnServiceHealth_Click"
        style="background:#1a3a5c; color:#fff; padding:6px 16px;
               border:none; border-radius:5px; cursor:pointer;" />
    <br /><br />
    <asp:Label ID="lblServiceResult" runat="server" CssClass="note" />

    <br /><br />
    <p>
        <strong>WSDL:</strong>
        <asp:HyperLink ID="lnkWsdl" runat="server" Target="_blank"
            Text="View service WSDL (opens in new tab)" />
    </p>
</div>

<!-- ===== Back link ===== -->
<div class="panel">
    <a href="Default.aspx">&larr; Return to Default Page</a>
</div>
</form>
</body>
</html>
