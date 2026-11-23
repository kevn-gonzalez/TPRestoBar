using System;
using System.Collections.Generic;
using TPC_RestoBar_Equipo_X.AccesoDatos;

namespace TPC_RestoBar_Equipo_X.DatosNegocio
{
    public class InsumosNegocio
    {
        public List<Insumo> listar()
        {
            List<Insumo> lista = new List<Insumo>();
            AccesoADatos datos = new AccesoADatos();

            try
            {
                datos.setearConsulta("SELECT Id, Nombre, Tipo, StockActual, PrecioVenta, Activo FROM Insumos WHERE Activo = 1 ORDER BY Nombre");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Insumo aux = new Insumo();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Tipo = (string)datos.Lector["Tipo"];
                    aux.StockActual = (int)datos.Lector["StockActual"];
                    aux.PrecioVenta = (decimal)datos.Lector["PrecioVenta"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }

                return lista;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void guardar(Insumo nuevo)
        {
            AccesoADatos datos = new AccesoADatos();

            try
            {
                // Si viene con Id (desde el botón Editar), actualiza directamente ese registro
                if (nuevo.Id != default(int))
                {
                    datos.setearConsulta("UPDATE Insumos SET Nombre = @Nombre, Tipo = @Tipo, " +
                                         "StockActual = @StockActual, PrecioVenta = @PrecioVenta, Activo = 1 " +
                                         "WHERE Id = @Id");

                    datos.setearParametro("@Id", nuevo.Id);
                    datos.setearParametro("@Nombre", nuevo.Nombre.Trim());
                    datos.setearParametro("@Tipo", nuevo.Tipo);
                    datos.setearParametro("@StockActual", nuevo.StockActual);
                    datos.setearParametro("@PrecioVenta", nuevo.PrecioVenta);

                    datos.ejecutarAccion();
                    return;
                }

                // Si es un alta nueva: verificamos si ya existe un insumo con el mismo Nombre y Tipo
                datos.setearConsulta(@"
                    IF EXISTS (SELECT 1 FROM Insumos WHERE LOWER(LTRIM(RTRIM(Nombre))) = LOWER(LTRIM(RTRIM(@Nombre))) AND Tipo = @Tipo)
                    BEGIN
                        UPDATE Insumos
                        SET StockActual = StockActual + @StockActual,
                            PrecioVenta = CASE WHEN @PrecioVenta > 0 THEN @PrecioVenta ELSE PrecioVenta END,
                            Activo = 1
                        WHERE LOWER(LTRIM(RTRIM(Nombre))) = LOWER(LTRIM(RTRIM(@Nombre))) AND Tipo = @Tipo;
                    END
                    ELSE
                    BEGIN
                        INSERT INTO Insumos (Nombre, Tipo, StockActual, PrecioVenta, Activo)
                        VALUES (LTRIM(RTRIM(@Nombre)), @Tipo, @StockActual, @PrecioVenta, 1);
                    END");

                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Tipo", nuevo.Tipo);
                datos.setearParametro("@StockActual", nuevo.StockActual);
                datos.setearParametro("@PrecioVenta", nuevo.PrecioVenta);

                datos.ejecutarAccion();
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
                datos.setearConsulta("UPDATE Insumos SET Activo = 0 WHERE Id = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void modificar(Insumo modificado)
        {
            AccesoADatos datos = new AccesoADatos();
            try
            {
                datos.setearConsulta("UPDATE Insumos SET Nombre = @Nombre, Tipo = @Tipo, StockActual = @StockActual, PrecioVenta = @PrecioVenta WHERE Id = @Id");

                datos.setearParametro("@Nombre", modificado.Nombre.Trim());
                datos.setearParametro("@Tipo", modificado.Tipo);
                datos.setearParametro("@StockActual", modificado.StockActual);
                datos.setearParametro("@PrecioVenta", modificado.PrecioVenta);
                datos.setearParametro("@Id", modificado.Id);

                datos.ejecutarAccion();
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public Insumo buscarPorId(int id)
        {
            AccesoADatos datos = new AccesoADatos();
            try
            {
                datos.setearConsulta("SELECT Id, Nombre, Tipo, StockActual, PrecioVenta, Activo FROM Insumos WHERE Id = @id");
                datos.setearParametro("@id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Insumo aux = new Insumo();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Tipo = (string)datos.Lector["Tipo"];
                    aux.StockActual = (int)datos.Lector["StockActual"];
                    aux.PrecioVenta = (decimal)datos.Lector["PrecioVenta"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                    return aux;
                }
                return null;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
