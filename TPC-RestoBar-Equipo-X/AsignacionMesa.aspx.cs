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
                ddlMeseros.DataValueField = "Id";
                ddlMeseros.DataBind();

                ddlMeseros.Items.Insert(0, new ListItem("Seleccione un mesero", ""));
            }
        }

        protected void btnSeleccionar_Command(object sender, CommandEventArgs e)
        {
            int idMesa = int.Parse(e.CommandArgument.ToString());

            if (e.CommandName == "Asignar")
            {
                hfMesaId.Value = idMesa.ToString();
                lblMesaElegida.Text = "Mesa seleccionada (ID: " + idMesa + ")";
                pnlAsignacion.Visible = true;
            }
            else if (e.CommandName == "Desasignar")
            {
                AsignacionMesaNegocio negocio = new AsignacionMesaNegocio();
                MesaNegocio mesaNegocio = new MesaNegocio();

                // Llamamos al método para liberar la mesa y cancelar su pedido abierto
                bool liberada = negocio.desasignarMesa(idMesa);

                if (liberada)
                {
                    lblMensaje.Text = "Mesa desasignada y liberada correctamente.";
                    pnlAsignacion.Visible = false;
                }
                else
                {
                    lblMensaje.Text = "No se pudo desasignar la mesa (verificá que no tenga consumiciones cargadas).";
                }

                // Refrescamos el mapa de mesas
                rptMesas.DataSource = mesaNegocio.listar();
                rptMesas.DataBind();
            }
        }

        protected void btnCerrarModal_Click(object sender, EventArgs e)
        {
            pnlAsignacion.Visible = false;
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
                catch (Exception ex)
                {
                    lblMensaje.Text = "Ocurrió un error al guardar la asignación.";
                    pnlAsignacion.Visible = true;
                }
            }
        }

        protected void btnAgregarMesa_Click(object sender, EventArgs e)
        {
            lblErrorAgregar.Text = string.Empty;

            // 1. Validar campos vacíos
            if (string.IsNullOrWhiteSpace(numero.Text) || string.IsNullOrWhiteSpace(capacidad.Text))
            {
                lblErrorAgregar.Text = "Completá el número de mesa y la capacidad antes de agregar.";
                lblErrorAgregar.ForeColor = System.Drawing.Color.Salmon;
                return;
            }

            int numeroMesa;
            int numeroCapacidad;

            // 2. Validar que sean números válidos mayores a 0
            if (!int.TryParse(numero.Text.Trim(), out numeroMesa) || numeroMesa <= 0)
            {
                lblErrorAgregar.Text = "Ingresá un número de mesa válido (mayor a 0).";
                lblErrorAgregar.ForeColor = System.Drawing.Color.Salmon;
                return;
            }

            if (!int.TryParse(capacidad.Text.Trim(), out numeroCapacidad) || numeroCapacidad <= 0)
            {
                lblErrorAgregar.Text = "Ingresá una capacidad válida (mayor a 0).";
                lblErrorAgregar.ForeColor = System.Drawing.Color.Salmon;
                return;
            }

            try
            {
                MesaNegocio negocio = new MesaNegocio();

                // 3. Validar si ya existe una mesa con ese número
                List<Mesa> mesasExistentes = negocio.listar();
                if (mesasExistentes.Exists(m => m.NumeroMesa == numeroMesa))
                {
                    lblErrorAgregar.Text = $"Ya existe la Mesa {numeroMesa}. Ingresá otro número.";
                    lblErrorAgregar.ForeColor = System.Drawing.Color.Salmon;
                    return;
                }

                // 4. Guardar la mesa nueva
                Mesa nuevo = new Mesa();
                nuevo.NumeroMesa = numeroMesa;
                nuevo.Capacidad = numeroCapacidad;

                negocio.agregar(nuevo);

                // 5. Limpiar campos, actualizar la grilla y confirmar
                numero.Text = string.Empty;
                capacidad.Text = string.Empty;

                rptMesas.DataSource = negocio.listar();
                rptMesas.DataBind();

                lblErrorAgregar.Text = $"Mesa {numeroMesa} agregada correctamente.";
                lblErrorAgregar.ForeColor = System.Drawing.Color.LightGreen;
            }
            catch (Exception)
            {
                lblErrorAgregar.Text = "Ocurrió un error al intentar guardar la mesa.";
                lblErrorAgregar.ForeColor = System.Drawing.Color.Salmon;
            }
        }
    }
}