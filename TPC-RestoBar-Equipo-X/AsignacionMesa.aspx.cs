using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.DatosNegocio;
using TPC_RestoBar_Equipo_X.Dominio;

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
                AsignacionMesaNegocio asignacionMesaNegocio = new AsignacionMesaNegocio();
                MesaNegocio mesaNegocio = new MesaNegocio();

                rptMesas.DataSource = mesaNegocio.listar();
                rptMesas.DataBind();

                ddlMeseros.DataSource = asignacionMesaNegocio.listarMeseros();
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
                    MesaNegocio mesaNegocio = new MesaNegocio();

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

                    rptMesas.DataSource = mesaNegocio.listar();
                    rptMesas.DataBind();
                }
                catch (Exception)
                {
                    lblMensaje.Text = "Ocurrió un error al guardar la asignación.";
                    pnlAsignacion.Visible = true;
                }
            }
        }

        protected void btnAgregarMesa_Click(object sender, EventArgs e)
        {
            MesaNegocio negocio = new MesaNegocio();
            Mesa nuevo = new Mesa();
            int numeroMesa = int.Parse(numero.Text);
            int numeroCapacidad = int.Parse(capacidad.Text);
            nuevo.NumeroMesa = numeroMesa;
            nuevo.Capacidad = numeroCapacidad;
            negocio.agregar(nuevo);
            Response.Redirect("AsignacionMesa.aspx");

        }
    }
}