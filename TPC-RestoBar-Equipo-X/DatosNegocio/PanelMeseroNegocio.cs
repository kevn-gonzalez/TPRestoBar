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
                // CORREGIDO: p.MesaId = m.Id (antes decía p.Id = m.ID)
                datos.setearConsulta(@"
                    SELECT p.Id, p.FechaApertura, p.Estado,
                           m.Id AS IdMesa, m.NumeroMesa, m.Capacidad
                    FROM Pedidos p
                    INNER JOIN Mesa m ON p.MesaId = m.Id
                    WHERE p.MeseroId = @idMesero
                    AND p.Estado = 'Abierto'
                    ORDER BY m.NumeroMesa");

                datos.setearParametro("@idMesero", idMesero);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Pedido pedido = new Pedido();
                    pedido.Id = (int)datos.Lector["Id"];
                    pedido.FechaApertura = (DateTime)datos.Lector["FechaApertura"];
                    pedido.Estado = (string)datos.Lector["Estado"];

                    pedido.Mesa = new Mesa();
                    pedido.Mesa.Id = (int)datos.Lector["IdMesa"];
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

        // CORREGIDO: Ahora filtra por @PedidoId para no mezclar mesas
        public List<Consumicion> listarConsumiciones(int idPedido)
        {
            List<Consumicion> lista = new List<Consumicion>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    SELECT Id, InsumoId, PedidoId, Nombre, Tipo, Precio, Cantidad 
                    FROM Consumiciones 
                    WHERE PedidoId = @PedidoId AND Cantidad > 0 
                    ORDER BY Id DESC");

                datos.setearParametro("@PedidoId", idPedido);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Consumicion aux = new Consumicion();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.InsumoId = (int)datos.Lector["InsumoId"];
                    aux.PedidoId = (int)datos.Lector["PedidoId"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Tipo = (string)datos.Lector["Tipo"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.Cantidad = (int)datos.Lector["Cantidad"];

                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void guardar(Consumicion nuevo)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta(@"
                    INSERT INTO Consumiciones (InsumoId, PedidoId, Nombre, Tipo, Precio, Cantidad)
                    VALUES (@InsumoId, @PedidoId, @Nombre, @Tipo, @Precio, @Cantidad)");

                datos.setearParametro("@InsumoId", nuevo.InsumoId);
                datos.setearParametro("@PedidoId", nuevo.PedidoId);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Tipo", nuevo.Tipo);
                datos.setearParametro("@Precio", nuevo.Precio);
                datos.setearParametro("@Cantidad", nuevo.Cantidad);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}

