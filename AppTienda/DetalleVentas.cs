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
    
    public partial class DetalleVentas
    {
        public int DetalleVentaID { get; set; }
        public Nullable<int> VentaID { get; set; }
        public Nullable<int> ProductoID { get; set; }
        public int Cantidad { get; set; }
        public decimal PrecioUnitario { get; set; }
        public Nullable<decimal> Descuento { get; set; }
        public decimal SubTotal { get; set; }
    
        public virtual Productos Productos { get; set; }
        public virtual Ventas Ventas { get; set; }
    }
}
