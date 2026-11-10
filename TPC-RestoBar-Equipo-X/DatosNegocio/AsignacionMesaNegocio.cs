using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPC_RestoBar_Equipo_X.Dominio;
using TPC_RestoBar_Equipo_X.AccesoDatos;
using System.Security.AccessControl;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class AsignacionMesaNegocio
    {
        public List<Mesa> listar()
        {
            List<Mesa> lista = new List<Mesa>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(
                    "SELECT ID, NumeroMesa, Capacidad, Estado FROM Mesa ORDER BY NumeroMesa");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Mesa aux = new Mesa();

                    aux.ID = (int)datos.Lector["ID"];
                    aux.NumeroMesa = (int)datos.Lector["NumeroMesa"];
                    aux.Capacidad = (int)datos.Lector["Capacidad"];
                    aux.Estado = (string)datos.Lector["Estado"];

                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Usuario> listarMeseros()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoADatos datos = new AccesoADatos ();

            try
            {
                datos.setearConsulta("SELECT ID, Nombre FROM Usuarios WHERE TipoPerfil = 'Mesero' ORDER BY Nombre");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();

                    aux.ID = (int)datos.Lector["ID"];
                    aux.Nombre = (string)datos.Lector["Nombre"];

                    lista.Add(aux);
                }
                return lista;
            }
            finally { datos.cerrarConexion();}
        }


        public bool asignarMesa(int idMesa, int idMesero)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
            SET XACT_ABORT ON;
            BEGIN TRANSACTION;

            UPDATE Mesa
            SET Estado = 'Ocupada'
            WHERE ID = @idMesa AND Estado = 'Libre'
            AND NOT EXISTS (
                SELECT 1 FROM Pedidos
                WHERE ID_Mesa = @idMesa AND Estado = 'Abierto'
            );

            IF @@ROWCOUNT = 1
            BEGIN
                INSERT INTO Pedidos (ID_Mesa, ID_Mesero, Estado)
                SELECT @idMesa, ID, 'Abierto'
                FROM Usuarios
                WHERE ID = @idMesero AND TipoPerfil = 'Mesero';

                IF @@ROWCOUNT = 1
                BEGIN
                    COMMIT TRANSACTION;
                    SELECT 1;
                END
                ELSE
                BEGIN
                    ROLLBACK TRANSACTION;
                    SELECT 0;
                END
            END
            ELSE
            BEGIN
                ROLLBACK TRANSACTION;
                SELECT 0;
            END");

                datos.setearParametro("@idMesa", idMesa);
                datos.setearParametro("@idMesero", idMesero);

                return datos.ejecutarScalar() == 1;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}

