
using System;
using System.Web.UI.WebControls;

namespace TPC_RestoBar_Equipo_X
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Si no está en Login y no hay sesión activa, lo manda al Login
            if (!(Page is Login))
            {
                if (!Seguridad.EstaLogueado())
                {
                    Response.Redirect("~/Login.aspx", false);
                    return;
                }

                // 2. Ocultar opciones según el rol (Gerente/Admin vs Mesero)
                bool esAdmin = Seguridad.EsAdmin();

                btnNavInsumos.Visible = esAdmin;
                btnNavAsignacion.Visible = esAdmin;
                btnNavReportes.Visible = esAdmin;
                btnNavUsuarios.Visible = esAdmin;
                btnNavLogin.Visible = false; // Ya está logueado
                btnSalir.Visible = true;

                // 3. Si un Mesero intenta entrar por URL directa a una pantalla de Gerente, lo bloquea
                if (!esAdmin && !(Page is PanelMesero))
                {
                    Response.Redirect("~/PanelMesero.aspx", false);
                    return;
                }
            }
            else
            {
                // En la pantalla de Login ocultamos el botón Salir
                btnSalir.Visible = false;
            }
        }

        protected void btnSalir_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Login.aspx");
        }

        protected void btnNav_Click(object sender, EventArgs e)
        {
            LinkButton botonClickeado = (LinkButton)sender;

            string paginaDestino = botonClickeado.CommandArgument;

            Response.Redirect(paginaDestino);
        }
    }
}
