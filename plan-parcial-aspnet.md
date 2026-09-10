# Plan Parcial – Login y Registro en ASP.NET (sin base de datos)

**Materia:** Electiva IV – ASP.NET (UAC)
**Alcance:** Parte 1 (Índice.aspx – login) y Parte 2 (Crear cuenta)
**Restricción:** no se permite usar base de datos

---

## Estrategia de almacenamiento

Sin base de datos, la opción más simple y confiable es una **clase estática en memoria** con una `List<Usuario>`. Vive mientras la aplicación esté corriendo, no requiere configuración adicional, y el login y el registro comparten la misma lista: una cuenta creada en la Parte 2 queda disponible para iniciar sesión en la Parte 1.

Alternativas si el profesor pide persistencia entre reinicios del sitio:
- Archivo XML o JSON en `App_Data`
- Session/Application state (similar a la lista estática, pero atada a la sesión)

---

## Plan paso a paso

1. **Definir el almacenamiento en memoria** – Clase estática `Usuarios.cs` con un `List<Usuario>` público, precargado con 1-2 usuarios de prueba.
2. **Crear el modelo `Usuario`** – Propiedades Correo, Contraseña, Nombre, Apellido.
3. **Armar Índice.aspx (login)** – TextBox de correo (`TextMode="Email"`) y contraseña (`TextMode="Password"`), botón, Label de error oculto. Validadores: `RequiredFieldValidator` en ambos campos + `RegularExpressionValidator` en el correo.
4. **Programar index.cs** – En el Click del botón, buscar en `Usuarios.Lista` con LINQ. Si coincide, redirigir; si no, mostrar el error.
5. **Construir "Asistencia para contraseñas"** – TextBox de correo + validadores, botón "Continuar" que envíe un correo real con `System.Net.Mail` (SmtpClient).
6. **Armar CrearCuenta.aspx** – Campos Correo, Nombre, Apellido, Nueva Contraseña, Confirmar Contraseña. `RequiredFieldValidator` en todos, `RegularExpressionValidator` en el correo, `CompareValidator` entre las dos contraseñas.
7. **Programar el alta de usuario** – En el Click de "Enviar", crear el `Usuario` y agregarlo a `Usuarios.Lista`. Redirigir a Índice.aspx.
8. **Probar el flujo completo** – Login con el usuario de prueba, login con datos incorrectos, registro + login inmediato, botón de recuperación.

---

## Modelo y repositorio en memoria

```csharp
public class Usuario
{
    public string Correo { get; set; }
    public string Contrasena { get; set; }
    public string Nombre { get; set; }
    public string Apellido { get; set; }
}

public static class Usuarios
{
    public static List<Usuario> Lista = new List<Usuario>
    {
        new Usuario { Correo = "test@correo.com", Contrasena = "12345", Nombre = "Usuario", Apellido = "Prueba" }
    };

    public static Usuario Validar(string correo, string contrasena)
    {
        return Lista.FirstOrDefault(u => u.Correo == correo && u.Contrasena == contrasena);
    }
}
```

---

## Índice.aspx (login)

### Marcado y validadores

```html
<asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtCorreo"
    ErrorMessage="El correo es obligatorio" ForeColor="Red" Display="Dynamic" />
<asp:RegularExpressionValidator runat="server" ControlToValidate="txtCorreo"
    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
    ErrorMessage="Formato de correo inválido" ForeColor="Red" Display="Dynamic" />

<asp:TextBox ID="txtContrasena" runat="server" TextMode="Password" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtContrasena"
    ErrorMessage="La contraseña es obligatoria" ForeColor="Red" Display="Dynamic" />

<asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false" />
```

### index.cs

```csharp
protected void btnIniciarSesion_Click(object sender, EventArgs e)
{
    var usuario = Usuarios.Validar(txtCorreo.Text, txtContrasena.Text);
    if (usuario != null)
        Response.Redirect("Bienvenida.aspx");
    else
    {
        lblError.Text = "Correo o contraseña incorrectos.";
        lblError.Visible = true;
    }
}
```

---

## Recuperar contraseña

```csharp
protected void btnContinuar_Click(object sender, EventArgs e)
{
    var usuario = Usuarios.Lista.FirstOrDefault(u => u.Correo == txtCorreoRecuperacion.Text);
    if (usuario == null)
    {
        lblErrorRecuperacion.Text = "No existe una cuenta con ese correo.";
        return;
    }

    var mensaje = new MailMessage("tuapp@gmail.com", usuario.Correo);
    mensaje.Subject = "Recuperación de contraseña";
    mensaje.Body = "Tu contraseña registrada es: " + usuario.Contrasena;

    var cliente = new SmtpClient("smtp.gmail.com", 587);
    cliente.Credentials = new NetworkCredential("tuapp@gmail.com", "tu_contraseña_de_aplicación");
    cliente.EnableSsl = true;
    cliente.Send(mensaje);

    lblConfirmacion.Text = "Revisa tu correo.";
}
```

> Necesitas una **contraseña de aplicación** de Gmail (no la contraseña normal de la cuenta) para que `SmtpClient` funcione.

---

## CrearCuenta.aspx

### Marcado y validadores

```html
<asp:TextBox ID="txtCorreo" runat="server" TextMode="Email" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtCorreo"
    ErrorMessage="El correo es obligatorio" ForeColor="Red" Display="Dynamic" />
<asp:RegularExpressionValidator runat="server" ControlToValidate="txtCorreo"
    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
    ErrorMessage="Formato de correo inválido" ForeColor="Red" Display="Dynamic" />

<asp:TextBox ID="txtNombre" runat="server" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombre"
    ErrorMessage="El nombre es obligatorio" ForeColor="Red" Display="Dynamic" />

<asp:TextBox ID="txtApellido" runat="server" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtApellido"
    ErrorMessage="El apellido es obligatorio" ForeColor="Red" Display="Dynamic" />

<asp:TextBox ID="txtNuevaContrasena" runat="server" TextMode="Password" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtNuevaContrasena"
    ErrorMessage="La contraseña es obligatoria" ForeColor="Red" Display="Dynamic" />

<asp:TextBox ID="txtConfirmarContrasena" runat="server" TextMode="Password" />
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmarContrasena"
    ErrorMessage="Confirma la contraseña" ForeColor="Red" Display="Dynamic" />
<asp:CompareValidator runat="server" ControlToValidate="txtConfirmarContrasena"
    ControlToCompare="txtNuevaContrasena" ErrorMessage="Las contraseñas no coinciden"
    ForeColor="Red" Display="Dynamic" />
```

### CrearCuenta.cs

```csharp
protected void btnEnviar_Click(object sender, EventArgs e)
{
    Usuarios.Lista.Add(new Usuario
    {
        Correo = txtCorreo.Text,
        Contrasena = txtNuevaContrasena.Text,
        Nombre = txtNombre.Text,
        Apellido = txtApellido.Text
    });
    Response.Redirect("Index.aspx");
}
```

---

## Regex de correo válido

```
\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
```

Es la misma que trae por defecto Visual Studio al elegir "Internet Email Address" en el asistente del `RegularExpressionValidator`.

---

## Checklist de pruebas

- [ ] Login con el usuario de prueba precargado
- [ ] Login con datos incorrectos (debe mostrar el mensaje de error)
- [ ] Registro de una cuenta nueva
- [ ] Login inmediato con la cuenta recién creada
- [ ] Botón de recuperación de contraseña envía el correo
- [ ] Todos los campos vacíos muestran su `RequiredFieldValidator`
- [ ] Correo con formato inválido muestra su error
- [ ] Contraseñas distintas en "Crear cuenta" muestran el error del `CompareValidator`
