<%@ Page Title="Administración de Insumos" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Insumos.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.Insumos" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Cabecera de la sección: Título a la izquierda, Botón a la derecha -->
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
        <div class="d-flex align-items-center">
            <i class="bi bi-list-task text-primary fs-3 me-2"></i>
            <h2 class="mb-0 fw-bold text-dark">Stock e Insumos Actuales</h2>
        </div>

        <!-- Botón que abre el formulario (Alineado arriba a la derecha) -->
        <button class="btn btn-primary fw-bold shadow-sm d-flex align-items-center" type="button" data-bs-toggle="drawer" data-bs-target="#drawerFormulario">
            <i class="bi bi-plus-lg me-2"></i>Nuevo Insumo
       
        </button>
    </div>

    <!-- Tabla Principal de Insumos -->
    <div class="card border border-light shadow-sm">
        <div class="card-body p-0">
            <asp:GridView ID="dgvInsumos" runat="server" AutoGenerateColumns="False"
                DataKeyNames="IdInsumo" OnRowCommand="dgvInsumos_RowCommand"
                CssClass="table table-striped table-hover align-middle mb-0" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="IdInsumo" HeaderText="ID" ItemStyle-CssClass="fw-bold text-secondary" />
                    <asp:BoundField DataField="Nombre" HeaderText="Insumo" />
                    <asp:BoundField DataField="Tipo" HeaderText="Categoría" />
                    <asp:BoundField DataField="StockActual" HeaderText="Stock Actual" />
                    <asp:BoundField DataField="PrecioVenta" HeaderText="Precio Venta" DataFormatString="{0:C}" />

                    <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end pe-3">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEditar" runat="server"
                                CommandName="Editar"
                                CommandArgument='<%# Container.DataItemIndex %>'
                                CssClass="btn btn-sm btn-warning me-1"
                                title="Editar">
                                ✏️ Editar
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnEliminar" runat="server"
                                CommandName="Eliminar"
                                CommandArgument='<%# Container.DataItemIndex %>'
                                CssClass="btn btn-sm btn-danger"
                                title="Eliminar">
                                🗑️ Borrar
                             </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- PANEL FLOTANTE DE LA DERECHA (Oculto por defecto) -->
    <dialog class="drawer drawer-end bg-white text-dark shadow-lg" id="drawerFormulario" style="--bs-drawer-width: 450px;">
        <div class="drawer-header border-bottom py-3 bg-dark text-white">
            <h5 class="drawer-title fw-bold text-white mb-0">
                <i class="bi bi-plus-circle text-warning me-2"></i>Cargar Nuevo Insumo
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="drawer" aria-label="Close"></button>
        </div>
        <div class="drawer-body p-4">
            <!-- Formulario apilado verticalmente -->
            <div class="vstack gap-4">

                <!-- Nombre del Insumo -->
                <div class="form-field">
                    <label class="form-label fw-semibold text-secondary">Nombre del Insumo</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Placeholder="Ej: Coca Cola, Servilletas..."></asp:TextBox>
                </div>

                <!-- Categoría -->
                <div class="form-field">
                    <label class="form-label fw-semibold text-secondary">Categoría</label>
                    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Bebidas" Value="Bebida" />
                        <asp:ListItem Text="Comidas / Ingredientes" Value="Comida" />
                        <asp:ListItem Text="Librería / Bazar" Value="Bazar" />
                    </asp:DropDownList>
                </div>

                <!-- Stock Inicial -->
                <div class="form-field">
                    <label class="form-label fw-semibold text-secondary">Cantidad / Stock Inicial</label>
                    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" Placeholder="0"></asp:TextBox>
                </div>

                <!-- Precio de Venta -->
                <div class="form-field">
                    <label class="form-label fw-semibold text-secondary">Precio de Venta</label>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" Placeholder="0.00"></asp:TextBox>
                </div>

                <!-- Botón de Guardar en la parte inferior del panel -->
                <div class="pt-3">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Insumo" CssClass="btn btn-primary w-100 fw-bold shadow-sm py-2" OnClick="btnGuardar_Click" />
                </div>

            </div>
        </div>
    </dialog>

</asp:Content>
