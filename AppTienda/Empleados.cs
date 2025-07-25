//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AppTienda
{
    using System;
    using System.Collections.Generic;
    
    public partial class Empleados
    {
        public Empleados()
        {
            this.Usuarios = new HashSet<Usuarios>();
            this.Ventas = new HashSet<Ventas>();
        }
    
        public int EmpleadoID { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string DNI { get; set; }
        public string Telefono { get; set; }
        public string Direccion { get; set; }
        public string Cargo { get; set; }
        public Nullable<System.DateTime> FechaContratacion { get; set; }
        public Nullable<decimal> Salario { get; set; }
        public Nullable<bool> Activo { get; set; }
    
        public virtual ICollection<Usuarios> Usuarios { get; set; }
        public virtual ICollection<Ventas> Ventas { get; set; }
    }
}
