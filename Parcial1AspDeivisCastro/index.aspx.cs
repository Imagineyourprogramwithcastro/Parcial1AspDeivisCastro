using System;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial1AspDeivisCastro
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Visible = false;
                lblError.Text = string.Empty;
                lblConfirmacion.Visible = false;
                lblConfirmacion.Text = string.Empty;
                lblErrorRecuperacion.Visible = false;
                lblErrorRecuperacion.Text = string.Empty;
            }

            if (!IsPostBack && Request.QueryString["registro"] == "ok")
            {
                lblError.CssClass = "text-success";
                lblError.Text = "Cuenta creada correctamente. Ya puedes iniciar sesión.";
                lblError.Visible = true;
            }

            if (lblErrorRecuperacion.Visible || lblConfirmacion.Visible)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "abrirRecuperacion", "document.getElementById('pnlRecuperacion').style.display = 'block';", true);
            }
        }

        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            // Manual server-side validation (we disabled client-side CausesValidation to ensure handler runs)
            var correo = (txtEmail.Text ?? string.Empty).Trim();
            var contrasena = (txtContrasena.Text ?? string.Empty).Trim();

            if (string.IsNullOrWhiteSpace(correo) || string.IsNullOrWhiteSpace(contrasena))
            {
                lblError.CssClass = "text-danger";
                lblError.Text = "Debe ingresar correo y contraseña.";
                lblError.Visible = true;
                return;
            }

            // simple server-side email format check
            var emailPattern = "^\\w+([-.+']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
            if (!System.Text.RegularExpressions.Regex.IsMatch(correo, emailPattern))
            {
                lblError.CssClass = "text-danger";
                lblError.Text = "Formato de correo inválido.";
                lblError.Visible = true;
                return;
            }

            var usuario = Usuarios.Validar(correo, contrasena);
            if (usuario == null)
            {
                lblError.CssClass = "text-danger";
                lblError.Text = "Este usuario no existe o la contraseña es incorrecta.";
                lblError.Visible = true;
                return;
            }

            Session["UsuarioActual"] = usuario;
            // Ensure redirect completes even during debugging
            Response.Redirect("~/Bienvenida.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnContinuar_Click(object sender, EventArgs e)
        {
            var correo = (txtCorreoRecuperacion.Text ?? string.Empty).Trim();

            if (string.IsNullOrWhiteSpace(correo))
            {
                lblErrorRecuperacion.CssClass = "text-danger";
                lblErrorRecuperacion.Text = "Ingrese un correo para recuperar la contraseña.";
                lblErrorRecuperacion.Visible = true;
                lblConfirmacion.Visible = false;
                return;
            }

            var emailPattern = @"^\w+([-.+']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$";
            if (!System.Text.RegularExpressions.Regex.IsMatch(correo, emailPattern))
            {
                lblErrorRecuperacion.CssClass = "text-danger";
                lblErrorRecuperacion.Text = "Formato de correo inválido.";
                lblErrorRecuperacion.Visible = true;
                lblConfirmacion.Visible = false;
                return;
            }

            if (!Usuarios.ExisteCorreo(correo))
            {
                lblErrorRecuperacion.CssClass = "text-danger";
                lblErrorRecuperacion.Text = "No existe una cuenta con ese correo.";
                lblErrorRecuperacion.Visible = true;
                lblConfirmacion.Visible = false;
                return;
            }

            var usuario = Usuarios.Lista.FirstOrDefault(u =>
                string.Equals(u.Correo.Trim(), correo, StringComparison.OrdinalIgnoreCase));

            if (usuario == null)
            {
                lblErrorRecuperacion.CssClass = "text-danger";
                lblErrorRecuperacion.Text = "No existe una cuenta con ese correo.";
                lblErrorRecuperacion.Visible = true;
                lblConfirmacion.Visible = false;
                return;
            }

            try
            {
                var correoRemitente = "deiviscastrojimenezco@gmail.com";
                var claveApp = "bain oekw uhgf rspr";

                var mensaje = new MailMessage(correoRemitente, usuario.Correo)
                {
                    Subject = "Recuperación de contraseña",
                    Body = "Tu contraseña registrada es: " + usuario.Contrasena
                };

                var cliente = new SmtpClient("smtp.gmail.com", 587)
                {
                    Credentials = new NetworkCredential(correoRemitente, claveApp),
                    EnableSsl = true
                };

                cliente.Send(mensaje);
                lblConfirmacion.CssClass = "text-success";
                lblConfirmacion.Text = "Se envió tu contraseña al correo registrado.";
                lblConfirmacion.Visible = true;
                lblErrorRecuperacion.Visible = false;
            }
            catch
            {
                lblConfirmacion.CssClass = "text-success";
                lblConfirmacion.Text = "Tu contraseña es: " + usuario.Contrasena + " (modo simulado).";
                lblConfirmacion.Visible = true;
                lblErrorRecuperacion.Visible = false;
            }
        }
    }
}
