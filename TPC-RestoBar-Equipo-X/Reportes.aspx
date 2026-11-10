<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="TPC_RestoBar_Equipo_X.Reportes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid">
        <!-- Encabezado -->
        <div class="mb-4">
            <h2 class="fw-bold text-dark mb-1">Panel de Reportes y Estadísticas</h2>
            <p class="text-muted">Monitoreá las ventas, consumiciones e insumos del negocio.</p>
        </div>

        <!-- Tarjetas de Indicadores Rápidos -->
        <div class="row g-3 mb-5">
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card bg-primary text-white border-0 shadow-sm">
                    <div class="card-body p-3">
                        <small class="text-white-50 text-uppercase fw-semibold">Recaudación del Día</small>
                        <h3 class="fw-bold my-1">$0.00</h3>
                        <span class="small text-white-50"><i class="bi bi-arrow-up me-1"></i>Pedidos de hoy</span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card bg-success text-white border-0 shadow-sm">
                    <div class="card-body p-3">
                        <small class="text-white-50 text-uppercase fw-semibold">Pedidos Totales</small>
                        <h3 class="fw-bold my-1">0</h3>
                        <span class="small text-white-50"><i class="bi bi-check-circle me-1"></i>Finalizados con éxito</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sección de Tablas Estadísticas -->
        <div class="card shadow-sm border-0 mb-4">
            <div class="card-header bg-white py-3 border-bottom">
                <h5 class="fw-bold text-dark m-0"><i class="bi bi-graph-up text-primary me-2"></i>Ranking de Productos Más Vendidos</h5>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4">Producto</th>
                                <th>Tipo</th>
                                <th>Cantidad Vendida</th>
                                <th class="pe-4">Total Recaudado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="ps-4 fw-semibold">Milanesa con Papas Fritas</td>
                                <td>Comida</td>
                                <td>42</td>
                                <td class="pe-4 fw-bold text-success">$0.00</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
