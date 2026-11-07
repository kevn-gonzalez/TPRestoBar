using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_RestoBar_Equipo_X.Dominio
{
    public class Pedido
    {
        public int ID { get; set; }
        public Mesa Mesa { get; set; }
        public Usuario Mesero { get; set; }
        public DateTime FechaApertura { get; set; }
        public DateTime? FechaCierre { get; set; } 
        public string Estado { get; set; }
    }
}