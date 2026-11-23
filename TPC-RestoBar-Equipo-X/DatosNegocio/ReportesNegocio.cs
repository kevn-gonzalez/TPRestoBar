
using System;
using System.Data;
using TPC_RestoBar_Equipo_X.AccesoDatos;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class ReportesNegocio
    {
        public decimal obtenerRecaudacionHoy()
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT ISNULL(SUM(c.Precio * c.Cantidad), 0) AS Total
                    FROM Consumiciones c
                    INNER JOIN Pedidos p ON c.PedidoId = p.Id
                    WHERE p.Estado = 'Pagado'
                    AND p.FechaCierre >= CAST(GETDATE() AS DATE)
                    AND p.FechaCierre < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))");

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return Convert.ToDecimal(datos.Lector["Total"]);
                }

                return 0;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public int obtenerPedidosPagadosHoy()
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT COUNT(*) AS Total
                    FROM Pedidos
                    WHERE Estado = 'Pagado'
                    AND FechaCierre >= CAST(GETDATE() AS DATE)
                    AND FechaCierre < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))");

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return Convert.ToInt32(datos.Lector["Total"]);
                }

                return 0;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable listarProductosVendidosHoy()
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT c.Nombre AS Producto,
                           c.Tipo,
                           SUM(c.Cantidad) AS CantidadVendida,
                           SUM(c.Precio * c.Cantidad) AS TotalRecaudado
                    FROM Consumiciones c
                    INNER JOIN Pedidos p ON c.PedidoId = p.Id
                    WHERE p.Estado = 'Pagado'
                    AND p.FechaCierre >= CAST(GETDATE() AS DATE)
                    AND p.FechaCierre < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
                    GROUP BY c.Nombre, c.Tipo
                    ORDER BY CantidadVendida DESC");

                datos.ejecutarLectura();

                DataTable tabla = new DataTable();
                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public DataTable listarPedidosPorMeseroHoy()
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
            SELECT u.Nombre AS Mesero,
                   COUNT(DISTINCT p.Id) AS CantidadPedidosXMesero,
                   ISNULL(SUM(c.Precio * c.Cantidad), 0) AS TotalRecaudadoXMesero
            FROM Pedidos p
            INNER JOIN Usuarios u ON p.MeseroId = u.ID
            LEFT JOIN Consumiciones c ON c.PedidoId = p.Id
            WHERE p.Estado = 'Pagado'
            AND u.TipoPerfil = 'Mesero'
            AND p.FechaCierre >= CAST(GETDATE() AS DATE)
            AND p.FechaCierre < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
            GROUP BY u.ID, u.Nombre
            ORDER BY TotalRecaudadoXMesero DESC");

                datos.ejecutarLectura();

                DataTable tabla = new DataTable();
                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable listarPedidosPorMesaHoy()
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
            SELECT m.NumeroMesa AS Mesa,
                   COUNT(DISTINCT p.Id) AS CantidadPedidosXMesa,
                   ISNULL(SUM(c.Precio * c.Cantidad), 0) AS TotalRecaudadoXMesa
            FROM Pedidos p
            INNER JOIN Mesa m ON p.MesaId = m.Id
            LEFT JOIN Consumiciones c ON c.PedidoId = p.Id
            WHERE p.Estado = 'Pagado'
            AND p.FechaCierre >= CAST(GETDATE() AS DATE)
            AND p.FechaCierre < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
            GROUP BY m.Id, m.NumeroMesa
            ORDER BY m.NumeroMesa");

                datos.ejecutarLectura();

                DataTable tabla = new DataTable();
                tabla.Load(datos.Lector);

                return tabla;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
