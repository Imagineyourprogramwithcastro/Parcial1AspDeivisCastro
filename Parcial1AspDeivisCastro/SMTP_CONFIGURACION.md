# CONFIGURAR SMTP GMAIL EN ASP.NET

## Pasos para Habilitar SMTP en Gmail

### 1. Habilitar la Verificación en Dos Pasos
- Ve a tu cuenta Google: https://myaccount.google.com/
- En la barra lateral izquierda, selecciona **Seguridad**
- Busca "Verificación en dos pasos" y presiona **Habilitar**
- Sigue los pasos requeridos por Google

### 2. Crear una Contraseña de Aplicación
Una vez habilitada la verificación de dos pasos:
- Ve a https://myaccount.google.com/apppasswords
- Selecciona tu dispositivo (otras opciones) y navegador
- Haz clic en **Generar**
- Google te mostrará una contraseña de 16 caracteres
- **Cópiala y guárdala en un lugar seguro**

### 3. Configurar en tu Código ASP.NET
Esa contraseña de 16 caracteres es lo que usarás en tu código:

```csharp
var cliente = new SmtpClient("smtp.gmail.com", 587)
{
	Credentials = new NetworkCredential("tucorreo@gmail.com", "tu_contraseña_de_16_caracteres"),
	EnableSsl = true
};
```

### 4. Permitir Aplicaciones Menos Seguras (Alternativa ANTIGUA - No recomendada)
Si prefieres usar tu contraseña normal en lugar de la de aplicación:
- Esto es menos seguro y Google ya no lo permite en muchas cuentas
- Si aún funciona, ve a: https://myaccount.google.com/lesssecureapps

**Recomendación:** Usa siempre la contraseña de aplicación (paso 2)

## Configuración Completa en Web.config (Opcional)

Puedes guardar las credenciales en `Web.config` en lugar de hardcodearlas:

```xml
<configuration>
  <system.net>
	<mailSettings>
	  <smtp host="smtp.gmail.com" port="587">
		<specifiedPickupDirectory pickupDirectoryLocation="C:\temp\mails\" />
	  </smtp>
	</mailSettings>
  </system.net>
</configuration>
```

O directamente en el código:

```csharp
using System.Net.Mail;
using System.Net;

var mensaje = new MailMessage("tucorreo@gmail.com", usuario.Correo)
{
	Subject = "Recuperación de contraseña",
	Body = "Tu contraseña registrada es: " + usuario.Contrasena
};

var cliente = new SmtpClient("smtp.gmail.com", 587)
{
	Credentials = new NetworkCredential("tucorreo@gmail.com", "contrasena_de_aplicacion_16_caracteres"),
	EnableSsl = true,
	Timeout = 10000
};

try
{
	cliente.Send(mensaje);
	lblConfirmacion.Text = "Se envió tu contraseña al correo registrado.";
	lblConfirmacion.Visible = true;
}
catch (SmtpException ex)
{
	// Fallback simulado si no funciona SMTP
	lblConfirmacion.Text = "Tu contraseña es: " + usuario.Contrasena + " (Modo simulado)";
	lblConfirmacion.Visible = true;
}
finally
{
	cliente.Dispose();
}
```

## Pruebas

Para probar sin usar SMTP real:

1. **Test Mode (Archivo local):**
```csharp
var cliente = new SmtpClient
{
	PickupDirectoryLocation = "C:\\temp\\email\\",
	DeliveryMethod = SmtpDeliveryMethod.SpecifiedPickupDirectory
};
```

2. **Test Mode (Consola):**
```csharp
var cliente = new SmtpClient
{
	DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis
};
```

## Errores Comunes

| Error | Solución |
|-------|----------|
| `The SMTP server requires a secure connection or the client was not authenticated.` | Usa `EnableSsl = true` y contraseña de aplicación |
| `Unable to connect to the remote server` | Verifica puerto 587 y que no haya firewall |
| `Invalid username/password` | Verifica que la contraseña sea de 16 caracteres generada en apppasswords |
| `The operation has timed out` | Aumenta el Timeout en el SmtpClient |

## Código en index.aspx.cs (Referencia)

Ver el método `btnContinuar_Click` en `index.aspx.cs` para ver la implementación completa con fallback simulado.
