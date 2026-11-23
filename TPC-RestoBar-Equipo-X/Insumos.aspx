<%@ Page Title="Administración de Insumos" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Insumos.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.Insumos" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Cabecera de la sección -->
    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #334155; padding-bottom: 14px; margin-bottom: 20px;">
        <div>
            <h2 style="margin: 0 0 4px 0; font-weight: bold; color: #f8fafc;">Stock e Insumos Actuales</h2>
            <small style="color: #94a3b8;">Gestioná el inventario por categoría, sumá stock rápido o cargá nuevos productos.</small>
        </div>

        <!-- Botón Nuevo Insumo (abre el panel lateral limpio) -->
        <button class="btn btn-primary fw-bold shadow-sm d-flex align-items-center" type="button" data-bs-toggle="drawer" data-bs-target="#drawerFormulario">
            <i class="bi bi-plus-lg me-2"></i>Nuevo Insumo
        </button>
    </div>

    <!-- PESTAÑAS TIPO NAVEGADOR + BUSCADOR -->
    <div style="display: flex; justify-content: space-between; align-items: flex-end; flex-wrap: wrap; gap: 10px; border-bottom: 2px solid #334155;">

        <!-- Pestañas -->
        <div style="display: flex; gap: 4px; margin-bottom: -2px;">
            <asp:Button ID="btnTabComida" runat="server" Text="🍔 Comidas" CommandArgument="Comida" OnClick="CambiarTab_Click"
                Style="padding: 10px 22px; border-radius: 10px 10px 0 0; border: 1px solid #334155; border-bottom: 2px solid #1e293b; background-color: #1e293b; color: #38bdf8; font-weight: bold; font-size: 14px; cursor: pointer;" />

            <asp:Button ID="btnTabBebida" runat="server" Text="🍺 Bebidas" CommandArgument="Bebida" OnClick="CambiarTab_Click"
                Style="padding: 10px 22px; border-radius: 10px 10px 0 0; border: 1px solid transparent; border-bottom: none; background-color: #0f172a; color: #94a3b8; font-weight: 600; font-size: 14px; cursor: pointer;" />

            <asp:Button ID="btnTabBazar" runat="server" Text="📦 Bazar / Otros" CommandArgument="Bazar" OnClick="CambiarTab_Click"
                Style="padding: 10px 22px; border-radius: 10px 10px 0 0; border: 1px solid transparent; border-bottom: none; background-color: #0f172a; color: #94a3b8; font-weight: 600; font-size: 14px; cursor: pointer;" />
        </div>

        <!-- Buscador compacto alineado a la derecha -->
        <div style="display: flex; gap: 8px; padding-bottom: 8px;">
            <asp:TextBox ID="txtBuscarNombre" runat="server" placeholder="Buscar en esta pestaña..."
                AutoPostBack="true" OnTextChanged="txtBuscarNombre_TextChanged"
                Style="padding: 6px 12px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 13px; width: 220px;" />

            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" OnClick="txtBuscarNombre_TextChanged"
                Style="padding: 6px 14px; border-radius: 6px; border: none; background-color: #2563eb; color: white; font-size: 13px; font-weight: bold; cursor: pointer;" />

            <asp:Button ID="btnLimpiar" runat="server" Text="✕" OnClick="btnLimpiar_Click" ToolTip="Limpiar búsqueda"
                Style="padding: 6px 10px; border-radius: 6px; border: 1px solid #475569; background-color: transparent; color: #94a3b8; font-size: 13px; cursor: pointer;" />
        </div>
    </div>

    <!-- TABLA PRINCIPAL (Contenedor integrado con la pestaña activa) -->
    <div style="background-color: #1e293b; border: 1px solid #334155; border-top: none; border-radius: 0 0 10px 10px; overflow: hidden; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.3);">
        <asp:GridView ID="dgvInsumos" runat="server" AutoGenerateColumns="False"
            DataKeyNames="Id" OnRowCommand="dgvInsumos_RowCommand"
            EmptyDataText="No hay insumos cargados en esta categoría."
            CssClass="table table-dark table-hover align-middle mb-0" GridLines="None">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-CssClass="fw-bold text-secondary ps-3" HeaderStyle-CssClass="ps-3" />
                <asp:BoundField DataField="Nombre" HeaderText="Insumo" ItemStyle-CssClass="fw-semibold" />
                <asp:BoundField DataField="StockActual" HeaderText="Stock Actual" ItemStyle-CssClass="fw-bold text-info" />
                <asp:BoundField DataField="PrecioVenta" HeaderText="Precio Venta" DataFormatString="{0:C}" />

                <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end pe-3" HeaderStyle-CssClass="text-end pe-3">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnSumar" runat="server"
                            CommandName="AbrirSumar"
                            CommandArgument='<%# Container.DataItemIndex %>'
                            CssClass="btn btn-sm btn-success fw-bold me-1"
                            title="Sumar stock rápidamente">
                            ➕ Sumar
                        </asp:LinkButton>

                        <asp:LinkButton ID="btnEditar" runat="server"
                            CommandName="Editar"
                            CommandArgument='<%# Container.DataItemIndex %>'
                            CssClass="btn btn-sm btn-warning me-1"
                            title="Editar datos">
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

    <!-- MODAL FLOTANTE RÁPIDO PARA SUMAR STOCK -->
    <asp:Panel ID="pnlSumarStock" runat="server" Visible="false"
        Style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7); display: flex; justify-content: center; align-items: center; z-index: 9999;">

        <div style="background-color: #1e293b; border: 1px solid #475569; border-radius: 12px; padding: 24px; width: 100%; max-width: 360px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5); color: white;">

            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #334155; padding-bottom: 10px; margin-bottom: 14px;">
                <h5 style="margin: 0; font-weight: bold; font-size: 17px; color: #4ade80;">➕ Sumar Stock</h5>
                <asp:Button ID="btnCerrarModalSumar" runat="server" Text="✕" OnClick="btnCerrarModalSumar_Click"
                    Style="background: none; border: none; color: #94a3b8; font-size: 18px; cursor: pointer; padding: 0 4px;" />
            </div>

            <asp:HiddenField ID="hfIdSumar" runat="server" />

            <div style="margin-bottom: 14px;">
                <div style="font-size: 15px; font-weight: bold; color: #f8fafc;">
                    <asp:Label ID="lblProductoSumar" runat="server" />
                </div>
                <div style="font-size: 13px; color: #38bdf8; margin-top: 2px;">
                    <asp:Label ID="lblStockActualSumar" runat="server" />
                </div>
            </div>

            <div style="margin-bottom: 18px;">
                <label style="display: block; font-size: 13px; color: #cbd5e1; margin-bottom: 6px;">Cantidad que ingresa:</label>
                <asp:TextBox ID="txtCantidadSumar" runat="server" TextMode="Number" placeholder="Ej: 12"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 15px; box-sizing: border-box;" />
            </div>

            <div style="display: flex; gap: 10px;">
                <asp:Button ID="btnCancelarSumar" runat="server" Text="Cancelar" OnClick="btnCerrarModalSumar_Click"
                    Style="flex: 1; padding: 8px; border-radius: 6px; border: 1px solid #475569; background-color: transparent; color: #cbd5e1; font-size: 13px; font-weight: 600; cursor: pointer;" />

                <asp:Button ID="btnConfirmarSumar" runat="server" Text="Confirmar Suma" OnClick="btnConfirmarSumar_Click"
                    Style="flex: 1; padding: 8px; border-radius: 6px; border: none; background-color: #16a34a; color: white; font-size: 13px; font-weight: 600; cursor: pointer;" />
            </div>
        </div>
    </asp:Panel>

        <!-- PANEL FLOTANTE DE LA DERECHA (Solo para Nuevo Insumo o Editar) -->
    <dialog class="drawer drawer-end bg-dark text-white shadow-lg" id="drawerFormulario" style="--bs-drawer-width: 420px; border-left: 1px solid #334155;">
        <div class="drawer-header border-bottom border-secondary py-3 bg-dark text-white">
            <h5 class="drawer-title fw-bold text-white mb-0">
                <i class="bi bi-plus-circle text-warning me-2"></i>Datos del Insumo
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="drawer" aria-label="Close"></button>
        </div>
        <div class="drawer-body p-4">
            <div class="vstack gap-3">
                <div class="form-field">
                    <label class="form-label fw-semibold text-light">Nombre del Insumo</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control bg-dark text-white border-secondary" Placeholder="Ej: Coca Cola, Servilletas..."></asp:TextBox>
                </div>

                <div class="form-field">
                    <label class="form-label fw-semibold text-light">Categoría</label>
                    <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control bg-dark text-white border-secondary">
                        <asp:ListItem Text="Comidas / Ingredientes" Value="Comida" />
                        <asp:ListItem Text="Bebidas" Value="Bebida" />
                        <asp:ListItem Text="Librería / Bazar" Value="Bazar" />
                    </asp:DropDownList>
                </div>

                <div class="form-field">
                    <label class="form-label fw-semibold text-light">Cantidad / Stock Inicial</label>
                    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control bg-dark text-white border-secondary" TextMode="Number" Placeholder="0"></asp:TextBox>
                </div>

                <div class="form-field">
                    <label class="form-label fw-semibold text-light">Precio de Venta</label>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control bg-dark text-white border-secondary" Placeholder="0.00"></asp:TextBox>
                </div>

                <%-- Mensaje de advertencia si el producto ya existe o falta el nombre --%>
                <asp:Label ID="lblErrorDrawer" runat="server" Visible="false"
                    Style="display: block; padding: 8px 12px; border-radius: 6px; background-color: rgba(239, 68, 68, 0.2); border: 1px solid #ef4444; color: #fca5a5; font-size: 13px; font-weight: 600;" />

                <div class="pt-2">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Insumo" CssClass="btn btn-primary w-100 fw-bold shadow-sm py-2" OnClick="btnGuardar_Click" />
                </div>
            </div>
        </div>
    </dialog>

</asp:Content>
