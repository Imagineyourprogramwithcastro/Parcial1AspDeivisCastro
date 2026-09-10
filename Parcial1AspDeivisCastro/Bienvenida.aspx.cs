using System;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial1AspDeivisCastro
{
    public partial class Bienvenida : Page
    {
        protected Panel pnlCliente;
        protected Panel pnlFactura;
        protected TextBox txtNombreCliente;
        protected TextBox txtCorreoCliente;
        protected TextBox txtNumeroFactura;
        protected TextBox txtDireccionCliente;
        protected TextBox txtFechaFactura;
        protected TextBox txtCiudad;
        protected TextBox txtCodigoPostal;
        protected DropDownList ddlPais;
        protected TextBox txtProvincia;
        protected Button btnContinuar;
        protected Button btnCalcularTotal;
        protected Button btnFinalizarFactura;
        protected Panel pnlEncuesta;
        protected RadioButtonList rblPregunta1;
        protected TextBox txtComentarioEncuesta;
        protected Button btnEnviarEncuesta;
        protected Label lblEncuestaExito;
        protected Label lblSubtotal;
        protected Label lblIva;
        protected Label lblDescuento;
        protected Label lblTotalPagar;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtNumeroFactura.Text = "FAC-" + DateTime.Now.ToString("yyMMdd") + "-" + new Random().Next(100, 999);
                txtFechaFactura.Text = DateTime.Today.ToString("yyyy-MM-dd");
                pnlCliente.Visible = true;
                pnlFactura.Visible = false;
            }
        }

        protected void btnContinuar_Click(object sender, EventArgs e)
        {
            Page.Validate("cliente");
            if (!Page.IsValid)
                return;

            pnlCliente.Visible = false;
            pnlFactura.Visible = true;
        }

        protected void btnCalcularTotal_Click(object sender, EventArgs e)
        {
            var nombres = Request.Form.GetValues("itemNombre");
            var descripciones = Request.Form.GetValues("itemDescripcion");
            var presentaciones = Request.Form.GetValues("itemPresentacion");
            var cantidades = Request.Form.GetValues("itemCantidad");
            var precios = Request.Form.GetValues("itemPrecio");

            if (nombres == null || descripciones == null || presentaciones == null || cantidades == null || precios == null)
            {
                lblSubtotal.Text = "$0.00";
                lblIva.Text = "$0.00";
                lblDescuento.Text = "$0.00";
                lblTotalPagar.Text = "$0.00";
                return;
            }

            decimal subtotal = 0m;
            decimal descuento = 0m;

            for (int i = 0; i < nombres.Length; i++)
            {
                if (string.IsNullOrWhiteSpace(nombres[i]) &&
                    string.IsNullOrWhiteSpace(descripciones[i]) &&
                    string.IsNullOrWhiteSpace(presentaciones[i]) &&
                    string.IsNullOrWhiteSpace(cantidades[i]) &&
                    string.IsNullOrWhiteSpace(precios[i]))
                {
                    continue;
                }

                if (string.IsNullOrWhiteSpace(nombres[i]) ||
                    string.IsNullOrWhiteSpace(descripciones[i]) ||
                    string.IsNullOrWhiteSpace(presentaciones[i]) ||
                    string.IsNullOrWhiteSpace(cantidades[i]) ||
                    string.IsNullOrWhiteSpace(precios[i]))
                {
                    continue;
                }

                decimal cantidad;
                decimal precio;

                if (!decimal.TryParse(cantidades[i], NumberStyles.Number, CultureInfo.InvariantCulture, out cantidad) ||
                    !decimal.TryParse(precios[i], NumberStyles.Number, CultureInfo.InvariantCulture, out precio))
                {
                    continue;
                }

                subtotal += cantidad * precio;
            }

            decimal iva = subtotal * 0.19m;
            decimal total = subtotal + iva - descuento;

            lblSubtotal.Text = "$" + subtotal.ToString("0.00", CultureInfo.InvariantCulture);
            lblIva.Text = "$" + iva.ToString("0.00", CultureInfo.InvariantCulture);
            lblDescuento.Text = "$" + descuento.ToString("0.00", CultureInfo.InvariantCulture);
            lblTotalPagar.Text = "$" + total.ToString("0.00", CultureInfo.InvariantCulture);
        }

        protected void btnFinalizarFactura_Click(object sender, EventArgs e)
        {
            pnlFactura.Visible = false;
            pnlEncuesta.Visible = true;
            lblEncuestaExito.Visible = false;
        }

        protected void btnEnviarEncuesta_Click(object sender, EventArgs e)
        {
            Page.Validate("encuesta");
            if (!Page.IsValid)
                return;

            lblEncuestaExito.Text = "Has finalizado la encuesta con éxito.";
            lblEncuestaExito.Visible = true;
            pnlEncuesta.Visible = false;

            ScriptManager.RegisterStartupScript(this, GetType(), "redirectLogin", "setTimeout(function(){ window.location='index.aspx'; }, 2500);", true);
        }
    }
}
