<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UnitConverterControl.ascx.cs" Inherits="StudentHelperApp.UnitConverterControl" %>

<div style="border:1px solid #bbb; border-radius:8px; padding:18px;
            background:#f4f8ff; max-width:480px; font-family:Arial,sans-serif;">

    <h3 style="margin-top:0; color:#1a3a5c;">Unit Converter</h3>

    <table style="width:100%; border:none;">
        <tr>
            <td style="padding:4px; border:none;">
                <label for="<%= txtValue.ClientID %>">Value:</label>
            </td>
            <td style="padding:4px; border:none;">
                <asp:TextBox ID="txtValue" runat="server" Width="120px"
                    placeholder="e.g. 100" />
            </td>
        </tr>
        <tr>
            <td style="padding:4px; border:none;">
                <label for="<%= ddlFrom.ClientID %>">From:</label>
            </td>
            <td style="padding:4px; border:none;">
                <asp:DropDownList ID="ddlFrom" runat="server">
                    <asp:ListItem Text="Miles"    Value="miles" />
                    <asp:ListItem Text="Km"       Value="km" />
                    <asp:ListItem Text="Feet"     Value="feet" />
                    <asp:ListItem Text="Meters"   Value="meters" />
                    <asp:ListItem Text="Lbs"      Value="lbs" />
                    <asp:ListItem Text="Kg"       Value="kg" />
                    <asp:ListItem Text="°F"       Value="f" />
                    <asp:ListItem Text="°C"       Value="c" />
                    <asp:ListItem Text="Gallons"  Value="gallons" />
                    <asp:ListItem Text="Liters"   Value="liters" />
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="padding:4px; border:none;">
                <label for="<%= ddlTo.ClientID %>">To:</label>
            </td>
            <td style="padding:4px; border:none;">
                <asp:DropDownList ID="ddlTo" runat="server">
                    <asp:ListItem Text="Km"       Value="km" />
                    <asp:ListItem Text="Miles"    Value="miles" />
                    <asp:ListItem Text="Meters"   Value="meters" />
                    <asp:ListItem Text="Feet"     Value="feet" />
                    <asp:ListItem Text="Kg"       Value="kg" />
                    <asp:ListItem Text="Lbs"      Value="lbs" />
                    <asp:ListItem Text="°C"       Value="c" />
                    <asp:ListItem Text="°F"       Value="f" />
                    <asp:ListItem Text="Liters"   Value="liters" />
                    <asp:ListItem Text="Gallons"  Value="gallons" />
                </asp:DropDownList>
            </td>
        </tr>
    </table>

    <br />
    <asp:Button ID="btnConvert" runat="server" Text="Convert"
        OnClick="btnConvert_Click"
        style="background:#1a3a5c; color:#fff; padding:6px 18px;
               border:none; border-radius:5px; cursor:pointer;" />
    &nbsp;
    <asp:Button ID="btnClearCookie" runat="server" Text="Clear Saved Preferences"
        OnClick="btnClearCookie_Click"
        style="background:#888; color:#fff; padding:6px 14px;
               border:none; border-radius:5px; cursor:pointer;" />

    <br /><br />

    <asp:Label ID="lblResult" runat="server"
        style="font-size:1.1em; font-weight:bold; color:#1a3a5c;" />

    <br />

    <asp:Label ID="lblCookieStatus" runat="server"
        style="font-size:0.9em; color:#555;" />
</div>
