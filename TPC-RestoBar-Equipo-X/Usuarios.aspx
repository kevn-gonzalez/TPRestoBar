<%@ Page Title="Gestión de Personal y Meseros" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.Usuarios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Cabecera -->
    <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #334155; padding-bottom: 14px; margin-bottom: 20px;">
        <div>
            <h2 style="margin: 0 0 4px 0; font-weight: bold; color: #f8fafc;">Personal y Meseros</h2>
            <small style="color: #94a3b8;">Administrá los meseros y usuarios que operan en el resto-bar.</small>
        </div>

        <asp:Button ID="btnAbrirModalNuevo" runat="server" Text="+ Nuevo Usuario / Mesero" OnClick="btnAbrirModalNuevo_Click"
            Style="padding: 9px 18px; border-radius: 8px; border: none; background-color: #2563eb; color: white; font-size: 14px; font-weight: bold; cursor: pointer;" />
    </div>

    <asp:Label ID="lblMensaje" runat="server"
        Style="display: block; margin-bottom: 14px; font-weight: bold; font-size: 14px;" />

    <!-- Tabla de Usuarios -->
    <div style="background-color: #1e293b; border: 1px solid #334155; border-radius: 10px; overflow: hidden; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.3);">
        <asp:GridView ID="dgvUsuarios" runat="server" AutoGenerateColumns="False"
            DataKeyNames="ID" OnRowCommand="dgvUsuarios_RowCommand"
            EmptyDataText="No hay usuarios registrados."
            CssClass="table table-dark table-hover align-middle mb-0" GridLines="None">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" ItemStyle-CssClass="fw-bold text-secondary ps-3" HeaderStyle-CssClass="ps-3" />
                <asp:BoundField DataField="Nombre" HeaderText="Nombre Completo" ItemStyle-CssClass="fw-semibold" />
                <asp:BoundField DataField="Username" HeaderText="Usuario (Login)" ItemStyle-CssClass="text-info" />
                
                <asp:TemplateField HeaderText="Perfil">
                    <ItemTemplate>
                        <span style='<%# Eval("TipoUsuario").ToString() == "ADMIN" 
                            ? "background-color: #7c3aed; color: white; padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold;" 
                            : "background-color: #0284c7; color: white; padding: 3px 10px; border-radius: 12px; font-size: 12px; font-weight: bold;" %>'>
                            <%# Eval("TipoUsuario").ToString() == "ADMIN" ? "Admin" : "Mesero" %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end pe-3" HeaderStyle-CssClass="text-end pe-3">
                    <ItemTemplate>
                        <asp:LinkButton ID="btnEliminar" runat="server"
                            CommandName="Eliminar"
                            CommandArgument='<%# Container.DataItemIndex %>'
                            CssClass="btn btn-sm btn-danger"
                            title="Eliminar usuario">
                            🗑️ Eliminar
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <!-- MODAL FLOTANTE PARA NUEVO MESERO / USUARIO -->
    <asp:Panel ID="pnlModalUsuario" runat="server" Visible="false"
        Style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7); display: flex; justify-content: center; align-items: center; z-index: 9999;">
        
        <div style="background-color: #1e293b; border: 1px solid #475569; border-radius: 12px; padding: 24px; width: 100%; max-width: 380px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5); color: white;">
            
            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #334155; padding-bottom: 10px; margin-bottom: 16px;">
                <h5 style="margin: 0; font-weight: bold; font-size: 18px;">Nuevo Usuario / Mesero</h5>
                <asp:Button ID="btnCerrarModal" runat="server" Text="✕" OnClick="btnCerrarModal_Click"
                    Style="background: none; border: none; color: #94a3b8; font-size: 18px; cursor: pointer; padding: 0 4px;" />
            </div>

            <div style="margin-bottom: 12px;">
                <label style="display: block; font-size: 12px; color: #cbd5e1; margin-bottom: 4px;">Nombre Completo</label>
                <asp:TextBox ID="txtNombre" runat="server" placeholder="Ej: Juan Pérez"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 14px; box-sizing: border-box;" />
            </div>

            <div style="margin-bottom: 12px;">
                <label style="display: block; font-size: 12px; color: #cbd5e1; margin-bottom: 4px;">Nombre de Usuario (Login)</label>
                <asp:TextBox ID="txtUsername" runat="server" placeholder="Ej: jperez"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 14px; box-sizing: border-box;" />
            </div>

            <div style="margin-bottom: 12px;">
                <label style="display: block; font-size: 12px; color: #cbd5e1; margin-bottom: 4px;">Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="••••••"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 14px; box-sizing: border-box;" />
            </div>

            <div style="margin-bottom: 16px;">
                <label style="display: block; font-size: 12px; color: #cbd5e1; margin-bottom: 4px;">Perfil / Rol</label>
                <asp:DropDownList ID="ddlPerfil" runat="server"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 14px;">
                    <asp:ListItem Text="Mesero" Value="Mesero" Selected="True" />
                    <asp:ListItem Text="Administrador" Value="Admin" />
                </asp:DropDownList>
            </div>

            <asp:Label ID="lblErrorModal" runat="server" Visible="false"
                Style="display: block; margin-bottom: 12px; color: #fca5a5; font-size: 13px; font-weight: 600;" />

            <div style="display: flex; gap: 10px;">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" OnClick="btnCerrarModal_Click"
                    Style="flex: 1; padding: 8px; border-radius: 6px; border: 1px solid #475569; background-color: transparent; color: #cbd5e1; font-size: 13px; font-weight: 600; cursor: pointer;" />
                
                <asp:Button ID="btnGuardarUsuario" runat="server" Text="Guardar" OnClick="btnGuardarUsuario_Click"
                    Style="flex: 1; padding: 8px; border-radius: 6px; border: none; background-color: #16a34a; color: white; font-size: 13px; font-weight: 600; cursor: pointer;" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>
