using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TPC_RestoBar_Equipo_X.AccesoDatos;
using TPC_RestoBar_Equipo_X.Dominio;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class MesaNegocio
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

                    aux.Id = (int)datos.Lector["Id"];
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
                datos.setearConsulta("UPDATE Mesa SET Activo = 0 WHERE Id = @id");
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
        public void modificar(Mesa modificado)
        {
            AccesoADatos datos = new AccesoADatos();
            try
            {
                datos.setearConsulta("UPDATE Mesa SET NumeroMesa = @NumeroMesa, Capacidad = @Capacidad, Estado = @Estado, WHERE Id = @id");

                datos.setearParametro("@NumeroMesa", modificado.NumeroMesa);
                
                datos.setearParametro("@Capacidad", modificado.Capacidad);
                datos.setearParametro("@Estado", modificado.Estado);
                datos.setearParametro("@Id", modificado.Id);

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
        public Mesa buscarPorId(int id)
        {
            AccesoADatos datos = new AccesoADatos();
            try
            {
                datos.setearConsulta("SELECT Id, NumeroMesa, Capacidad, Estado, FROM Mesa WHERE Id = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Mesa aux = new Mesa();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.NumeroMesa = (int)datos.Lector["NumeroMesa"];
                    
                    aux.Capacidad = (int)datos.Lector["Capacidad"];
                    
                    aux.Estado = (string)datos.Lector["Estado"];
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
