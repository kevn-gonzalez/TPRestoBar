using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.DatosNegocio;

namespace TPC_RestoBar_Equipo_X
{
    public partial class Insumos : System.Web.UI.Page
    {
        private InsumosNegocio negocio = new InsumosNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarGrilla();
            }
        }

        private void cargarGrilla()
        {
            try
            {
                dgvInsumos.DataSource = negocio.listar();
                dgvInsumos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("ErrorProgramador", ex.ToString());
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                insumos target = new insumos();
                target.Nombre = txtNombre.Text;
                target.Tipo = ddlCategoria.SelectedValue;
                target.StockActual = int.Parse(txtStock.Text);

                decimal precio = 0;
                if (decimal.TryParse(txtPrecio.Text, out precio))
                {
                    target.PrecioVenta = precio;
                }
                else
                {
                    target.PrecioVenta = 0;
                }
                target.Activo = true;

                if (ViewState["IdInsumoEditar"] != null)
                {
                    target.IdInsumo = (int)ViewState["IdInsumoEditar"];
                    negocio.modificar(target);
                }
                else
                {
                    negocio.guardar(target);
                }
               
                limpiarFormulario();
                cargarGrilla();
                Response.Redirect("Insumos.aspx");
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
            }
        }


        private void limpiarFormulario()
        {
            txtNombre.Text = "";
            ddlCategoria.SelectedIndex = 0;
            txtStock.Text = "";
            txtPrecio.Text = "";

            ViewState["IdInsumoEditar"] = null;
            btnGuardar.Text = "Guardar Insumo";
        }


        protected void dgvInsumos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                try
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    int idInsumo = Convert.ToInt32(dgvInsumos.DataKeys[index].Value);
                    negocio.eliminarLogico(idInsumo);
                    cargarGrilla();
                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex.ToString());
                }
            }

            if (e.CommandName == "Editar")
            {
                try
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    int idInsumo = Convert.ToInt32(dgvInsumos.DataKeys[index].Value);

                    // 1. Buscamos el insumo completo en la base de datos
                    insumos seleccionado = negocio.buscarPorId(idInsumo);

                    if (seleccionado != null)
                    {
                        // 2. Cargamos los TextBox de la pantalla con la info actual
                        txtNombre.Text = seleccionado.Nombre;
                        ddlCategoria.SelectedValue = seleccionado.Tipo;
                        txtStock.Text = seleccionado.StockActual.ToString();
                        txtPrecio.Text = seleccionado.PrecioVenta.ToString("0.00");

                        // 3. Guardamos el ID en el ViewState para no perderlo al hacer clic en guardar
                        ViewState["IdInsumoEditar"] = seleccionado.IdInsumo;

                        // 4. Cambiamos el texto del botón del panel para que el usuario sepa que está editando
                        btnGuardar.Text = "Modificar Insumo";

                        string script = "setTimeout(function() { const drawer = document.getElementById('drawerFormulario'); if(drawer) drawer.showModal(); }, 100);";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", script, true);
                    }
                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex.ToString());
                }
            }
        }


    }
}
