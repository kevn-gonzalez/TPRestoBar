using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using TPC_RestoBar_Equipo_X.DatosNegocio;
using TPC_RestoBar_Equipo_X.Dominio;

namespace TPC_RestoBar_Equipo_X
{
    public partial class Usuarios : System.Web.UI.Page
    {
        private UsuarioNegocio negocio = new UsuarioNegocio();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarGrilla();
            }
        }

        private void cargarGrilla()
        {
            dgvUsuarios.DataSource = negocio.listar();
            dgvUsuarios.DataBind();
        }

        protected void btnAbrirModalNuevo_Click(object sender, EventArgs e)
        {
            txtNombre.Text = "";
            txtUsername.Text = "";
            txtPassword.Text = "";
            ddlPerfil.SelectedValue = "Mesero";
            lblErrorModal.Visible = false;
            pnlModalUsuario.Visible = true;
        }

        protected void btnCerrarModal_Click(object sender, EventArgs e)
        {
            pnlModalUsuario.Visible = false;
        }

        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
            lblErrorModal.Visible = false;

            if (string.IsNullOrWhiteSpace(txtNombre.Text) ||
                string.IsNullOrWhiteSpace(txtUsername.Text) ||
                string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblErrorModal.Text = "⚠️ Completá todos los campos.";
                lblErrorModal.Visible = true;
                return;
            }

            try
            {
                List<Usuario> existentes = negocio.listar();
                if (existentes.Any(u => u.Username.Equals(txtUsername.Text.Trim(), StringComparison.OrdinalIgnoreCase)))
                {
                    lblErrorModal.Text = "⚠️ Ese nombre de usuario ya existe. Elegí otro.";
                    lblErrorModal.Visible = true;
                    return;
                }

                Usuario nuevo = new Usuario();
                nuevo.Nombre = txtNombre.Text.Trim();
                nuevo.Username = txtUsername.Text.Trim();
                nuevo.Password = txtPassword.Text;

                negocio.agregar(nuevo, ddlPerfil.SelectedValue);

                pnlModalUsuario.Visible = false;
                lblMensaje.Text = $"Usuario '{nuevo.Nombre}' ({ddlPerfil.SelectedValue}) creado correctamente.";
                lblMensaje.ForeColor = System.Drawing.Color.LightGreen;
                cargarGrilla();
            }
            catch (Exception)
            {
                lblErrorModal.Text = "⚠️ Ocurrió un error al guardar el usuario.";
                lblErrorModal.Visible = true;
            }
        }

        protected void dgvUsuarios_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                try
                {
                    int index = Convert.ToInt32(e.CommandArgument);
                    int idUsuario = Convert.ToInt32(dgvUsuarios.DataKeys[index].Value);

                    negocio.eliminar(idUsuario);
                    lblMensaje.Text = "Usuario eliminado correctamente.";
                    lblMensaje.ForeColor = System.Drawing.Color.LightGreen;
                    cargarGrilla();
                }
                catch (Exception)
                {
                    lblMensaje.Text = "No se puede eliminar este usuario porque tiene pedidos asociados en el historial.";
                    lblMensaje.ForeColor = System.Drawing.Color.Salmon;
                }
            }
        }
    }
}
