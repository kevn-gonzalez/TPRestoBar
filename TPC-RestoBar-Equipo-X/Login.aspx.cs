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

            try
            {
                datos.setearConsulta("SELECT ID, Username, Nombre, TipoPerfil FROM Usuarios WHERE Username = @usuario AND Password = @password");
                datos.setearParametro("@usuario", usuario);
                datos.setearParametro("@password", password);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Usuario logueado = new Usuario();
                    logueado.ID = (int)datos.Lector["ID"];
                    logueado.Username = (string)datos.Lector["Username"];
                    logueado.Nombre = (string)datos.Lector["Nombre"];

                    string perfil = datos.Lector["TipoPerfil"].ToString();
                    logueado.TipoUsuario = (perfil.Equals("Admin", StringComparison.OrdinalIgnoreCase) ||
                                            perfil.Equals("Gerente", StringComparison.OrdinalIgnoreCase))
                        ? TipoUsuario.ADMIN
                        : TipoUsuario.USUARIO;

                    Session["usuario"] = logueado;

                    if (logueado.TipoUsuario == TipoUsuario.ADMIN)
                        Response.Redirect("~/AsignacionMesa.aspx", false);
                    else
                        Response.Redirect("~/PanelMesero.aspx", false);
                }
                else
                {
                    lblMensaje.Text = "Usuario o contraseña incorrectos.";
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al iniciar sesión: " + ex.Message;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
