
using System;
using System.Collections.Generic;
using TPC_RestoBar_Equipo_X.AccesoDatos;
using TPC_RestoBar_Equipo_X.Dominio;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class PanelMeseroNegocio
    {
        public List<Pedido> listarPedidos(int idMesero)
        {
            List<Pedido> lista = new List<Pedido>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT p.ID, p.FechaApertura, p.Estado,
                           m.NumeroMesa, m.Capacidad
                    FROM Pedidos p
                    INNER JOIN Mesa m ON p.ID_Mesa = m.ID
                    WHERE p.ID_Mesero = @idMesero
                    AND p.Estado = 'Abierto'
                    ORDER BY m.NumeroMesa");

                datos.setearParametro("@idMesero", idMesero);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Pedido pedido = new Pedido();

                    pedido.ID = (int)datos.Lector["ID"];
                    pedido.FechaApertura = (DateTime)datos.Lector["FechaApertura"];
                    pedido.Estado = (string)datos.Lector["Estado"];

                    pedido.Mesa = new Mesa();
                    pedido.Mesa.NumeroMesa = (int)datos.Lector["NumeroMesa"];
                    pedido.Mesa.Capacidad = (int)datos.Lector["Capacidad"];

                    lista.Add(pedido);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public List<Consumicion> listarConsumiciones()
        {
            List<Consumicion> lista = new List<Consumicion>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(
                "SELECT ID, Nombre, Tipo, Precio, StockActual FROM Consumiciones WHERE StockActual > 0 ORDER BY Nombre");

                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Consumicion aux = new Consumicion();

                    aux.ID = (int)datos.Lector["ID"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Tipo = (string)datos.Lector["Tipo"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.StockActual = (int)datos.Lector["StockActual"];

                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

    }
}
