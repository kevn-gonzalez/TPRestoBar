<%@ Page Title="Asignación de Mesas" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="AsignacionMesa.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.AsignacionMesa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Cabecera de la sección -->
    <div style="border-bottom: 1px solid #334155; padding-bottom: 14px; margin-bottom: 18px;">
        <h2 style="margin: 0 0 4px 0; font-weight: bold; color: #f8fafc;">Mapa de Asignación de Mesas</h2>
        <small style="color: #94a3b8;">Hacé clic sobre una mesa para asignar un mesero o liberarla.</small>
    </div>

    <!-- Referencias de Colores -->
    <div style="display: flex; align-items: center; gap: 20px; background-color: #1e293b; border: 1px solid #334155; padding: 10px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 13px; color: #cbd5e1;">
        <span style="font-weight: bold; color: #f8fafc;">Referencias:</span>
        <div style="display: flex; align-items: center; gap: 6px;">
            <span style="width: 12px; height: 12px; border-radius: 50%; background-color: #22c55e; display: inline-block;"></span>
            <span>Disponible</span>
        </div>
        <div style="display: flex; align-items: center; gap: 6px;">
            <span style="width: 12px; height: 12px; border-radius: 50%; background-color: #ef4444; display: inline-block;"></span>
            <span>Ocupada / Reservada</span>
        </div>
    </div>

    <!-- Mensaje de estado / feedback -->
    <asp:Label ID="lblMensaje" runat="server"
        Style="display: block; margin-bottom: 14px; font-weight: bold; font-size: 14px; color: #38bdf8;" />

    <!-- MAPA DE MESAS -->
    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(145px, 155px)); gap: 15px; margin-top: 10px;">
        <asp:Repeater ID="rptMesas" runat="server">
            <ItemTemplate>
                <div style='<%# Eval("Estado").ToString() == "Libre" 
                    ? "width: 150px; height: 150px; background-color: #1e293b; border: 2px solid #22c55e; border-radius: 10px; padding: 10px; display: flex; flex-direction: column; justify-content: space-between; text-align: center; color: white;" 
                    : "width: 150px; height: 150px; background-color: #451a1a; border: 2px solid #ef4444; border-radius: 10px; padding: 10px; display: flex; flex-direction: column; justify-content: space-between; text-align: center; color: white;" %>'>

                    <%-- Número de mesa y capacidad --%>
                    <div>
                        <div style="font-weight: bold; font-size: 16px; line-height: 1.2;">Mesa <%# Eval("NumeroMesa") %></div>
                        <div style="font-size: 12px; color: #cbd5e1;">Cap: <%# Eval("Capacidad") %></div>
                    </div>

                    <%-- Etiqueta de estado --%>
                    <div>
                        <span style='<%# Eval("Estado").ToString() == "Libre" 
                            ? "background-color: #22c55e; color: #fff; font-size: 11px; padding: 2px 8px; border-radius: 12px; font-weight: bold;" 
                            : "background-color: #ef4444; color: #fff; font-size: 11px; padding: 2px 8px; border-radius: 12px; font-weight: bold;" %>'>
                            <%# Eval("Estado").ToString() == "Libre" ? "Libre" : "Reservada" %>
                        </span>
                    </div>

                    <%-- Botón abajo --%>
                    <asp:Button ID="btnSeleccionar" runat="server"
                        Text='<%# Eval("Estado").ToString() == "Libre" ? "Asignar Mesero" : "Desasignar" %>'
                        Style='<%# Eval("Estado").ToString() == "Libre" 
                            ? "width: 100%; background-color: #16a34a; color: white; border: none; border-radius: 5px; padding: 4px; font-size: 12px; font-weight: bold; cursor: pointer;" 
                            : "width: 100%; background-color: #dc2626; color: white; border: none; border-radius: 5px; padding: 4px; font-size: 12px; font-weight: bold; cursor: pointer;" %>'
                        CommandName='<%# Eval("Estado").ToString() == "Libre" ? "Asignar" : "Desasignar" %>'
                        CommandArgument='<%# Eval("Id") %>'
                        OnCommand="btnSeleccionar_Command" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <!-- FORMULARIO COMPACTO PARA AGREGAR NUEVA MESA -->
    <div style="margin-top: 28px; background-color: #1e293b; border: 1px solid #334155; border-radius: 10px; padding: 16px 20px; max-width: 520px;">
        <h6 style="margin: 0 0 12px 0; color: #f8fafc; font-weight: bold; font-size: 14px; text-transform: uppercase; letter-spacing: 0.5px;">
            + Agregar Nueva Mesa
        </h6>

        <div style="display: flex; gap: 12px; align-items: flex-end; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 130px;">
                <label style="display: block; font-size: 12px; color: #94a3b8; margin-bottom: 4px;">Número de Mesa</label>
                <asp:TextBox ID="numero" runat="server" placeholder="Ej: 6"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 14px; box-sizing: border-box;" />
            </div>

            <div style="flex: 1; min-width: 130px;">
                <label style="display: block; font-size: 12px; color: #94a3b8; margin-bottom: 4px;">Capacidad (pers.)</label>
                <asp:TextBox ID="capacidad" runat="server" placeholder="Ej: 4"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 14px; box-sizing: border-box;" />
            </div>

            <div>
                <asp:Button ID="btnAgregarMesa" runat="server" Text="Agregar Mesa" OnClick="btnAgregarMesa_Click"
                    Style="padding: 9px 18px; border-radius: 6px; border: none; background-color: #2563eb; color: white; font-size: 13px; font-weight: bold; cursor: pointer; height: 37px;" />
            </div>
        </div>

        <%-- Mensajito directo dentro de la tarjeta --%>
        <asp:Label ID="lblErrorAgregar" runat="server"
            Style="display: block; margin-top: 10px; font-size: 13px; font-weight: 600;" />
    </div>

    <!-- MODAL FLOTANTE DE ASIGNACIÓN -->
    <asp:Panel ID="pnlAsignacion" runat="server" Visible="false"
        Style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.7); display: flex; justify-content: center; align-items: center; z-index: 9999;">
        
        <div style="background-color: #1e293b; border: 1px solid #475569; border-radius: 12px; padding: 24px; width: 100%; max-width: 360px; box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.5); color: white;">
            
            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #334155; padding-bottom: 10px; margin-bottom: 16px;">
                <h5 style="margin: 0; font-weight: bold; font-size: 18px;">Asignar Mesa</h5>
                <asp:Button ID="btnCerrarModal" runat="server" Text="✕" OnClick="btnCerrarModal_Click"
                    Style="background: none; border: none; color: #94a3b8; font-size: 18px; cursor: pointer; padding: 0 4px;" />
            </div>

            <asp:HiddenField ID="hfMesaId" runat="server" />

            <div style="margin-bottom: 14px; font-size: 14px; color: #38bdf8; font-weight: 600;">
                <asp:Label ID="lblMesaElegida" runat="server" />
            </div>

            <div style="margin-bottom: 18px;">
                <label style="display: block; font-size: 13px; color: #cbd5e1; margin-bottom: 6px;">Seleccionar mesero:</label>
                <asp:DropDownList ID="ddlMeseros" runat="server"
                    Style="width: 100%; padding: 8px 10px; border-radius: 6px; border: 1px solid #475569; background-color: #0f172a; color: white; font-size: 14px;">
                </asp:DropDownList>
            </div>

            <div style="display: flex; gap: 10px;">
                <asp:Button ID="btnCancelarModal" runat="server" Text="Cancelar" OnClick="btnCerrarModal_Click"
                    Style="flex: 1; padding: 8px; border-radius: 6px; border: 1px solid #475569; background-color: transparent; color: #cbd5e1; font-size: 13px; font-weight: 600; cursor: pointer;" />
                
                <asp:Button ID="btnGuardar" runat="server" Text="Confirmar" OnClick="btnGuardar_Click"
                    Style="flex: 1; padding: 8px; border-radius: 6px; border: none; background-color: #16a34a; color: white; font-size: 13px; font-weight: 600; cursor: pointer;" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>



<%-- 
    <div class="vstack gap-4 mb-5 mx-auto" style="max-width: 600px;">
    <div class="vstack gap-4 mb-5 mx-auto" style="max-width: 600px;">
        
        <!-- ================= FILA 1 (Mesas 1 a 4) ================= -->
        <div class="row text-center">
            <!-- Mesa 1 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-success hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa1" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-egg-fried text-success fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 1</h6>
                    <span class="badge bg-subtle-success fg-success mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Libre</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa1" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-2">Mesa 1 - Estado</h6>
                    <p class="text-muted text-sm mb-3">La mesa se encuentra libre en este momento.</p>
                    <button class="btn btn-sm btn-primary w-100 fw-bold" type="button" data-bs-toggle="drawer" data-bs-target="#drawerPedido"><i class="bi bi-person-plus me-1"></i> Asignar Mesa</button>
                </div>
            </div>
            <!-- Mesa 2 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-danger hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa2" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-people-fill text-danger fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 2</h6>
                    <span class="badge bg-subtle-danger fg-danger mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Ocupada</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa2" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-1">Mesa 2 - Activa</h6>
                    <span class="text-sm text-secondary d-block mb-3">Mesero: Juan Pérez</span>
                    <button class="btn btn-sm btn-outline-danger w-100 fw-bold" type="button"><i class="bi bi-receipt me-1"></i> Cerrar / Cobrar</button>
                </div>
            </div>
            <!-- Mesa 3 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-success hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa3" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-egg-fried text-success fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 3</h6>
                    <span class="badge bg-subtle-success fg-success mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Libre</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa3" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-2">Mesa 3 - Estado</h6>
                    <p class="text-muted text-sm mb-3">La mesa se encuentra libre.</p>
                    <button class="btn btn-sm btn-primary w-100 fw-bold" type="button" data-bs-toggle="drawer" data-bs-target="#drawerPedido"><i class="bi bi-person-plus me-1"></i> Asignar Mesa</button>
                </div>
            </div>
            <!-- Mesa 4 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-danger hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa4" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-people-fill text-danger fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 4</h6>
                    <span class="badge bg-subtle-danger fg-danger mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Ocupada</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa4" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-1">Mesa 4 - Activa</h6>
                    <span class="text-sm text-secondary d-block mb-3">Mesero: María Gómez</span>
                    <button class="btn btn-sm btn-outline-danger w-100 fw-bold" type="button"><i class="bi bi-receipt me-1"></i> Cerrar / Cobrar</button>
                </div>
            </div>
        </div>

        <!-- ================= FILA 2 (Mesas 5 a 8) ================= -->
        <div class="row text-center">
            <!-- Mesa 5 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-success hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa5" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-egg-fried text-success fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 5</h6>
                    <span class="badge bg-subtle-success fg-success mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Libre</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa5" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-2">Mesa 5 - Estado</h6>
                    <p class="text-muted text-sm mb-3">La mesa se encuentra libre.</p>
                    <button class="btn btn-sm btn-primary w-100 fw-bold" type="button" data-bs-toggle="drawer" data-bs-target="#drawerPedido"><i class="bi bi-person-plus me-1"></i> Asignar Mesa</button>
                </div>
            </div>
            <!-- Mesa 6 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-success hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa6" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-egg-fried text-success fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 6</h6>
                    <span class="badge bg-subtle-success fg-success mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Libre</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa6" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-2">Mesa 6 - Estado</h6>
                    <p class="text-muted text-sm mb-3">La mesa se encuentra libre.</p>
                    <button class="btn btn-sm btn-primary w-100 fw-bold" type="button" data-bs-toggle="drawer" data-bs-target="#drawerPedido"><i class="bi bi-person-plus me-1"></i> Asignar Mesa</button>
                </div>
            </div>
            <!-- Mesa 7 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-danger hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa7" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-people-fill text-danger fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 7</h6>
                    <span class="badge bg-subtle-danger fg-danger mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Ocupada</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa7" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-1">Mesa 7 - Activa</h6>
                    <span class="text-sm text-secondary d-block mb-3">Mesero: Carlos Gómez</span>
                    <button class="btn btn-sm btn-outline-danger w-100 fw-bold" type="button"><i class="bi bi-receipt me-1"></i> Cerrar / Cobrar</button>
                </div>
            </div>
            <!-- Mesa 8 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-success hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa8" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-egg-fried text-success fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 8</h6>
                    <span class="badge bg-subtle-success fg-success mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Libre</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa8" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-2">Mesa 8 - Estado</h6>
                    <p class="text-muted text-sm mb-3">La mesa se encuentra libre.</p>
                    <button class="btn btn-sm btn-primary w-100 fw-bold" type="button" data-bs-toggle="drawer" data-bs-target="#drawerPedido"><i class="bi bi-person-plus me-1"></i> Asignar Mesa</button>
                </div>
            </div>
        </div>

         <!-- ================= FILA 3 (Mesas 9 a 12) ================= -->
        <div class="row text-center">
            
            <!-- Mesa 9 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-success hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa9" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-egg-fried text-success fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 9</h6>
                    <span class="badge bg-subtle-success fg-success mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Libre</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa9" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-2">Mesa 9 - Estado</h6>
                    <p class="text-muted text-sm mb-3">La mesa se encuentra libre.</p>
                    <button class="btn btn-sm btn-primary w-100 fw-bold" type="button" data-bs-toggle="drawer" data-bs-target="#drawerPedido">
                        <i class="bi bi-person-plus me-1"></i> Asignar Mesa
                    </button>
                </div>
            </div>

            <!-- Mesa 10 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-danger hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa10" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-people-fill text-danger fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 10</h6>
                    <span class="badge bg-subtle-danger fg-danger mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Ocupada</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa10" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-1">Mesa 10 - Activa</h6>
                    <span class="text-sm text-secondary d-block mb-3">Mesero: Juan Pérez</span>
                    <button class="btn btn-sm btn-outline-danger w-100 fw-bold" type="button">
                        <i class="bi bi-receipt me-1"></i> Cerrar / Cobrar
                    </button>
                </div>
            </div>

            <!-- Mesa 11 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-success hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa11" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-egg-fried text-success fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 11</h6>
                    <span class="badge bg-subtle-success fg-success mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Libre</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa11" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-2">Mesa 11 - Estado</h6>
                    <p class="text-muted text-sm mb-3">La mesa se encuentra libre.</p>
                    <button class="btn btn-sm btn-primary w-100 fw-bold" type="button" data-bs-toggle="drawer" data-bs-target="#drawerPedido">
                        <i class="bi bi-person-plus me-1"></i> Asignar Mesa
                    </button>
                </div>
            </div>

            <!-- Mesa 12 -->
            <div class="col-3 d-flex justify-content-center position-relative">
                <div class="card shadow-sm border-danger hover-lift d-flex flex-column justify-content-center align-items-center" data-bs-toggle="menu" data-bs-target="#popoverMesa12" style="cursor: pointer; width: 110px; height: 110px; border-radius: 12px;">
                    <i class="bi bi-people-fill text-danger fs-3 mb-1"></i>
                    <h6 class="fw-bold mb-0 text-dark small">Mesa 12</h6>
                    <span class="badge bg-subtle-danger fg-danger mt-1" style="font-size: 0.65rem; padding: 2px 6px;">Ocupada</span>
                </div>
                <div class="menu p-3 bg-white border shadow-lg rounded-7" id="popoverMesa12" data-bs-placement="bottom">
                    <h6 class="fw-bold mb-1">Mesa 12 - Activa</h6>
                    <span class="text-sm text-secondary d-block mb-3">Mesero: Lucas Díaz</span>
                    <button class="btn btn-sm btn-outline-danger w-100 fw-bold" type="button">
                        <i class="bi bi-receipt me-1"></i> Cerrar / Cobrar
                    </button>
                </div>
            </div>

        </div>

    <!-- PANEL LATERAL DERECHO (Formulario de Pedidos) -->
    <dialog class="drawer drawer-end bg-white text-dark shadow-lg" id="drawerPedido" style="--bs-drawer-width: 380px;">
        <div class="drawer-header border-bottom py-3 bg-primary text-white">
            <h5 class="drawer-title fw-bold text-white mb-0">
                <i class="bi bi-cart-plus text-warning me-2"></i>Tomar Pedido Inicial
            </h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="drawer" aria-label="Close"></button>
        </div>
        <div class="drawer-body p-4">
            <div class="vstack gap-4">
                <div class="form-field">
                    <label class="form-label fw-semibold text-secondary">Cantidad de Personas</label>
                    <input type="number" class="form-control" placeholder="Ej: 4" min="1" />
                </div>
                <div class="form-field">
                    <label class="form-label fw-semibold text-secondary">Asignar Mesero</label>
                    <select class="form-control">
                        <option>Juan Pérez</option>
                        <option>María Rodríguez</option>
                        <option>Carlos Gómez</option>
                    </select>
                </div>
                <div class="form-field">
                    <label class="form-label fw-semibold text-secondary">Pedido / Notas iniciales</label>
                    <textarea class="form-control" rows="3" placeholder="Ej: 2 empanadas de carne..."></textarea>
                </div>
                <div class="pt-3">
                    <button type="button" class="btn btn-success w-100 fw-bold py-2 shadow-sm">
                        <i class="bi bi-check-circle me-1"></i> Confirmar Apertura
                    </button>
                </div>
            </div>
        </div>
    </dialog>--%>

