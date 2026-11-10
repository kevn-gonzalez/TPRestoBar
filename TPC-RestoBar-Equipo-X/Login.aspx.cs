using System;
using System.Data;
using System.Data.SqlClient;
using TPC_RestoBar_Equipo_X.AccesoDatos;
using TPC_RestoBar_Equipo_X.Dominio;

namespace TPC_RestoBar_Equipo_X
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string password = txtPassword.Text;

            if (usuario == "" || password == "")
            {
                lblMensaje.Text = "Completá todos los campos.";
                return;
            }

            Insumos nuevo = null;
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("SELECT ID, Username, Nombre, TipoPerfil FROM Usuarios WHERE Username = @usuario AND Password = @password");

                datos.setearParametro("@usuario", usuario);
                datos.setearParametro("@password", password);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
