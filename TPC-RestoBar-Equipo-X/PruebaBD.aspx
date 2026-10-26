<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PruebaBD.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.WebForm1" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Prueba de base de datos</title>
</head>
<body>
    <form id="form1" runat="server">
        <h1>MESAS DEL RESTO BAR</h1>

        <asp:Label
            ID="lblMensaje"
            runat="server">
        </asp:Label>

        <br /><br />

        <asp:GridView
            ID="gvMesas"
            runat="server"
            AutoGenerateColumns="true">
        </asp:GridView>
    </form>
</body>
</html>
