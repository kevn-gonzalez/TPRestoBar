namespace TPC_RestoBar_Equipo_X.Dominio
{
    public enum TipoUsuario
    {
        ADMIN = 1,
        USUARIO = 2
    }

    public class Usuario
    {
        public int ID { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Nombre { get; set; }
        public TipoUsuario TipoUsuario { get; set; }
    }
}