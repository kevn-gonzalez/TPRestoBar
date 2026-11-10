using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPC_RestoBar_Equipo_X.AccesoDatos;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class InsumosNegocio
    {
        public List<insumos> listar()
        {
            List<insumos> lista = new List<insumos>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("SELECT IdInsumo, Nombre, Tipo, StockActual, PrecioVenta, Activo FROM Insumos WHERE Activo = 1");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    insumos aux = new insumos();
                    aux.IdInsumo = (int)datos.Lector["IdInsumo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Tipo = (string)datos.Lector["Tipo"];
                    aux.StockActual = (int)datos.Lector["StockActual"];
                    aux.PrecioVenta = (decimal)datos.Lector["PrecioVenta"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }

                return lista;
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

        public void guardar(insumos nuevo)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("INSERT INTO Insumos (Nombre, Tipo, StockActual, PrecioVenta, Activo) " +
                                      "VALUES (@Nombre, @Tipo, @StockActual, @PrecioVenta, 1)");

                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Tipo", nuevo.Tipo);
                datos.setearParametro("@StockActual", nuevo.StockActual);
                datos.setearParametro("@PrecioVenta", nuevo.PrecioVenta);

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
                datos.setearParametro("@Tipo", modificado.Tipo);
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
                    aux.Tipo = (string)datos.Lector["Tipo"];
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