<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-5" style="max-width: 400px;">

    <h3>Iniciar sesión</h3>

    <div class="mb-3">
        <label>Usuario</label>
        <asp:TextBox ID="txtUsuario" runat="server"
            CssClass="form-control" />
    </div>

    <div class="mb-3">
        <label>Contraseña</label>
        <asp:TextBox ID="txtPassword" runat="server"
            TextMode="Password"
            CssClass="form-control" />
    </div>

    <asp:Button ID="btnIngresar" runat="server"
        Text="Ingresar"
        CssClass="btn btn-primary"
        OnClick="btnIngresar_Click" />

    <asp:Label ID="lblMensaje" runat="server"
        CssClass="text-danger d-block mt-3" />

</div>
</asp:Content>
