using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.DatosNegocio;

namespace TPC_RestoBar_Equipo_X
{
    public partial class Insumos : System.Web.UI.Page
    {
        private InsumosNegocio negocio = new InsumosNegocio();

        private string CategoriaActiva
        {
            get { return ViewState["CategoriaActiva"] != null ? ViewState["CategoriaActiva"].ToString() : "Comida"; }
            set { ViewState["CategoriaActiva"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CategoriaActiva = "Comida";
                actualizarEstilosTabs();
                cargarGrilla();
            }
        }

        protected void CambiarTab_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            CategoriaActiva = btn.CommandArgument;
            txtBuscarNombre.Text = string.Empty;
            actualizarEstilosTabs();
            cargarGrilla();
        }

        private void actualizarEstilosTabs()
        {
            string estiloActivo = "padding: 10px 22px; border-radius: 10px 10px 0 0; border: 1px solid #334155; border-bottom: 2px solid #1e293b; background-color: #1e293b; color: #38bdf8; font-weight: bold; font-size: 14px; cursor: pointer;";
            string estiloInactivo = "padding: 10px 22px; border-radius: 10px 10px 0 0; border: 1px solid transparent; border-bottom: none; background-color: #0f172a; color: #94a3b8; font-weight: 600; font-size: 14px; cursor: pointer;";

            btnTabComida.Attributes["style"] = (CategoriaActiva == "Comida") ? estiloActivo : estiloInactivo;
            btnTabBebida.Attributes["style"] = (CategoriaActiva == "Bebida") ? estiloActivo : estiloInactivo;
            btnTabBazar.Attributes["style"] = (CategoriaActiva == "Bazar") ? estiloActivo : estiloInactivo;

            ddlCategoria.SelectedValue = CategoriaActiva;
        }

        private void cargarGrilla()
        {
            try
            {
                List<Insumo> lista = negocio.listar();

                lista = lista.Where(x => x.Tipo != null &&
                                         x.Tipo.Equals(CategoriaActiva, StringComparison.OrdinalIgnoreCase))
                             .ToList();

                string busqueda = txtBuscarNombre.Text.Trim();
                if (!string.IsNullOrEmpty(busqueda))
                {
                    lista = lista.Where(x => x.Nombre != null &&
                                             x.Nombre.IndexOf(busqueda, StringComparison.OrdinalIgnoreCase) >= 0)
                                 .ToList();
                }

                dgvInsumos.DataSource = lista;
                dgvInsumos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("ErrorProgramador", ex.ToString());
            }
        }

        protected void txtBuscarNombre_TextChanged(object sender, EventArgs e)
        {
            cargarGrilla();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            txtBuscarNombre.Text = string.Empty;
            cargarGrilla();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                lblErrorDrawer.Visible = false;
                string nombreIngresado = txtNombre.Text.Trim();

                if (string.IsNullOrEmpty(nombreIngresado))
                {
                    lblErrorDrawer.Text = "⚠️ Por favor, ingresá el nombre del insumo.";
                    lblErrorDrawer.Visible = true;
                    abrirDrawer();
                    return;
                }

                int idEditar = ViewState["IdInsumoEditar"] != null ? (int)ViewState["IdInsumoEditar"] : 0;

                List<Insumo> existentes = negocio.listar();
                bool yaExiste = existentes.Any(x =>
                    x.Id != idEditar &&
                    x.Nombre != null &&
                    x.Nombre.Trim().Equals(nombreIngresado, StringComparison.OrdinalIgnoreCase));

                if (yaExiste)
                {
                    lblErrorDrawer.Text = $"⚠️ El producto \"{nombreIngresado}\" ya existe en la lista. Usá el botón '➕ Sumar' en su fila para agregar stock.";
                    lblErrorDrawer.Visible = true;
                    abrirDrawer();
                    return;
                }

                Insumo target = new Insumo();
                target.Nombre = nombreIngresado;
                target.Tipo = ddlCategoria.SelectedValue;

                int stock = 0;
                int.TryParse(txtStock.Text, out stock);
                target.StockActual = stock;

                decimal precio = 0;
                decimal.TryParse(txtPrecio.Text, out precio);
                target.PrecioVenta = precio;
                target.Activo = true;

                if (idEditar > 0)
                {
                    target.Id = idEditar;
                    negocio.modificar(target);
                }
                else
                {
                    negocio.guardar(target);
                }

                CategoriaActiva = target.Tipo;
                limpiarFormulario();
                actualizarEstilosTabs();
                cargarGrilla();
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex.ToString());
            }
        }

        private void abrirDrawer()
        {
            string script = "setTimeout(function() { const drawer = document.getElementById('drawerFormulario'); if(drawer && !drawer.open) drawer.showModal(); }, 50);";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "AbrirDrawer", script, true);
        }

        private void limpiarFormulario()
        {
            txtNombre.Text = "";
            txtStock.Text = "";
            txtPrecio.Text = "";
            lblErrorDrawer.Text = "";
            lblErrorDrawer.Visible = false;
            ViewState["IdInsumoEditar"] = null;
            btnGuardar.Text = "Guardar Insumo";
        }

        protected void dgvInsumos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            int idInsumo = Convert.ToInt32(dgvInsumos.DataKeys[index].Value);

            if (e.CommandName == "AbrirSumar")
            {
                Insumo seleccionado = negocio.buscarPorId(idInsumo);
                if (seleccionado != null)
                {
                    hfIdSumar.Value = seleccionado.Id.ToString();
                    lblProductoSumar.Text = seleccionado.Nombre;
                    lblStockActualSumar.Text = $"Stock actual: {seleccionado.StockActual} unidades";
                    txtCantidadSumar.Text = string.Empty;
                    pnlSumarStock.Visible = true;
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                try
                {
                    negocio.eliminarLogico(idInsumo);
                    cargarGrilla();
                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex.ToString());
                }
            }
            else if (e.CommandName == "Editar")
            {
                try
                {
                    Insumo seleccionado = negocio.buscarPorId(idInsumo);
                    if (seleccionado != null)
                    {
                        lblErrorDrawer.Visible = false;
                        txtNombre.Text = seleccionado.Nombre;
                        ddlCategoria.SelectedValue = seleccionado.Tipo;
                        txtStock.Text = seleccionado.StockActual.ToString();
                        txtPrecio.Text = seleccionado.PrecioVenta.ToString("0.00");

                        ViewState["IdInsumoEditar"] = seleccionado.Id;
                        btnGuardar.Text = "Modificar Insumo";

                        abrirDrawer();
                    }
                }
                catch (Exception ex)
                {
                    Session.Add("Error", ex.ToString());
                }
            }
        }

        protected void btnConfirmarSumar_Click(object sender, EventArgs e)
        {
            int idInsumo;
            int cantidadASumar;

            if (int.TryParse(hfIdSumar.Value, out idInsumo) &&
                int.TryParse(txtCantidadSumar.Text, out cantidadASumar) &&
                cantidadASumar > 0)
            {
                Insumo existente = negocio.buscarPorId(idInsumo);
                if (existente != null)
                {
                    existente.StockActual += cantidadASumar;
                    negocio.modificar(existente);
                }
            }

            pnlSumarStock.Visible = false;
            cargarGrilla();
        }

        protected void btnCerrarModalSumar_Click(object sender, EventArgs e)
        {
            pnlSumarStock.Visible = false;
        }
    }
}
