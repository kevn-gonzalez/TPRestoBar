using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.DatosNegocio;

namespace TPC_RestoBar_Equipo_X
{
    public partial class Reportes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    ReportesNegocio negocio = new ReportesNegocio();

                    lblRecaudacion.Text = "$ " +
                        negocio.obtenerRecaudacionHoy().ToString("N2");

                    lblPedidos.Text =
                        negocio.obtenerPedidosPagadosHoy().ToString();

                    gvProductos.DataSource =
                        negocio.listarProductosVendidosHoy();

                    gvProductos.DataBind();
                }
                catch (Exception)
                {
                    lblMensaje.Text = "Error al cargar los reportes.";
                }
            }
        }
    }
}                               