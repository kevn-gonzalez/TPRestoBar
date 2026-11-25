using System;
using System.Collections.Generic;
using System.Linq;
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

                ddlMeseros.Items.Insert(0, new ListItem("Seleccioná un mesero", ""));
                // Para verificar si el usuario logueado es un mesero y limitar la vista a sus pedidos
                if (Seguridad.EstaLogueado() && !Seguridad.EsAdmin())
                {
                    Usuario logueado = (Usuario)Session["usuario"];
                    ddlMeseros.SelectedValue = logueado.ID.ToString();
                    // No puede ver mesas de otros meseros
                    ddlMeseros.Enabled = false; 
                    cargarPedidosDelMesero();
                }
            }
        }

        protected void ddlMeseros_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfPedidoId.Value = "";
            hfInsumoId.Value = "";
            hfInsumoNombre.Value = "";
            lblMensaje.Text = "";
            lblSinPedidos.Visible = false;

            cargarPedidosDelMesero();
        }

        private void cargarPedidosDelMesero()
        {
            int idMesero;
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

                lblSinPedidos.Visible = (pedidos.Count == 0);
            }
            catch (Exception)
            {
                lblMensaje.Text = "Error al cargar los pedidos.";
                lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
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
                lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
                return;
            }

            try
            {
                PanelMeseroNegocio negocio = new PanelMeseroNegocio();
                bool pertenece = negocio.listarPedidos(idMesero).Exists(p => p.Id == idPedido);

                if (!pertenece)
                {
                    lblMensaje.Text = "El pedido no corresponde al mesero seleccionado.";
                    lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
                    hfPedidoId.Value = "";
                    cargarPedidosDelMesero();
                    return;
                }

                // Efecto acordeón: si toca la misma mesa abierta, la cierra; si toca otra, la abre
                if (hfPedidoId.Value == idPedido.ToString())
                {
                    hfPedidoId.Value = "";
                }
                else
                {
                    hfPedidoId.Value = idPedido.ToString();
                }

                hfInsumoId.Value = "";
                hfInsumoNombre.Value = "";
                lblMensaje.Text = "";
                cargarPedidosDelMesero();
            }
            catch (Exception)
            {
                lblMensaje.Text = "Error al cargar las consumiciones.";
                lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
            }
        }

        protected void rptPedidos_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Pedido pedido = (Pedido)e.Item.DataItem;
                Panel pnlDetalleMesa = (Panel)e.Item.FindControl("pnlDetalleMesa");
                LinkButton btnGestionar = (LinkButton)e.Item.FindControl("btnGestionar");

                if (hfPedidoId.Value == pedido.Id.ToString())
                {
                    pnlDetalleMesa.Visible = true;
                    btnGestionar.Text = "Cerrar panel";
                    btnGestionar.CssClass = "btn btn-outline-secondary btn-sm fw-semibold";

                    // 1. Cargar productos disponibles en el DropDownList (precio > 0 y stock > 0)
                    InsumosNegocio negInsumos = new InsumosNegocio();
                    DropDownList ddlProductos = (DropDownList)e.Item.FindControl("ddlProductosItem");
                    var disponibles = negInsumos.listar()
                        .Where(x => x.PrecioVenta > 0 && x.StockActual > 0)
                        .Select(x => new
                        {
                            Id = x.Id,
                            Texto = $"{x.Nombre} (${x.PrecioVenta:N2} - Stock: {x.StockActual})"
                        }).ToList();

                    ddlProductos.DataSource = disponibles;
                    ddlProductos.DataTextField = "Texto";
                    ddlProductos.DataValueField = "Id";
                    ddlProductos.DataBind();

                    // 2. Cargar consumiciones de este pedido
                    PanelMeseroNegocio negPanel = new PanelMeseroNegocio();
                    GridView gvConsumiciones = (GridView)e.Item.FindControl("gvConsumicionesItem");
                    gvConsumiciones.DataSource = negPanel.listarConsumiciones(pedido.Id);
                    gvConsumiciones.DataBind();

                    // 3. Mostrar Total
                    Label lblTotal = (Label)e.Item.FindControl("lblTotalItem");
                    lblTotal.Text = "Total: $" + negPanel.obtenerTotal(pedido.Id).ToString("N2");
                }
            }
        }

        protected void btnAgregarItem_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                RepeaterItem item = (RepeaterItem)btn.NamingContainer;
                DropDownList ddlProductos = (DropDownList)item.FindControl("ddlProductosItem");
                TextBox txtCantidad = (TextBox)item.FindControl("txtCantidadItem");

                int idPedido = int.Parse(btn.CommandArgument);
                int idInsumo = int.Parse(ddlProductos.SelectedValue);
                int cantidadPedida = int.Parse(txtCantidad.Text);

                if (cantidadPedida <= 0) return;

                InsumosNegocio negocioInsumo = new InsumosNegocio();
                Insumo insumo = negocioInsumo.buscarPorId(idInsumo);

                if (insumo == null || insumo.StockActual < cantidadPedida)
                {
                    lblMensaje.Text = "No hay stock suficiente para agregar esa cantidad.";
                    lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
                    return;
                }

                Consumicion nuevo = new Consumicion();
                nuevo.InsumoId = idInsumo;
                nuevo.PedidoId = idPedido;
                nuevo.Nombre = insumo.Nombre;
                nuevo.Tipo = insumo.Tipo;
                nuevo.Cantidad = cantidadPedida;
                nuevo.Precio = insumo.PrecioVenta;

                PanelMeseroNegocio negocio = new PanelMeseroNegocio();
                negocio.guardar(nuevo);

                insumo.StockActual -= cantidadPedida;
                negocioInsumo.modificar(insumo);

                hfPedidoId.Value = idPedido.ToString();
                lblMensaje.Text = "";
                cargarPedidosDelMesero();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al agregar la consumición: " + ex.Message;
                lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
            }
        }



        // Se ejecuta al confirmar el cobro
        protected void btnCobrarMesa_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int idPedido;
            int idMesero;

            if (!int.TryParse(btn.CommandArgument, out idPedido) ||
                !int.TryParse(ddlMeseros.SelectedValue, out idMesero))
            {
                lblMensaje.Text = "Seleccioná un pedido válido.";
                lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
                return;
            }

            try
            {
                PanelMeseroNegocio negocio = new PanelMeseroNegocio();
                bool cerrado = negocio.cerrarPedido(idPedido, idMesero);

                if (cerrado)
                {
                    lblMensaje.Text = "Pedido #" + idPedido + " cobrado y mesa liberada.";
                    lblMensaje.CssClass = "d-block mb-3 text-success fw-bold";

                    hfPedidoId.Value = "";
                    cargarPedidosDelMesero();

                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "subirInicio",
                        "window.scrollTo({ top: 0, behavior: 'smooth' });",
                        true
                    );
                }
                else
                {
                    lblMensaje.Text = "No se pudo cerrar el pedido. Verificá que siga abierto y tenga consumiciones.";
                    lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Ocurrió un error al cerrar el pedido: " + ex.Message;
                lblMensaje.CssClass = "d-block mb-3 text-danger fw-bold";
            }
        }
    }
}

