using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_RestoBar_Equipo_X.Dominio
{
    public class Consumicion
    {
        public int ID { get; set; }
        public string Nombre { get; set; }
        public string Tipo { get; set; } //Puede ser comida o bebida
        public decimal Precio { get; set; }
        public int StockActual { get; set; }
    }
}