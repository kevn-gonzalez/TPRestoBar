<%@ Page Title="Mesas del Resto" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PruebaBD.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.PruebaBD" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="row mb-4">
        <div class="col-12">
            <h2 class="text-primary fw-bold">
                <i class="bi bi-grid-3x3-gap-fill me-2"></i>MESAS DEL RESTO BAR
            </h2>
            
            <div class="mt-2">
                <asp:Label ID="lblMensaje" runat="server" CssClass="fw-bold text-success text-uppercase"></asp:Label>
            </div>
            <hr />
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 col-lg-6 col-sm-12">
            <div class="table-responsive shadow-sm rounded">
                <asp:GridView ID="gvMesas" runat="server" AutoGenerateColumns="true" 
                    CssClass="table table-striped table-hover table-bordered m-0 align-middle">
                    <HeaderStyle CssClass="table-dark text-center" />
                    <RowStyle CssClass="text-center" />
                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>
