
using System;
using System.Web.UI.WebControls;

namespace TPC_RestoBar_Equipo_X
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
