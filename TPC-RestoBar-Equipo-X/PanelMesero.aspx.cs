using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.AccesoDatos;
using TPC_RestoBar_Equipo_X.DatosNegocio;
using TPC_RestoBar_Equipo_X.Dominio;

namespace TPC_RestoBar_Equipo_X
{
    public partial class PanelMesero : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AsignacionMesaNegocio negocio = new AsignacionMesaNegocio();

                ddlMeseros.DataSource = negocio.listarMeseros();
                ddlMeseros.DataTextField = "Nombre";
                ddlMeseros.DataValueField = "ID";
                ddlMeseros.DataBind();

                ddlMeseros.Items.Insert(0,
                    new ListItem("Seleccioná un mesero", ""));

                cargarGrillaInsumos();
            }
        }

        protected void ddlMeseros_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idMesero;

            lblMensaje.Text = "";
            lblSinPedidos.Visible = false;
            pnlPedido.Visible = false;

            if (!int.TryParse(ddlMeseros.SelectedValue, out idMesero))
            {
                rptPedidos.DataSource = null;
                rptPedidos.DataBind();
                return;
            }

            try
            {
                PanelMeseroNegocio negocio = new PanelMeseroNegocio();

                var pedidos = negocio.listarPedidos(idMesero);

                rptPedidos.DataSource = pedidos;
                rptPedidos.DataBind();

                lblSinPedidos.Visible = pedidos.Count == 0;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar los pedidos.";
            }
        }

        private void cargarGrillaInsumos()
        {
            try
            {
                InsumosNegocio insumoNegocio = new InsumosNegocio();
                List<Insumo> listaInsumos = new List<Insumo>();
                listaInsumos = insumoNegocio.listar();
                dgvProductosDisponibles.DataSource = listaInsumos;
                dgvProductosDisponibles.DataBind();
            }
            catch (Exception ex)
            {
                throw;
            }
            
        }
        protected void btnGestionar_Command(object sender, CommandEventArgs e)
        {
            int idPedido;
            int idMesero;

            if (!int.TryParse(e.CommandArgument.ToString(), out idPedido) ||
                !int.TryParse(ddlMeseros.SelectedValue, out idMesero))
            {
                lblMensaje.Text = "Seleccioná un pedido válido.";
                return;
            }

            try
            {

                InsumosNegocio insumosNegocio = new InsumosNegocio();
                PanelMeseroNegocio negocio = new PanelMeseroNegocio();

                bool pertenece = negocio.listarPedidos(idMesero)
                    .Exists(p => p.Id == idPedido);

                if (!pertenece)
                {
                    lblMensaje.Text = "El pedido no corresponde al mesero seleccionado.";
                    pnlPedido.Visible = false;
                    return;
                }
                cargarGrillaInsumos();
                hfPedidoId.Value = idPedido.ToString();

                lblPedidoElegido.Text = "Pedido #" + idPedido;
                lblTituloPedidosMesa.Text = "Pedidos de la mesa: " + negocio.obtenerNumeroMesa(idPedido);
                cargarGrillaConsumiciones();

                lblTotalPedido.Text = "Total: $" +
                negocio.obtenerTotal(idPedido).ToString("N2");

                pnlPedido.Visible = true;
                IrAlDetalle();
                lblMensaje.Text = "";
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar las consumiciones.";
            }
        }

        private void cargarGrillaConsumiciones()
        {
            int idPedido;
            if (int.TryParse(hfPedidoId.Value, out idPedido))
            {
                PanelMeseroNegocio negocio = new PanelMeseroNegocio();
                gvConsumiciones.DataSource = negocio.listarConsumiciones(idPedido);
                gvConsumiciones.DataBind();
            }
        }

        protected void btnElegirConsumicion_Command(object sender, CommandEventArgs e)
        {
            hfInsumoId.Value = e.CommandArgument.ToString();
            

            lblConsumicionElegida.Text = "Producto: " + e.CommandName;

            txtCantidad.Text = "1";

            pnlAgregar.Visible = true;
            pnlPedido.Visible = true;
            IrAlDetalle();
        }

        private void IrAlDetalle()
        {
            ClientScript.RegisterStartupScript(
                GetType(),
                "irDetalle",
                "window.addEventListener('load', function() {" +
                "document.getElementById('zonaGestion2').scrollIntoView(" +
                "{ behavior: 'smooth', block: 'start' });" +
                "});",
                true
            );
        }

        protected void btnAgregarConsumicion_Click(object sender, EventArgs e)
        {
            try
            {
                int cantidadPedida = int.Parse(txtCantidad.Text);
                if (cantidadPedida <= 0) return;

                InsumosNegocio negocioInsumo = new InsumosNegocio();
                int idInsumo = int.Parse(hfInsumoId.Value);
                Insumo insumo = negocioInsumo.buscarPorId(idInsumo);

                if (insumo == null || insumo.StockActual < cantidadPedida)
                {
                    lblMensaje.Text = "No hay stock suficiente para agregar esa cantidad.";
                    return;
                }

                Consumicion nuevo = new Consumicion();
                nuevo.InsumoId = idInsumo;
                nuevo.PedidoId = int.Parse(hfPedidoId.Value);
                nuevo.Nombre = insumo.Nombre;
                nuevo.Tipo = insumo.Tipo;
                nuevo.Cantidad = cantidadPedida;
                nuevo.Precio = insumo.PrecioVenta;

                PanelMeseroNegocio negocio = new PanelMeseroNegocio();
                negocio.guardar(nuevo);

                insumo.StockActual -= cantidadPedida;
                negocioInsumo.modificar(insumo);

                cargarGrillaConsumiciones();
                cargarGrillaInsumos();
                lblTotalPedido.Text = "Total: $" +
                negocio.obtenerTotal(nuevo.PedidoId).ToString("N2");
                pnlAgregar.Visible = false;
            }
            catch (Exception)
            {
                lblMensaje.Text = "Error al agregar la consumición.";
            }
        }

        protected void btnCerrarPedido_Click(object sender, EventArgs e)
        {
            int idPedido;
            int idMesero;

            if (!int.TryParse(hfPedidoId.Value, out idPedido) ||
                !int.TryParse(ddlMeseros.SelectedValue, out idMesero))
            {
                lblMensaje.Text = "Seleccioná un pedido válido.";
                return;
            }

            try
            {
                PanelMeseroNegocio negocio = new PanelMeseroNegocio();

                bool cerrado = negocio.cerrarPedido(idPedido, idMesero);

                if (cerrado)
                {
                    lblMensaje.Text = "Pedido cobrado y mesa liberada.";
                    lblMensaje.CssClass = "d-block mb-3 text-success";

                    pnlPedido.Visible = false;
                    pnlAgregar.Visible = false;

                    rptPedidos.DataSource = negocio.listarPedidos(idMesero);
                    rptPedidos.DataBind();
                }
                else
                {
                    lblMensaje.Text =
                        "No se pudo cerrar el pedido. Verificá que siga abierto y tenga consumiciones.";

                    pnlPedido.Visible = true;
                }
            }
            catch (Exception)
            {
                lblMensaje.Text = "Ocurrió un error al cerrar el pedido.";
                pnlPedido.Visible = true;
            }
        }
        
    }
}