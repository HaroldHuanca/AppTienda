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
    
    public partial class Inventario
    {
        public int InventarioID { get; set; }
        public Nullable<int> ProductoID { get; set; }
        public int Cantidad { get; set; }
        public string TipoMovimiento { get; set; }
        public Nullable<System.DateTime> FechaMovimiento { get; set; }
        public string Motivo { get; set; }
        public string UsuarioResponsable { get; set; }
    
        public virtual Productos Productos { get; set; }
    }
}
