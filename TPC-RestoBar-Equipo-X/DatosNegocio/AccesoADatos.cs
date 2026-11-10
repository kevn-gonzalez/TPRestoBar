using System;
using System.Configuration; // Agregado para leer el Web.config
using System.Data.SqlClient; // Cambiado para que sea compatible con tu Web Forms estándar

namespace TPC_RestoBar_Equipo_X.AccesoDatos
{
    public class AccesoADatos
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;

        public SqlDataReader Lector
        {
            get { return lector; }
        }

        public AccesoADatos()
        { 
            string cadenaConexion = ConfigurationManager.ConnectionStrings["RestoBar"].ConnectionString;
            conexion = new SqlConnection(cadenaConexion);
            comando = new SqlCommand();
        }

        public void setearConsulta(string consulta)
        {
            comando.Parameters.Clear(); 
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = consulta;
        }

        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor ?? DBNull.Value);
        }

        public void ejecutarLectura()
        {
            comando.Connection = conexion;
            try
            {
                if (conexion.State != System.Data.ConnectionState.Open)
                {
                    conexion.Open();
                }
                lector = comando.ExecuteReader();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void ejecutarAccion()
        {
            comando.Connection = conexion;
            try
            {
                if (conexion.State != System.Data.ConnectionState.Open)
                {
                    conexion.Open();
                }
                comando.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int ejecutarScalar()
        {
            comando.Connection = conexion;
            try
            {
                if (conexion.State != System.Data.ConnectionState.Open)
                {
                    conexion.Open();
                }
                return Convert.ToInt32(comando.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void cerrarConexion()
        {
            if (lector != null)
                lector.Close();
            if (conexion.State == System.Data.ConnectionState.Open)
                conexion.Close();
        }
    }
}
