using System.Web;
using TPC_RestoBar_Equipo_X.Dominio;

namespace TPC_RestoBar_Equipo_X
{
    public static class Seguridad
    {
        public static bool EstaLogueado()
        {
            return HttpContext.Current.Session["usuario"] != null;
        }

        public static bool EsAdmin()
        {
            if (!EstaLogueado())
                return false;

            Usuario usuario = (Usuario)HttpContext.Current.Session["usuario"];

            return usuario.TipoUsuario == TipoUsuario.ADMIN;
        }
    }
}