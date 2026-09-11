<%@ Page Title="Factura" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Bienvenida.aspx.cs" Inherits="Parcial1AspDeivisCastro.Bienvenida" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="tituloFactura" class="mt-4">
        <div class="row">
            <div class="col-md-12">
                <h2 id="tituloFactura">Factura - Tienda de ropa</h2>
                <p>Ingrese la informacion del cliente y los articulos a facturar.</p>
            </div>
        </div>

        <asp:Panel ID="pnlCliente" runat="server">
            <div class="card border-light shadow-sm mb-4">
                <div class="card-body">
                    <h4 class="mb-3">Informacion del cliente y de la factura</h4>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label>Nombre del cliente</label>
                            <asp:TextBox ID="txtNombreCliente" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombreCliente" ValidationGroup="cliente" ErrorMessage="El nombre es obligatorio" ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Correo electronico</label>
                            <asp:TextBox ID="txtCorreoCliente" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCorreoCliente" ValidationGroup="cliente" ErrorMessage="El correo es obligatorio" ForeColor="Red" Display="Dynamic" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCorreoCliente" ValidationGroup="cliente" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Formato de correo invalido" ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Numero de factura</label>
                            <asp:TextBox ID="txtNumeroFactura" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label>Direccion del cliente</label>
                            <asp:TextBox ID="txtDireccionCliente" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDireccionCliente" ValidationGroup="cliente" ErrorMessage="La direccion es obligatoria" ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Fecha de factura</label>
                            <asp:TextBox ID="txtFechaFactura" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFechaFactura" ValidationGroup="cliente" ErrorMessage="La fecha es obligatoria" ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Ciudad</label>
                            <asp:TextBox ID="txtCiudad" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCiudad" ValidationGroup="cliente" ErrorMessage="La ciudad es obligatoria" ForeColor="Red" Display="Dynamic" />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <label>Codigo postal</label>
                            <asp:TextBox ID="txtCodigoPostal" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCodigoPostal" ValidationGroup="cliente" ErrorMessage="El codigo postal es obligatorio" ForeColor="Red" Display="Dynamic" />
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCodigoPostal" ValidationGroup="cliente" ValidationExpression="^[0-9]{4,6}$" ErrorMessage="Codigo postal invalido" ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Pais</label>
                            <asp:DropDownList ID="ddlPais" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Seleccione" Value=""></asp:ListItem>
                                <asp:ListItem Text="Colombia" Value="Colombia"></asp:ListItem>
                                <asp:ListItem Text="Mexico" Value="México"></asp:ListItem>
                                <asp:ListItem Text="Ecuador" Value="Ecuador"></asp:ListItem>
                                <asp:ListItem Text="Argentina" Value="Argentina"></asp:ListItem>
                                <asp:ListItem Text="Estados Unidos" Value="Estados Unidos"></asp:ListItem>
                                <asp:ListItem Text="Brasil" Value="Brasil"></asp:ListItem>
                                <asp:ListItem Text="Peru" Value="Perú"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlPais" ValidationGroup="cliente" ErrorMessage="Debe seleccionar un pais" ForeColor="Red" Display="Dynamic" />
                        </div>
                        <div class="col-md-4 mb-3">
                            <label>Provincia</label>
                            <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtProvincia" ValidationGroup="cliente" ErrorMessage="La provincia es obligatoria" ForeColor="Red" Display="Dynamic" />
                        </div>
                    </div>

                    <div class="mt-3">
                        <asp:Button ID="btnContinuar" runat="server" Text="Continuar" CssClass="btn btn-primary" OnClick="btnContinuar_Click" ValidationGroup="cliente" />
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlFactura" runat="server" Visible="false">
            <div class="card border-light shadow-sm">
                <div class="card-body">
                    <h4 class="mb-3">Ingrese los articulos que deseas facturar</h4>

                    <div class="table-responsive">
                        <table class="table table-bordered" id="tablaItems">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Descripcion</th>
                                    <th>Presentacion</th>
                                    <th>Cantidad</th>
                                    <th>Precio</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="itemNombre" class="form-control" /></td>
                                    <td><input type="text" name="itemDescripcion" class="form-control" /></td>
                                    <td><input type="text" name="itemPresentacion" class="form-control" /></td>
                                    <td><input type="number" name="itemCantidad" class="form-control item-cantidad" min="1" step="1" oninput="actualizarTotalesFactura();" /></td>
                                    <td><input type="number" name="itemPrecio" class="form-control item-precio" min="0" step="0.01" oninput="actualizarTotalesFactura();" /></td>
                                    <td><input type="text" class="form-control item-total" value="0.00" readonly /></td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="itemNombre" class="form-control" /></td>
                                    <td><input type="text" name="itemDescripcion" class="form-control" /></td>
                                    <td><input type="text" name="itemPresentacion" class="form-control" /></td>
                                    <td><input type="number" name="itemCantidad" class="form-control item-cantidad" min="1" step="1" oninput="actualizarTotalesFactura();" /></td>
                                    <td><input type="number" name="itemPrecio" class="form-control item-precio" min="0" step="0.01" oninput="actualizarTotalesFactura();" /></td>
                                    <td><input type="text" class="form-control item-total" value="0.00" readonly /></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3">
                        <button type="button" class="btn btn-secondary" id="btnAgregarItem" onclick="agregarItemFactura(); return false;">Agregar articulo</button>
                        <asp:Button ID="btnCalcularTotal" runat="server" Text="Confirmar total" CssClass="btn btn-success" OnClick="btnCalcularTotal_Click" />
                        <asp:Button ID="btnFinalizarFactura" runat="server" Text="Finalizar" CssClass="btn btn-primary ml-2" OnClick="btnFinalizarFactura_Click" />
                    </div>

                    <div class="mt-4 row justify-content-end">
                        <div class="col-md-4">
                            <div class="d-flex justify-content-between mb-2"><strong>Subtotal:</strong> <asp:Label ID="lblSubtotal" runat="server" Text="$0.00"></asp:Label></div>
                            <div class="d-flex justify-content-between mb-2"><strong>IVA (19%):</strong> <asp:Label ID="lblIva" runat="server" Text="$0.00"></asp:Label></div>
                            <div class="d-flex justify-content-between mb-2"><strong>Descuento:</strong> <asp:Label ID="lblDescuento" runat="server" Text="$0.00"></asp:Label></div>
                            <div class="d-flex justify-content-between mb-2"><strong>Total a pagar:</strong> <asp:Label ID="lblTotalPagar" runat="server" Text="$0.00"></asp:Label></div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlEncuesta" runat="server" Visible="false">
            <div class="card border-light shadow-sm mt-4">
                <div class="card-body">
                    <h4 class="text-center mb-3">Encuesta de satisfaccion</h4>
                    <p class="text-center">Cuentanos tu experiencia con nuestro sitio web</p>

                    <div class="mb-4">
                        <p><strong>1. Que tan satisfecho estas con la consulta o transaccion que acabas de realizar en nuestro sitio web?</strong></p>
                        <asp:RadioButtonList ID="rblPregunta1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="d-flex align-items-center justify-content-center">
                            <asp:ListItem Text="1" Value="1"></asp:ListItem>
                            <asp:ListItem Text="2" Value="2"></asp:ListItem>
                            <asp:ListItem Text="3" Value="3"></asp:ListItem>
                            <asp:ListItem Text="4" Value="4"></asp:ListItem>
                            <asp:ListItem Text="5" Value="5"></asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="rblPregunta1" ValidationGroup="encuesta" ErrorMessage="Debe seleccionar una opcion." ForeColor="Red" Display="Dynamic" />
                    </div>

                    <div class="mb-4">
                        <p><strong>2. Cuales son las principales razones por las que se sintio satisfecho o no satisfecho con la compra?</strong></p>
                        <asp:TextBox ID="txtComentarioEncuesta" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="text-center">
                        <asp:Button ID="btnEnviarEncuesta" runat="server" Text="Enviar encuesta" CssClass="btn btn-success" OnClick="btnEnviarEncuesta_Click" ValidationGroup="encuesta" />
                    </div>

                    <asp:Label ID="lblEncuestaExito" runat="server" ForeColor="Green" CssClass="d-block text-center mt-3" Visible="false"></asp:Label>
                </div>
            </div>
        </asp:Panel>
    </main>

    <script type="text/javascript">
        function agregarItemFactura() {
            var tbody = document.getElementById('tablaItems').getElementsByTagName('tbody')[0];
            var row = tbody.rows[0].cloneNode(true);
            var inputs = row.querySelectorAll('input');
            for (var i = 0; i < inputs.length; i++) {
                inputs[i].value = '';
            }
            tbody.appendChild(row);
            actualizarTotalesFactura();
        }

        function actualizarTotalesFactura() {
            var tabla = document.getElementById('tablaItems');
            var filas = tabla.getElementsByTagName('tr');
            var subtotal = 0;

            for (var i = 0; i < filas.length; i++) {
                var fila = filas[i];
                var cantidadInput = fila.querySelector('.item-cantidad');
                var precioInput = fila.querySelector('.item-precio');
                var totalInput = fila.querySelector('.item-total');

                if (!cantidadInput || !precioInput || !totalInput) continue;

                var cantidad = parseFloat(cantidadInput.value) || 0;
                var precio = parseFloat(precioInput.value) || 0;
                var totalFila = cantidad * precio;

                totalInput.value = totalFila.toFixed(2);
                subtotal += totalFila;
            }

            var iva = subtotal * 0.19;
            var totalGeneral = subtotal + iva;

            var lblSubtotal = document.getElementById('<%= lblSubtotal.ClientID %>');
            var lblIva = document.getElementById('<%= lblIva.ClientID %>');
            var lblTotalPagar = document.getElementById('<%= lblTotalPagar.ClientID %>');

            if (lblSubtotal) lblSubtotal.innerHTML = '$' + subtotal.toFixed(2);
            if (lblIva) lblIva.innerHTML = '$' + iva.toFixed(2);
            if (lblTotalPagar) lblTotalPagar.innerHTML = '$' + totalGeneral.toFixed(2);
        }
    </script>
</asp:Content>
