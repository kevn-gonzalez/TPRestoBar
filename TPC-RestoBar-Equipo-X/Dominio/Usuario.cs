using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TPC_RestoBar_Equipo_X.Dominio
{
    public class Usuario
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public string Password { get; set; } 
        public string Nombre { get; set; }
        public string TipoPerfil { get; set; }
    }
}