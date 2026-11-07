<%@ Page Title="Asignación de Mesas" Language="C#" MasterPageFile="~/Site1.master" AutoEventWireup="true" CodeBehind="AsignacionMesa.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.AsignacionMesa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Cabecera de la sección -->
    <div class="d-flex align-items-center mb-4 border-bottom pb-3">
        <i class="bi bi-calendar-check text-primary fs-3 me-2"></i>
        <div>
            <h2 class="mb-0 fw-bold text-dark">Mapa de Asignación de Mesas</h2>
            <small class="text-secondary">Hacé clic sobre una mesa para ver su estado o gestionar sus pedidos.</small>
        </div>
    </div>

    <!-- Referencias de Colores -->
    <div class="hstack gap-3 mb-4 bg-light p-3 rounded border border-light">
        <span class="fw-bold text-secondary me-2">Referencias:</span>
        <div class="d-flex align-items-center"><span class="badge bg-success rounded-circle p-2 me-2"></span> Disponible</div>
        <div class="d-flex align-items-center"><span class="badge bg-danger rounded-circle p-2 me-2"></span> Ocupada</div>
    </div>

<!-- MAPA DE MESAS  -->
   
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
    </dialog>

</asp:Content>