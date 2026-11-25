<%@ Page Title="Mis Mesas" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="PanelMesero.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.PanelMesero" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdatePanel ID="upPanelMesero" runat="server">
        <ContentTemplate>
            <div class="resto-panel">

                <%-- CABECERA Y SELECTOR DE MESERO --%>
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4 pb-3 border-bottom border-secondary border-opacity-25">
                    <div>
                        <h2 class="fw-bold mb-1">Mis Mesas Asignadas</h2>
                        <p class="text-muted mb-0">Consultá y gestioná los pedidos de cada mesero.</p>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <div class="selector-panel m-0">
                            <asp:DropDownList
                                ID="ddlMeseros"
                                runat="server"
                                CssClass="form-select"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="ddlMeseros_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                        <span class="etiqueta-panel">Gestión de pedidos</span>
                    </div>
                </div>
                <asp:Label ID="lblMensaje" runat="server" CssClass="d-block mb-3 text-danger" />
                <asp:Label ID="lblSinPedidos" runat="server" Visible="false" Text="Este mesero no tiene pedidos abiertos." CssClass="d-block mb-3 text-muted" />

                <%-- INICIO DE PANTALLA DIVIDIDA --%>
                <div class="row g-4 align-items-start">

                    <%-- COLUMNA IZQUIERDA (5 cols): GRILLA DE MESAS --%>
                    <div class="col-12 col-lg-5">
                        <h4 class="fw-bold mb-3">Pedidos abiertos</h4>
                        <div class="row g-3">
                            <asp:Repeater ID="rptPedidos" runat="server" OnItemDataBound="rptPedidos_ItemDataBound">


                                <ItemTemplate>
                                    <div class="col-12">
                                        <div class="mesa-card p-4 mb-3">

                                            <%-- CABECERA DE LA TARJETA (Siempre visible) --%>
                                            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                                                <div>
                                                    <h5 class="fw-bold mb-1">Mesa <%#: Eval("Mesa.NumeroMesa") %> <span class="text-info ms-2">Pedido #<%#: Eval("ID") %></span></h5>
                                                    <p class="text-muted small mb-0">
                                                        Capacidad: <%#: Eval("Mesa.Capacidad") %> pers. | Apertura: <%#: Eval("FechaApertura", "{0:HH:mm}") %> hs
                                                    </p>
                                                </div>

                                                <div class="d-flex align-items-center gap-2">
                                                    <span class="estado-abierto">Abierto</span>
                                                    <asp:LinkButton
                                                        ID="btnGestionar"
                                                        runat="server"
                                                        Text="Gestionar pedido"
                                                        CssClass="btn btn-primary btn-sm fw-semibold"
                                                        CommandArgument='<%# Eval("ID") %>'
                                                        OnCommand="btnGestionar_Command" />
                                                </div>
                                            </div>

                                            <%-- PANEL DESPLEGABLE DENTRO DE LA MISMA TARJETA --%>
                                            <asp:Panel ID="pnlDetalleMesa" runat="server" Visible="false" CssClass="mt-4 pt-3 border-top border-secondary border-opacity-50">

                                                <%-- BARRA DE CARGA DIRECTA (1 solo paso, sin Repeaters anidados) --%>
                                                <div class="p-3 mb-4 rounded border border-info" style="background-color: rgba(13, 202, 240, 0.08);">
                                                    <div class="row g-2 align-items-end">
                                                        <div class="col-12 col-md-6">
                                                            <label class="form-label small fw-bold mb-1">Seleccionar producto:</label>
                                                            <asp:DropDownList ID="ddlProductosItem" runat="server" CssClass="form-select form-select-sm">
                                                            </asp:DropDownList>
                                                        </div>

                                                        <div class="col-6 col-md-3">
                                                            <label class="form-label small fw-bold mb-1">Cantidad:</label>
                                                            <asp:TextBox ID="txtCantidadItem" runat="server" TextMode="Number" Text="1" min="1" CssClass="form-control form-control-sm" />
                                                        </div>

                                                        <div class="col-6 col-md-3">
                                                            <asp:Button ID="btnAgregarItem" runat="server" Text="+ Agregar"
                                                                CssClass="btn btn-success btn-sm w-100 fw-semibold"
                                                                CommandArgument='<%# Eval("Id") %>'
                                                                OnClick="btnAgregarItem_Click" />

                                                        </div>
                                                    </div>
                                                </div>

                                                <%-- Grilla de consumiciones cargadas en esta mesa --%>
                                                <div class="row g-3">
                                                    <div class="col-12">

                                                        <div class="col-12 col-lg-6">
                                                            <h6 class="fw-bold small text-uppercase text-muted">Consumiciones de esta mesa</h6>
                                                            <div class="table-responsive" style="max-height: 230px; overflow-y: auto;">
                                                                <asp:GridView ID="gvConsumicionesItem" runat="server" AutoGenerateColumns="false" GridLines="None" CssClass="table table-sm table-striped align-middle" EmptyDataText="Sin consumiciones aún.">
                                                                    <Columns>
                                                                        <asp:BoundField DataField="Nombre" HeaderText="Producto" />
                                                                        <asp:BoundField DataField="Cantidad" HeaderText="Cant." />
                                                                        <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="${0:N2}" />
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <%-- Pie de la tarjeta desplegada: Total y Cobrar --%>
                                                    <div class="mt-3 pt-3 border-top border-secondary border-opacity-25 d-flex justify-content-between align-items-center">
                                                        <asp:Label ID="lblTotalItem" runat="server" Text="Total: $0,00" CssClass="fs-5 fw-bold text-success mb-0" />
                                                        <asp:Button ID="btnCobrarMesa" runat="server"
                                                            Text="Confirmar cobro y liberar mesa"
                                                            CssClass="btn btn-primary btn-sm fw-semibold"
                                                            CommandArgument='<%# Eval("Id") %>'
                                                            OnClientClick="return confirm('¿Confirmar el cobro de este pedido y liberar la mesa?');"
                                                            OnClick="btnCobrarMesa_Click" />

                                                    </div>
                                            </asp:Panel>

                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>

                        </div>
                    </div>

                </div>
                <%-- Cierre row g-3 --%>
            </div>
            <%-- Cierre columna --%>
                </div> <%-- Cierre row g-4 --%>

            <%-- CAMPOS OCULTOS GLOBALES --%>
            <asp:HiddenField ID="hfPedidoId" runat="server" />
            <asp:HiddenField ID="hfInsumoId" runat="server" />
            <asp:HiddenField ID="hfInsumoNombre" runat="server" />

            <%-- DIALOG DE CONFIRMACIÓN DE COBRO --%>


            </div> <%-- Cierre resto-panel --%>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
