using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.AccesoDatos;

namespace TPC_RestoBar_Equipo_X
{
    public partial class PruebaBD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string cadenaConexion = "server=.\\SQLEXPRESS; database=RestoBar_P3_DB; integrated security=true; TrustServerCertificate=True;";

                SqlConnection conexion = new SqlConnection(cadenaConexion);
                SqlCommand comando = new SqlCommand("SELECT Id, Numero, Capacidad FROM Mesas", conexion);

                try
                {
                    conexion.Open();
                    SqlDataReader lector = comando.ExecuteReader();

                    gvMesas.DataSource = lector;
                    gvMesas.DataBind();

                    lblMensaje.Text = "<i class='bi bi-check-circle-fill me-2'></i>Conexión Exitosa con la Base de Datos";
                    lblMensaje.CssClass = "alert alert-success d-inline-block py-2 px-3 shadow-sm rounded fw-bold text-uppercase";
                }
                catch (Exception ex)
                {
                    
                    lblMensaje.Text = "<i class='bi bi-exclamation-triangle-fill me-2'></i>Error de conexión: " + ex.Message;
                    lblMensaje.CssClass = "alert alert-danger d-inline-block py-2 px-3 shadow-sm rounded fw-bold text-uppercase";
                }
                finally
                {
                    if (conexion.State == ConnectionState.Open)
                    {
                        conexion.Close();
                    }
                }
            }
        }
    }
}
