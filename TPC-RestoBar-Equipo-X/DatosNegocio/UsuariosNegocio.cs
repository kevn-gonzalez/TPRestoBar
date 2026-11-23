using System;
using System.Collections.Generic;
using TPC_RestoBar_Equipo_X.AccesoDatos;
using TPC_RestoBar_Equipo_X.Dominio;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class UsuarioNegocio
    {
        public List<Usuario> listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("SELECT Id, Username, Password, Nombre, TipoPerfil FROM Usuarios ORDER BY Nombre");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.ID = (int)datos.Lector["Id"];
                    aux.Username = (string)datos.Lector["Username"];
                    aux.Password = (string)datos.Lector["Password"];
                    aux.Nombre = (string)datos.Lector["Nombre"];

                    string perfil = datos.Lector["TipoPerfil"].ToString();
                    aux.TipoUsuario = perfil.Equals("Admin", StringComparison.OrdinalIgnoreCase)
                        ? TipoUsuario.ADMIN
                        : TipoUsuario.USUARIO;

                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void agregar(Usuario nuevo, string tipoPerfil)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Usuarios (Username, Password, Nombre, TipoPerfil)
                    VALUES (@Username, @Password, @Nombre, @TipoPerfil)");

                datos.setearParametro("@Username", nuevo.Username.Trim());
                datos.setearParametro("@Password", nuevo.Password);
                datos.setearParametro("@Nombre", nuevo.Nombre.Trim());
                datos.setearParametro("@TipoPerfil", tipoPerfil);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void eliminar(int id)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("DELETE FROM Usuarios WHERE Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
