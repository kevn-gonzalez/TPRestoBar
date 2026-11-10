using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.DatosNegocio;

namespace TPC_RestoBar_Equipo_X
{
    public partial class AsignacionMesa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*  if (!Seguridad.EstaLogueado())

              {
                  Response.Redirect("~/Login.aspx");
                  return;
              }*/
            if (!IsPostBack)
            {
                AsignacionMesaNegocio negocio = new AsignacionMesaNegocio();

                rptMesas.DataSource = negocio.listar();
                rptMesas.DataBind();

                ddlMeseros.DataSource = negocio.listarMeseros();
                ddlMeseros.DataTextField = "Nombre";
                ddlMeseros.DataValueField = "ID";
                ddlMeseros.DataBind();

                ddlMeseros.Items.Insert(0, new ListItem("Seleccione un mesero", ""));
            }
        }

        protected void btnSeleccionar_Command(object sender, CommandEventArgs e)
        {
            hfMesaId.Value = e.CommandArgument.ToString();

            lblMesaElegida.Text = "Mesa " + e.CommandName;

            pnlAsignacion.Visible = true;
        }


        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            {
                int idMesa;
                int idMesero;

                if (!int.TryParse(hfMesaId.Value, out idMesa) ||
                    !int.TryParse(ddlMeseros.SelectedValue, out idMesero))
                {
                    lblMensaje.Text = "Seleccioná una mesa y un mesero.";
                    pnlAsignacion.Visible = true;
                    return;
                }

                try
                {
                    AsignacionMesaNegocio negocio = new AsignacionMesaNegocio();

                    bool resultado = negocio.asignarMesa(idMesa, idMesero);

                    if (resultado)
                    {
                        lblMensaje.Text = "Mesa asignada correctamente.";
                        pnlAsignacion.Visible = false;
                    }
                    else
                    {
                        lblMensaje.Text = "No se pudo asignar la mesa. Verificá que esté libre y el mesero sea válido.";
                        pnlAsignacion.Visible = false;
                    }

                    rptMesas.DataSource = negocio.listar();
                    rptMesas.DataBind();
                }
                catch (Exception)
                {
                    lblMensaje.Text = "Ocurrió un error al guardar la asignación.";
                    pnlAsignacion.Visible = true;
                }
            }
        }
    }
}