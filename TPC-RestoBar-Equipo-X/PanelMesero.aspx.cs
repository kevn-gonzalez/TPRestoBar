using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.DatosNegocio;

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
            }
        }

        protected void ddlMeseros_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idMesero;

            lblMensaje.Text = "";
            lblSinPedidos.Visible = false;

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
            catch (Exception)
            {
                lblMensaje.Text = "Error al cargar los pedidos.";
            }
        }
    }
}