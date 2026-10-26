using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.AccesoDatos;

namespace TPC_RestoBar_Equipo_X
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    AccesoADatos acceso = new AccesoADatos();

                    gvMesas.DataSource = acceso.ObtenerMesas();
                    gvMesas.DataBind();

                    lblMensaje.Text = "CONEXION EXITOSA.";
                }
                catch (Exception ex)
                {
                    lblMensaje.Text = "ERROR AL CONECTAR: " + ex.Message;
                }
            }
        }

    }
}