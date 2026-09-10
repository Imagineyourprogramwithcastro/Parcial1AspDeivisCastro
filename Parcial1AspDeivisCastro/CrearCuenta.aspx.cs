using System;
using System.Web.UI;

namespace Parcial1AspDeivisCastro
{
    public partial class CrearCuenta : Page
    {
        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            var correo = txtCorreo.Text.Trim();
            if (Usuarios.ExisteCorreo(correo))
            {
                lblMensaje.CssClass = "text-danger";
                lblMensaje.Text = "El correo ya está registrado.";
                lblMensaje.Visible = true;
                return;
            }

            Usuarios.AgregarUsuario(new Usuario
            {
                Correo = correo,
                Contrasena = txtNuevaContrasena.Text.Trim(),
                Nombre = txtNombre.Text.Trim(),
                Apellido = txtApellido.Text.Trim()
            });

            Response.Redirect("~/index.aspx?registro=ok", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
