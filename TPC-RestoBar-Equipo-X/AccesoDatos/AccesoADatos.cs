using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TPC_RestoBar_Equipo_X.AccesoDatos
{
    public class AccesoADatos
    {
        private readonly string cadenaConexion;

        public AccesoADatos()
        {
            cadenaConexion = ConfigurationManager
                .ConnectionStrings["RestoBar"].ConnectionString;
        }

        public SqlConnection ObtenerConexion()
        {
            return new SqlConnection(cadenaConexion);
        }

        public DataTable ObtenerMesas()
        {
            DataTable tabla = new DataTable();

            using (SqlConnection conexion = ObtenerConexion())
            {
                string consulta = @"
                    SELECT Id, Numero, Capacidad
                    FROM Mesas
                    ORDER BY Numero";

                using (SqlDataAdapter adaptador =
                    new SqlDataAdapter(consulta, conexion))
                {
                    adaptador.Fill(tabla);
                }
            }

            return tabla;
        }
    }
}