using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_RestoBar_Equipo_X.Dominio
{
    public class Mesa
    {
        public int ID { get; set; }
        public int NumeroMesa { get; set; }
        public int Capacidad { get; set; }
        public string Estado { get; set; }
    }
}