using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPC_RestoBar_Equipo_X.AccesoDatos;
using TPC_RestoBar_Equipo_X.Dominio;
//WORK in PROGRES
namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class MeserosNegocio
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

        public void agregar(Mesa nuevo)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("INSERT INTO Mesa (NumeroMesa, Capacidad) " +
                                      "VALUES (@Numero, @Capacidad)");

                datos.setearParametro("@Numero", nuevo.NumeroMesa);
                datos.setearParametro("@Capacidad", nuevo.Capacidad);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void eliminarLogico(int id)
        {
            AccesoADatos datos = new AccesoADatos();
            try
            {
                datos.setearConsulta("UPDATE Insumos SET Activo = 0 WHERE IdInsumo = @id");
                datos.setearParametro("@id", id);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void modificar(insumos modificado)
        {
            AccesoADatos datos = new AccesoADatos();
            try
            {
                datos.setearConsulta("UPDATE Insumos SET Nombre = @Nombre, Tipo = @Tipo, StockActual = @StockActual, PrecioVenta = @PrecioVenta WHERE IdInsumo = @IdInsumo");

                datos.setearParametro("@Nombre", modificado.Nombre);
                
                datos.setearParametro("@StockActual", modificado.StockActual);
                datos.setearParametro("@PrecioVenta", modificado.PrecioVenta);
                datos.setearParametro("@IdInsumo", modificado.IdInsumo);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public insumos buscarPorId(int id)
        {
            AccesoADatos datos = new AccesoADatos();
            try
            {
                datos.setearConsulta("SELECT IdInsumo, Nombre, Tipo, StockActual, PrecioVenta, Activo FROM Insumos WHERE IdInsumo = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    insumos aux = new insumos();
                    aux.IdInsumo = (int)datos.Lector["IdInsumo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    
                    aux.StockActual = (int)datos.Lector["StockActual"];
                    aux.PrecioVenta = (decimal)datos.Lector["PrecioVenta"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                    return aux;
                }
                return null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
