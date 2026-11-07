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

            AccesoADatos datos = new AccesoADatos();

            using (SqlConnection conexion = datos.ObtenerConexion())
            {
                string consulta = @"SELECT ID, Username, Nombre, Perfil
                                    FROM Usuarios
                                    WHERE Username = @usuario
                                    AND Password = @password";

                SqlCommand comando = new SqlCommand(consulta, conexion);

                comando.Parameters.Add("@usuario", SqlDbType.VarChar, 50).Value = usuario;
                comando.Parameters.Add("@password", SqlDbType.VarChar, 50).Value = password;

                conexion.Open();

                SqlDataReader lector = comando.ExecuteReader();

                if (lector.Read())
                {
                    Usuario usuarioLogueado = new Usuario();
                    usuarioLogueado.ID = Convert.ToInt32(lector["ID"]);
                    usuarioLogueado.Username = lector["Username"].ToString();
                    usuarioLogueado.Nombre = lector["Nombre"].ToString();

                    usuarioLogueado.TipoUsuario =
                        (Dominio.TipoUsuario)Convert.ToInt32(lector["Perfil"]);

                    Session["usuario"] = usuarioLogueado;

                    Response.Redirect("~/AsignacionMesa.aspx");
                }
                else
                {
                    lblMensaje.Text = "Usuario o contraseña incorrectos.";
                }
            }
        }
    }
}
