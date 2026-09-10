using System;
using System.Collections.Generic;
using System.Linq;

namespace Parcial1AspDeivisCastro
{
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
            if (string.IsNullOrWhiteSpace(correo) || string.IsNullOrWhiteSpace(contrasena))
                return null;

            return Lista.FirstOrDefault(u =>
                string.Equals(u.Correo.Trim(), correo.Trim(), StringComparison.OrdinalIgnoreCase)
                && string.Equals(u.Contrasena, contrasena));
        }

        public static bool ExisteCorreo(string correo)
        {
            if (string.IsNullOrWhiteSpace(correo))
                return false;

            return Lista.Any(u =>
                string.Equals(u.Correo.Trim(), correo.Trim(), StringComparison.OrdinalIgnoreCase));
        }

        public static void AgregarUsuario(Usuario usuario)
        {
            if (usuario == null)
                throw new ArgumentNullException(nameof(usuario));

            if (ExisteCorreo(usuario.Correo))
                throw new InvalidOperationException("El correo ya está registrado.");

            Lista.Add(usuario);
        }
    }
}
