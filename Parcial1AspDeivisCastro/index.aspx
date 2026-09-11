<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Parcial1AspDeivisCastro._Default" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="Login">
        <div class="row">
            <div class="col-md-5 mt-4">
                <h1 id="Login">Inicio de sesion</h1>

                <div class="form-group">
                    <label for="txtEmail">Correo electronico:</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Ingrese su correo electronico"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtEmail" ErrorMessage="El campo es obligatorio" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Formato de correo invalido" ForeColor="Red" Display="Dynamic" />
                </div>

                <div class="form-group mt-3">
                    <label for="txtContrasena">Contrasena:</label>
                    <asp:TextBox ID="txtContrasena" runat="server" CssClass="form-control" TextMode="Password" placeholder="Ingrese su contrasena"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtContrasena" ErrorMessage="La clave es requerida" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <asp:Label ID="lblError" runat="server" CssClass="text-danger" Visible="false" />

                <div class="mt-3">
                    <asp:Button ID="btnIniciarSesion" runat="server" Text="Iniciar sesion" CssClass="btn btn-primary" OnClick="btnIniciarSesion_Click" CausesValidation="false" />
                </div>




                <div class="mt-3">
                    <a href="#" id="lnkOlvide" class="btn btn-link btn-sm" onclick="toggleRecuperacion(); return false;">Olvide mi contrasena</a>
                </div>
                <div id="pnlRecuperacion" class="mt-4 border-top pt-3" style="display: none;">
                    <h3>Recuperar contrasena</h3>
                    <div class="form-group mt-2">
                        <label for="txtCorreoRecuperacion">Correo de recuperacion:</label>
                        <asp:TextBox ID="txtCorreoRecuperacion" runat="server" CssClass="form-control" TextMode="Email" placeholder="Ingrese su correo"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCorreoRecuperacion" ErrorMessage="El correo es obligatorio" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCorreoRecuperacion" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Formato de correo inválido" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                    <div class="mt-2">
                        <asp:Button ID="btnContinuar" runat="server" Text="Continuar" CssClass="btn btn-secondary" OnClick="btnContinuar_Click" CausesValidation="false" OnClientClick="return validarCorreoRecuperacion();" />
                    </div>
                    <asp:Label ID="lblErrorRecuperacion" runat="server" CssClass="text-danger" Visible="false" />
                    <asp:Label ID="lblConfirmacion" runat="server" CssClass="text-success" Visible="false" />
                </div>

                <p class="mt-3">
                    No tienes cuenta? <a href="~/CrearCuenta.aspx" runat="server">Crear cuenta</a>
                </p>
            </div>
        </div>
    </main>

    <script type="text/javascript">
        function toggleRecuperacion() {
            var panel = document.getElementById('pnlRecuperacion');
            if (panel.style.display === 'none' || panel.style.display === '') {
                panel.style.display = 'block';
            } else {
                panel.style.display = 'none';
            }
        }

        function validarCorreoRecuperacion() {
            var correo = document.getElementById('<%= txtCorreoRecuperacion.ClientID %>').value.trim();
            if (correo === '') {
                alert('Ingrese un correo para recuperar la contraseña.');
                document.getElementById('pnlRecuperacion').style.display = 'block';
                return false;
            }

            var regex = /^\w+([-.+']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
            if (!regex.test(correo)) {
                alert('Formato de correo inválido.');
                document.getElementById('pnlRecuperacion').style.display = 'block';
                return false;
            }

            document.getElementById('pnlRecuperacion').style.display = 'block';
            return true;
        }

        window.onload = function () {
            var savePanel = document.getElementById('pnlRecuperacion');
            var hasMessage = '<%= lblErrorRecuperacion.Visible || lblConfirmacion.Visible ? "true" : "false" %>' === 'true';
            if (hasMessage) {
                savePanel.style.display = 'block';
            }
        };
    </script>
</asp:Content>
