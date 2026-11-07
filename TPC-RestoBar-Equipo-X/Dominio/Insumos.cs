using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_RestoBar_Equipo_X
{
    public class insumos
    {

        public int IdInsumo { get; set; }
        public string Nombre { get; set; }
        public string Tipo { get; set; } // Comida o bebida
        public int StockActual { get; set; }
        public decimal PrecioVenta { get; set; }
        public bool Activo { get; set; } // Si hay ese insumo o ya no hay en el stock
    }


}