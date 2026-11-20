
<%@ Page Title="Mis Mesas" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PanelMesero.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.PanelMesero" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="resto-panel">

        
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <div>
                <h2 class="fw-bold mb-1">Mis Mesas Asignadas</h2>
                <p class="text-muted mb-0">
                    Consultá y gestioná los pedidos de cada mesero.
                </p>
            </div>

            <span class="etiqueta-panel">Gestión de pedidos</span>
        </div>


        <div class="selector-panel mb-4">
            <label class="form-label fw-bold">Seleccionar mesero</label>

            <asp:DropDownList
                ID="ddlMeseros"
                runat="server"
                CssClass="form-select"
                AutoPostBack="true"
                OnSelectedIndexChanged="ddlMeseros_SelectedIndexChanged">
            </asp:DropDownList>
        </div>

        <asp:Label ID="lblMensaje"
            runat="server"
            CssClass="d-block mb-3 text-danger" />

        <asp:Label ID="lblSinPedidos"
            runat="server"
            Visible="false"
            Text="Este mesero no tiene pedidos abiertos."
            CssClass="d-block mb-3 text-muted" />

        <div class="row g-4">


    <div class="col-12 col-lg-7">

        <h4 class="fw-bold mb-3">Pedidos abiertos</h4>

        <div class="row g-3">

            <asp:Repeater ID="rptPedidos" runat="server">
                <ItemTemplate>

                    <div class="col-12">

                        <div class="mesa-card h-100">

                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div>
                                    <h5 class="fw-bold mb-1">
                                        Mesa <%#: Eval("Mesa.NumeroMesa") %>
                                    </h5>

                                    <p class="mb-1">
                                        Pedido #<%#: Eval("ID") %>
                                    </p>

                                    <p class="text-muted small mb-1">
                                        Capacidad: <%#: Eval("Mesa.Capacidad") %> personas
                                    </p>

                                    <p class="text-muted small mb-0">
                                        Apertura:
                                        <%#: Eval("FechaApertura", "{0:dd/MM/yyyy HH:mm}") %>
                                    </p>
                                </div>

                                <span class="estado-abierto">Abierto</span>
                            </div>

                            <div class="text-end mt-3">
                                <asp:LinkButton
                                    ID="btnGestionar"
                                    runat="server"
                                    Text="Gestionar pedido"
                                    CssClass="btn-gestionar"
                                    CommandArgument='<%# Eval("ID") %>'
                                    OnCommand="btnGestionar_Command" />
                            </div>

                        </div>

                    </div>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>


    <div class="col-12 col-lg-5">

        <div id="zonaGestion">

            <asp:Panel ID="Panel1"
                runat="server"
                Visible="false"
                CssClass="pedido-detalle">

                <asp:HiddenField ID="HiddenField1" runat="server" />

                <div class="mb-4">
                    <h3 class="fw-bold mb-2">Gestionar pedido</h3>

                    <asp:Label ID="Label1"
                        runat="server"
                        CssClass="text-muted" />
                </div>

                <h5 class="fw-bold mb-3">Comidas y bebidas disponibles</h5>

                <div class="table-responsive">

                    <asp:GridView ID="GridView1"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-hover align-middle">

                        <Columns>

                            <asp:BoundField DataField="Nombre"
                                HeaderText="Producto" />

                            <asp:BoundField DataField="Tipo"
                                HeaderText="Tipo" />

                            <asp:BoundField DataField="Precio"
                                HeaderText="Precio"
                                DataFormatString="{0:N2}" />

                            <asp:BoundField DataField="StockActual"
                                HeaderText="Stock" />

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>
                                    <asp:LinkButton
                                        ID="btnElegirConsumicion"
                                        runat="server"
                                        Text="Seleccionar"
                                        CssClass="btn btn-primary btn-sm"
                                        CommandArgument='<%# Eval("ID") %>'
                                        CommandName='<%# Eval("Nombre") %>'
                                        OnCommand="btnElegirConsumicion_Command" />
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>

                <asp:Panel ID="Panel2"
                    runat="server"
                    Visible="false"
                    CssClass="producto-seleccionado mt-4">

                    <asp:HiddenField ID="HiddenField2"
                        runat="server" />

                    <h5 class="fw-bold mb-3">Producto seleccionado</h5>

                    <asp:Label ID="Label2"
                        runat="server"
                        CssClass="d-block mb-3 fw-bold" />

                    <label class="form-label">Cantidad:</label>

                    <asp:TextBox ID="TextBox1"
                        runat="server"
                        TextMode="Number"
                        Text="1"
                        min="1"
                        CssClass="form-control"
                        Width="120px" />

                    <p class="text-muted small mt-3 mb-0">
                        El guardado de productos en el pedido se implementará en el siguiente paso.
                    </p>

                </asp:Panel>

            </asp:Panel>

        </div>

    </div>

</div>


        <div id="zonaGestion">

            <asp:Panel ID="pnlPedido"
                runat="server"
                Visible="false"
                CssClass="pedido-detalle mt-4">

                <asp:HiddenField ID="hfPedidoId" runat="server" />

                <div class="mb-4">
                    <h3 class="fw-bold mb-2">Gestionar pedido</h3>

                    <asp:Label ID="lblPedidoElegido"
                        runat="server"
                        CssClass="text-muted" />
                </div>

                <h5 class="fw-bold mb-3">Comidas y bebidas disponibles</h5>

                <div class="table-responsive">

                    <asp:GridView ID="gvConsumiciones"
                        runat="server"
                        AutoGenerateColumns="false"
                        GridLines="None"
                        CssClass="table table-hover align-middle">

                        <Columns>

                            <asp:BoundField DataField="Nombre"
                                HeaderText="Producto" />

                            <asp:BoundField DataField="Tipo"
                                HeaderText="Tipo" />

                            <asp:BoundField DataField="Precio"
                                HeaderText="Precio"
                                DataFormatString="{0:N2}" />

                            <asp:BoundField DataField="StockActual"
                                HeaderText="Stock" />

                            <asp:TemplateField HeaderText="Acción">
                                <ItemTemplate>

                                    <asp:LinkButton
                                        ID="btnElegirConsumicion"
                                        runat="server"
                                        Text="Seleccionar"
                                        CssClass="btn btn-primary btn-sm"
                                        CommandArgument='<%# Eval("ID") %>'
                                        CommandName='<%# Eval("Nombre") %>'
                                        OnCommand="btnElegirConsumicion_Command" />

                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>

                    </asp:GridView>

                </div>


                <asp:Panel ID="pnlAgregar"
                    runat="server"
                    Visible="false"
                    CssClass="producto-seleccionado mt-4">

                    <asp:HiddenField ID="hfConsumicionId"
                        runat="server" />

                    <h5 class="fw-bold mb-3">Producto seleccionado</h5>

                    <asp:Label ID="lblConsumicionElegida"
                        runat="server"
                        CssClass="d-block mb-3 fw-bold" />

                    <label class="form-label">Cantidad:</label>

                    <asp:TextBox ID="txtCantidad"
                        runat="server"
                        TextMode="Number"
                        Text="1"
                        min="1"
                        CssClass="form-control"
                        Width="120px" />

                    <p class="text-muted small mt-3 mb-0">
                        El guardado de productos en el pedido se implementará en el siguiente paso.
                    </p>

                </asp:Panel>

            </asp:Panel>

        </div>

    </div>

</asp:Content>


<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PanelMesero.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.PanelMesero" %>
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
</asp:Content>--%>
