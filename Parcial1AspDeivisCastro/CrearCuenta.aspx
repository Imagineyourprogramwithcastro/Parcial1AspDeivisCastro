<%@ Page Title="Crear cuenta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CrearCuenta.aspx.cs" Inherits="Parcial1AspDeivisCastro.CrearCuenta" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="registroTitulo">
        <div class="row">
            <div class="col-md-6 mt-4">
                <h1 id="registroTitulo">Crear cuenta</h1>

                <div class="form-group">
                    <label for="txtNombre">Nombre:</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es obligatorio" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mt-3">
                    <label for="txtApellido">Apellido:</label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido es obligatorio" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mt-3">
                    <label for="txtCorreo">Correo electronico:</label>
                    <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCorreo" ErrorMessage="El correo es obligatorio" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCorreo" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Formato de correo inválido" ForeColor="Red" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group mt-3">
                    <label for="txtNuevaContrasena">Contrasena:</label>
                    <asp:TextBox ID="txtNuevaContrasena" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNuevaContrasena" ErrorMessage="La contrasena es obligatoria" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mt-3">
                    <label for="txtConfirmarContrasena">Confirmar contrasena:</label>
                    <asp:TextBox ID="txtConfirmarContrasena" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmarContrasena" ErrorMessage="Confirma la contrasena" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator runat="server" ControlToValidate="txtConfirmarContrasena" ControlToCompare="txtNuevaContrasena" ErrorMessage="Las contraseñas no coinciden" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                </div>

                <asp:Label ID="lblMensaje" runat="server" Visible="false" CssClass="d-block mt-3" />

                <div class="mt-3">
                    <asp:Button ID="btnRegistrar" runat="server" Text="Registrarse" CssClass="btn btn-success" OnClick="btnRegistrar_Click" />
                </div>

                <p class="mt-3">
                    <a href="~/index.aspx" runat="server">Volver al inicio de sesion</a>
                </p>
            </div>
        </div>
    </main>
</asp:Content>
