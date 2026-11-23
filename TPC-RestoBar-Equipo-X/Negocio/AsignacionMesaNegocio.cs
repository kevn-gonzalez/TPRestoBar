using System;
using System.Collections.Generic;
using TPC_RestoBar_Equipo_X.Dominio;
using TPC_RestoBar_Equipo_X.AccesoDatos;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class AsignacionMesaNegocio
    {
        public List<Usuario> listarMeseros()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre FROM Usuarios WHERE TipoPerfil = 'Mesero' ORDER BY Nombre");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.ID = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    lista.Add(aux);
                }
                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
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
                    WHERE Id = @idMesa AND Estado = 'Libre'
                    AND NOT EXISTS (
                        SELECT 1 FROM Pedidos
                        WHERE MesaId = @idMesa AND Estado = 'Abierto'
                    );

                    IF @@ROWCOUNT = 1
                    BEGIN
                        INSERT INTO Pedidos (MesaId, MeseroId, Estado)
                        SELECT @idMesa, Id, 'Abierto'
                        FROM Usuarios
                        WHERE Id = @idMesero AND TipoPerfil = 'Mesero';

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

        public bool desasignarMesa(int idMesa)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    SET XACT_ABORT ON;
                    BEGIN TRANSACTION;

                    -- Solo permite desasignar si NO hay consumiciones cargadas en el pedido abierto
                    IF NOT EXISTS (
                        SELECT 1 
                        FROM Consumiciones c
                        INNER JOIN Pedidos p ON c.PedidoId = p.Id
                        WHERE p.MesaId = @idMesa AND p.Estado = 'Abierto'
                    )
                    BEGIN
                        UPDATE Pedidos
                        SET Estado = 'Cancelado', FechaCierre = GETDATE()
                        WHERE MesaId = @idMesa AND Estado = 'Abierto';

                        UPDATE Mesa
                        SET Estado = 'Libre'
                        WHERE Id = @idMesa AND Estado <> 'Libre';

                        COMMIT TRANSACTION;
                        SELECT 1;
                    END
                    ELSE
                    BEGIN
                        ROLLBACK TRANSACTION;
                        SELECT 0;
                    END");

                datos.setearParametro("@idMesa", idMesa);

                return datos.ejecutarScalar() == 1;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
