using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppTienda
{
    public partial class Ventas : System.Web.UI.Page
    {
        protected List<DetalleVenta> DetalleActual = new List<DetalleVenta>();
        protected const string SessionKeyDetalle = "DetalleVentaActual";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFechaVenta.Text = DateTime.Now.ToString("yyyy-MM-dd");
                CargarClientes();
                CargarProductos();
                InicializarDetalleVenta();
            }
            else
            {
                // Recuperar el detalle de venta de la sesión
                DetalleActual = Session[SessionKeyDetalle] as List<DetalleVenta> ?? new List<DetalleVenta>();
            }
        }

        private void CargarClientes()
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                var clientes = db.Clientes.OrderBy(c => c.Nombre).ToList();
                ddlClientes.DataSource = clientes;
                ddlClientes.DataTextField = "Nombre";
                ddlClientes.DataValueField = "ClienteID";
                ddlClientes.DataBind();
                ddlClientes.Items.Insert(0, new ListItem("Cliente General", "0"));
            }
        }

        private void CargarProductos(string filtro = "")
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                IQueryable<Productos> query = db.Productos.Where(p => p.Activo == true);

                if (!string.IsNullOrEmpty(filtro))
                {
                    query = query.Where(p => p.Nombre.Contains(filtro) || p.Descripcion.Contains(filtro));
                }

                rptProductos.DataSource = query.ToList();
                rptProductos.DataBind();
            }
        }

        private void InicializarDetalleVenta()
        {
            DetalleActual = new List<DetalleVenta>();
            Session[SessionKeyDetalle] = DetalleActual;
            ActualizarGridDetalle();
        }

        protected void txtBuscarProducto_TextChanged(object sender, EventArgs e)
        {
            CargarProductos(txtBuscarProducto.Text.Trim());
        }

        protected void rptProductos_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Agregar")
            {
                int productoID = Convert.ToInt32(e.CommandArgument);
                TextBox txtCantidad = (TextBox)e.Item.FindControl("txtCantidad");
                int cantidad = string.IsNullOrEmpty(txtCantidad.Text) ? 1 : Convert.ToInt32(txtCantidad.Text);

                using (var db = new AbarrotesSaritaEntities())
                {
                    var producto = db.Productos.Find(productoID);
                    if (producto != null)
                    {
                        AgregarProductoADetalle(producto, cantidad);
                    }
                }
            }
        }

        private void AgregarProductoADetalle(Productos producto, int cantidad)
        {
            var itemExistente = DetalleActual.FirstOrDefault(d => d.ProductoID == producto.ProductoID);

            if (itemExistente != null)
            {
                // Actualizar cantidad si el producto ya está en el detalle
                itemExistente.Cantidad += cantidad;
            }
            else
            {
                // Agregar nuevo item al detalle
                DetalleActual.Add(new DetalleVenta
                {
                    ProductoID = producto.ProductoID,
                    Nombre = producto.Nombre,
                    PrecioUnitario = producto.PrecioVenta,
                    Cantidad = cantidad,
                    SubTotal = producto.PrecioVenta * cantidad
                });
            }

            Session[SessionKeyDetalle] = DetalleActual;
            ActualizarGridDetalle();
        }

        protected void gvDetalleVenta_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int productoID = Convert.ToInt32(e.CommandArgument);
                var itemAEliminar = DetalleActual.FirstOrDefault(d => d.ProductoID == productoID);

                if (itemAEliminar != null)
                {
                    DetalleActual.Remove(itemAEliminar);
                    Session[SessionKeyDetalle] = DetalleActual;
                    ActualizarGridDetalle();
                }
            }
        }

        protected void txtCantidadItem_TextChanged(object sender, EventArgs e)
        {
            GridViewRow row = ((TextBox)sender).NamingContainer as GridViewRow;
            TextBox txtCantidad = (TextBox)row.FindControl("txtCantidadItem");
            int productoID = Convert.ToInt32(gvDetalleVenta.DataKeys[row.RowIndex].Value);
            int nuevaCantidad = string.IsNullOrEmpty(txtCantidad.Text) ? 1 : Convert.ToInt32(txtCantidad.Text);

            var item = DetalleActual.FirstOrDefault(d => d.ProductoID == productoID);
            if (item != null)
            {
                item.Cantidad = nuevaCantidad;
                item.SubTotal = item.PrecioUnitario * nuevaCantidad;
                Session[SessionKeyDetalle] = DetalleActual;
                ActualizarGridDetalle();
            }
        }

        protected void btnAplicarDescuento_Click(object sender, EventArgs e)
        {
            if (decimal.TryParse(txtDescuento.Text, out decimal porcentajeDescuento))
            {
                // Aquí puedes implementar la lógica de descuento si es necesario
                // Por ahora solo actualizamos el total
                ActualizarGridDetalle();
            }
        }

        private void ActualizarGridDetalle()
        {
            gvDetalleVenta.DataSource = DetalleActual;
            gvDetalleVenta.DataBind();
            CalcularTotal();
        }

        private void CalcularTotal()
        {
            decimal subtotal = DetalleActual.Sum(d => d.SubTotal);
            decimal descuento = 0;

            if (decimal.TryParse(txtDescuento.Text, out decimal porcentajeDescuento))
            {
                descuento = subtotal * (porcentajeDescuento / 100);
            }

            decimal total = subtotal - descuento;
            lblTotal.Text = total.ToString("C");
        }

        protected void btnFinalizarVenta_Click(object sender, EventArgs e)
        {
            if (DetalleActual.Count == 0)
            {
                MostrarMensaje("Error", "No hay productos en la venta");
                return;
            }

            using (var db = new AbarrotesSaritaEntities())
            {
                try
                {
                    // Crear la venta
                    var venta = new Ventas
                    {
                        FechaVenta = DateTime.Now,
                        ClienteID = Convert.ToInt32(ddlClientes.SelectedValue),
                        SubTotal = DetalleActual.Sum(d => d.SubTotal),
                        Descuento = decimal.TryParse(txtDescuento.Text, out decimal descuento) ? descuento : 0,
                        Total = DetalleActual.Sum(d => d.SubTotal) * (1 - (descuento / 100)),
                        Estado = "COMPLETADA",
                        MetodoPago = "EFECTIVO" // Puedes cambiar esto según tu lógica
                    };

                    db.Ventas.Add(venta);
                    db.SaveChanges();

                    // Agregar los detalles de venta
                    foreach (var detalle in DetalleActual)
                    {
                        db.DetalleVentas.Add(new DetalleVentas
                        {
                            VentaID = venta.VentaID,
                            ProductoID = detalle.ProductoID,
                            Cantidad = detalle.Cantidad,
                            PrecioUnitario = detalle.PrecioUnitario,
                            Descuento = 0, // Puedes implementar descuentos por producto si es necesario
                            SubTotal = detalle.SubTotal
                        });

                        // Actualizar el stock del producto
                        var producto = db.Productos.Find(detalle.ProductoID);
                        if (producto != null)
                        {
                            // Aquí deberías tener un campo para el stock disponible
                            // producto.Stock -= detalle.Cantidad;
                        }
                    }

                    db.SaveChanges();
                    MostrarMensaje("Éxito", "Venta registrada correctamente");
                    InicializarDetalleVenta();
                }
                catch (Exception ex)
                {
                    MostrarMensaje("Error", "Ocurrió un error al registrar la venta: " + ex.Message);
                }
            }
        }

        protected void btnCancelarVenta_Click(object sender, EventArgs e)
        {
            InicializarDetalleVenta();
            txtDescuento.Text = "0";
        }

        private void MostrarMensaje(string titulo, string mensaje)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                $"alert('{titulo}: {mensaje}');", true);
        }
    }

    public class DetalleVenta
    {
        public int ProductoID { get; set; }
        public string Nombre { get; set; }
        public decimal PrecioUnitario { get; set; }
        public int Cantidad { get; set; }
        public decimal SubTotal { get; set; }
    }
}