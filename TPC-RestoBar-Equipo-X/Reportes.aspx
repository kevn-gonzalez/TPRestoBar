
<%@ Page Title="Reportes" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.Reportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid">

        <div class="mb-4">
            <h2 class="fw-bold mb-1">Reportes y Estadísticas</h2>
            <p class="text-muted">
                Ventas y pedidos cobrados durante el día.
            </p>
        </div>

        <asp:Label ID="lblMensaje" runat="server"
            CssClass="d-block text-danger mb-3" />


        <div class="row g-3 mb-4">

            <div class="col-12 col-md-6">
                <div class="card bg-primary text-white border-0 shadow-sm">
                    <div class="card-body p-4">

                        <p class="mb-2">Recaudación del día</p>

                        <h2 class="fw-bold">
                            <asp:Label ID="lblRecaudacion"
                                runat="server" Text="$ 0,00" />
                        </h2>

                        <small>Pedidos cobrados hoy</small>

                    </div>
                </div>
            </div>

            <div class="col-12 col-md-6">
                <div class="card bg-success text-white border-0 shadow-sm">
                    <div class="card-body p-4">

                        <p class="mb-2">Pedidos finalizados hoy</p>

                        <h2 class="fw-bold">
                            <asp:Label ID="lblPedidos"
                                runat="server" Text="0" />
                        </h2>

                        <small>Pedidos con estado Pagado</small>

                    </div>
                </div>
            </div>

        </div>


        <div class="card shadow-sm border-0 mb-4">

            <div class="card-header py-3">
                <h5 class="fw-bold mb-0">
                    Productos más vendidos hoy
                </h5>
            </div>

            <div class="card-body">

                <div class="table-responsive">

                    <asp:GridView ID="gvProductos"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-hover align-middle"
                        EmptyDataText="Todavía no hay productos vendidos hoy.">

                        <Columns>

                            <asp:BoundField DataField="Producto"
                                HeaderText="Producto" />

                            <asp:BoundField DataField="Tipo"
                                HeaderText="Tipo" />

                            <asp:BoundField DataField="CantidadVendida"
                                HeaderText="Cantidad vendida" />

                            <asp:BoundField DataField="TotalRecaudado"
                                HeaderText="Total recaudado"
                                DataFormatString="{0:N2}" />

                        </Columns>

                    </asp:GridView>

                </div>

            </div>
        </div>

        <div class="card shadow-sm border-0 mb-4">

            <div class="card-header py-3">
                <h5 class="fw-bold mb-0">Pedidos por meseros gestionados hoy</h5>
                
            </div>

            <div class="card-body">

                <div class="table-responsive">

                    <asp:GridView ID="gvMeseros"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-hover align-middle"
                        EmptyDataText="Todavía no hay pedidos gestionados hoy.">

                        <Columns>

                            <asp:BoundField DataField="Mesero"
                                HeaderText="Mesero" />

                            <asp:BoundField DataField="CantidadPedidosXMesero"
                                HeaderText="Cantidad de pedidos por mesero" />


                            <asp:BoundField DataField="TotalRecaudadoXMesero"
                                HeaderText="Total recaudado por mesero"
                                DataFormatString="{0:N2}" />

                        </Columns>

                    </asp:GridView>

                </div>

            </div>
        </div>

        <div class="card shadow-sm border-0 mb-4">

            <div class="card-header py-3">
                <h5 class="fw-bold mb-0">Pedidos y recaudación por mesa hoy</h5>
            </div>

            <div class="card-body">
                <div class="table-responsive">

                    <asp:GridView ID="gvMesas"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-hover align-middle"
                        EmptyDataText="Todavía no hay pedidos cobrados por mesa hoy.">

                        <Columns>
                            <asp:BoundField DataField="Mesa"
                                HeaderText="Mesa" />

                            <asp:BoundField DataField="CantidadPedidosXMesa"
                                HeaderText="Cantidad de pedidos" />

                            <asp:BoundField DataField="TotalRecaudadoXMesa"
                                HeaderText="Total recaudado por mesa"
                                DataFormatString="{0:N2}" />
                        </Columns>

                    </asp:GridView>

                </div>
            </div>
        </div>

    </div>

</asp:Content>
