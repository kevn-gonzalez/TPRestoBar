
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
    }
}
