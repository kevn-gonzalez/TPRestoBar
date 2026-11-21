using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
                cargarGrillaConsumiciones();

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
            PanelMeseroNegocio negocio = new PanelMeseroNegocio();
            gvConsumiciones.DataSource = negocio.listarConsumiciones();
            gvConsumiciones.DataBind();
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
                "document.getElementById('zonaGestion').scrollIntoView(" +
                "{ behavior: 'smooth', block: 'start' });" +
                "});",
                true
            );
        }

        protected void btnAgregarConsumicion_Click(object sender, EventArgs e)
        {
            try
            {
                Consumicion nuevo = new Consumicion();
                InsumosNegocio negocioInsumo = new InsumosNegocio();
                nuevo.InsumoId = int.Parse(hfInsumoId.Value);
                Insumo insumo = negocioInsumo.buscarPorId(nuevo.InsumoId);
                PanelMeseroNegocio negocio = new PanelMeseroNegocio();
                nuevo.PedidoId = int.Parse(hfPedidoId.Value);
                nuevo.Nombre = insumo.Nombre;
                nuevo.Tipo = insumo.Tipo;
                nuevo.Cantidad = int.Parse(txtCantidad.Text);
                nuevo.Precio = insumo.PrecioVenta;
                negocio.guardar(nuevo);

                insumo.StockActual -= insumo.StockActual;
                negocioInsumo.guardar(insumo);

                cargarGrillaConsumiciones();
                cargarGrillaInsumos();

            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}