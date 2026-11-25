<%@ Page Title="Reportes" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.Reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid" style="color: #f8fafc;">

        <div class="mb-4" style="border-bottom: 1px solid #334155; padding-bottom: 14px;">
            <h2 class="fw-bold mb-1" style="color: #f8fafc;">Reportes y Estadísticas</h2>
            <p class="mb-0" style="color: #94a3b8;">
                Ventas y pedidos cobrados durante el día.
            </p>
        </div>

        <asp:Label ID="lblMensaje" runat="server"
            CssClass="d-block text-danger mb-3 fw-bold" />

        <!-- TARJETAS DE RESUMEN -->
        <div class="row g-3 mb-4">

            <div class="col-12 col-md-6">
                <div class="card bg-primary text-white border-0 shadow-sm">
                    <div class="card-body p-4">
                        <p class="mb-2 text-white-50 fw-semibold">Recaudación del día</p>
                        <h2 class="fw-bold text-white">
                            <asp:Label ID="lblRecaudacion" runat="server" Text="$ 0,00" />
                        </h2>
                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="card bg-success text-white border-0 shadow-sm">
                    <div class="card-body p-4">
                        <p class="mb-2 text-white-50 fw-semibold">Pedidos finalizados hoy</p>
                        <h2 class="fw-bold text-white">
                            <asp:Label ID="lblPedidos" runat="server" Text="0" />
                        </h2>
                        
                    </div>
                </div>
            </div>

        </div>

        <!-- TABLA 1: PRODUCTOS MÁS VENDIDOS -->
        <div class="card shadow-sm mb-4" style="background-color: #1e293b; border: 1px solid #334155; color: #f8fafc;">
            <div class="card-header py-3" style="background-color: #0f172a; border-bottom: 1px solid #334155;">
                <h5 class="fw-bold mb-0" style="color: #38bdf8;">Productos más vendidos hoy
                </h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvProductos"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-dark table-hover align-middle mb-0"
                        EmptyDataText="Todavía no hay productos vendidos hoy.">
                        <Columns>
                            <asp:BoundField DataField="Producto" HeaderText="Producto" ItemStyle-CssClass="fw-semibold" />
                            <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                            <asp:BoundField DataField="CantidadVendida" HeaderText="Cantidad vendida" ItemStyle-CssClass="fw-bold text-info" />
                            <asp:BoundField DataField="TotalRecaudado" HeaderText="Total recaudado" DataFormatString="$ {0:N2}" ItemStyle-CssClass="fw-bold text-success" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- TABLA 2: PEDIDOS POR MESERO -->
        <div class="card shadow-sm mb-4" style="background-color: #1e293b; border: 1px solid #334155; color: #f8fafc;">
            <div class="card-header py-3" style="background-color: #0f172a; border-bottom: 1px solid #334155;">
                <h5 class="fw-bold mb-0" style="color: #38bdf8;">Pedidos por meseros gestionados hoy
                </h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvMeseros"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-dark table-hover align-middle mb-0"
                        EmptyDataText="Todavía no hay pedidos gestionados hoy.">
                        <Columns>
                            <asp:BoundField DataField="Mesero" HeaderText="Mesero" ItemStyle-CssClass="fw-semibold" />
                            <asp:BoundField DataField="CantidadPedidosXMesero" HeaderText="Cantidad de pedidos por mesero" ItemStyle-CssClass="fw-bold text-info" />
                            <asp:BoundField DataField="TotalRecaudadoXMesero" HeaderText="Total recaudado por mesero" DataFormatString="$ {0:N2}" ItemStyle-CssClass="fw-bold text-success" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- TABLA 3: PEDIDOS Y RECAUDACIÓN POR MESA -->
        <div class="card shadow-sm mb-4" style="background-color: #1e293b; border: 1px solid #334155; color: #f8fafc;">
            <div class="card-header py-3" style="background-color: #0f172a; border-bottom: 1px solid #334155;">
                <h5 class="fw-bold mb-0" style="color: #38bdf8;">Pedidos y recaudación por mesa hoy
                </h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvMesas"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-dark table-hover align-middle mb-0"
                        EmptyDataText="Todavía no hay pedidos cobrados por mesa hoy.">
                        <Columns>
                            <asp:BoundField DataField="Mesa" HeaderText="Mesa" ItemStyle-CssClass="fw-semibold" />
                            <asp:BoundField DataField="CantidadPedidosXMesa" HeaderText="Cantidad de pedidos" ItemStyle-CssClass="fw-bold text-info" />
                            <asp:BoundField DataField="TotalRecaudadoXMesa" HeaderText="Total recaudado por mesa" DataFormatString="$ {0:N2}" ItemStyle-CssClass="fw-bold text-success" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

    </div>

</asp:Content>
