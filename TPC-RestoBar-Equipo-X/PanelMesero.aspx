<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PanelMesero.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.PanelMesero" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container-fluid">
        <!-- Encabezado -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold text-dark mb-1">Mis Mesas Asignadas</h2>
                <p class="text-muted">Gestioná los pedidos y el estado de tus mesas en tiempo real.</p>
            </div>
            <span class="badge bg-primary fs-sm px-3 py-2">Mesero Activo</span>
        </div>

        <!-- Tarjetas de Mesas (Vista de Cuadrícula) -->
        <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4 mb-5">
            
            <!-- Ejemplo de Mesa Libre -->
            <div class="col">
                <div class="card h-100 border-start border-4 border-success shadow-sm">
                    <div class="card-body d-flex flex-column justify-content-between p-3">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h4 class="fw-bold text-dark m-0">Mesa 01</h4>
                            <span class="badge bg-subtle-success text-success px-2 py-1">Libre</span>
                        </div>
                        <p class="text-muted small mb-3"><i class="bi bi-people me-1"></i> Capacidad: 4 personas</p>
                        <asp:Button ID="btnAbrirPedido1" runat="server" Text="Abrir Pedido" CssClass="btn btn-success w-100 btn-sm fw-semibold" />
                    </div>
                </div>
            </div>

            <!-- Ejemplo de Mesa Ocupada -->
            <div class="col">
                <div class="card h-100 border-start border-4 border-danger shadow-sm">
                    <div class="card-body d-flex flex-column justify-content-between p-3">
                        <div class="d-flex justify-content-between align-items-start mb-2">
                            <h4 class="fw-bold text-dark m-0">Mesa 02</h4>
                            <span class="badge bg-subtle-danger text-danger px-2 py-1">Ocupada</span>
                        </div>
                        <p class="text-muted small mb-1"><i class="bi bi-clock me-1"></i> Abierta hace: 45 min</p>
                        <p class="text-dark fw-bold small mb-3">Total: $0.00</p>
                        <asp:Button ID="btnVerPedido2" runat="server" Text="Gestionar Pedido" CssClass="btn btn-outline-danger w-100 btn-sm fw-semibold" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
