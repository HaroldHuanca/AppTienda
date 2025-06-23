using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppTienda
{
    public partial class Proveedores1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarProveedores();
            }
        }

        private void CargarProveedores()
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                gvProveedores.DataSource = db.Proveedores.ToList();
                gvProveedores.DataBind();
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            lblTituloForm.Text = "Nuevo Proveedor";
            pnlListado.Visible = false;
            pnlFormulario.Visible = true;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                if (string.IsNullOrEmpty(hdnProveedorID.Value))
                {
                    // Nuevo proveedor
                    var proveedor = new Proveedores
                    {
                        Nombre = txtNombre.Text,
                        Contacto = txtContacto.Text,
                        Telefono = txtTelefono.Text,
                        Direccion = txtDireccion.Text,
                        Email = txtEmail.Text,
                        RUC = txtRUC.Text
                    };
                    db.Proveedores.Add(proveedor);
                }
                else
                {
                    // Editar proveedor
                    int id = Convert.ToInt32(hdnProveedorID.Value);
                    var proveedor = db.Proveedores.Find(id);
                    if (proveedor != null)
                    {
                        proveedor.Nombre = txtNombre.Text;
                        proveedor.Contacto = txtContacto.Text;
                        proveedor.Telefono = txtTelefono.Text;
                        proveedor.Direccion = txtDireccion.Text;
                        proveedor.Email = txtEmail.Text;
                        proveedor.RUC = txtRUC.Text;
                    }
                }
                db.SaveChanges();
            }

            MostrarListado();
            CargarProveedores();
        }

        protected void gvProveedores_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                using (var db = new AbarrotesSaritaEntities())
                {
                    var proveedor = db.Proveedores.Find(id);
                    if (proveedor != null)
                    {
                        hdnProveedorID.Value = proveedor.ProveedorID.ToString();
                        txtNombre.Text = proveedor.Nombre;
                        txtContacto.Text = proveedor.Contacto;
                        txtTelefono.Text = proveedor.Telefono;
                        txtDireccion.Text = proveedor.Direccion;
                        txtEmail.Text = proveedor.Email;
                        txtRUC.Text = proveedor.RUC;

                        lblTituloForm.Text = "Editar Proveedor";
                        pnlListado.Visible = false;
                        pnlFormulario.Visible = true;
                    }
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                using (var db = new AbarrotesSaritaEntities())
                {
                    var proveedor = db.Proveedores.Find(id);
                    if (proveedor != null)
                    {
                        db.Proveedores.Remove(proveedor);
                        db.SaveChanges();
                        CargarProveedores();
                    }
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            MostrarListado();
        }

        private void MostrarListado()
        {
            pnlListado.Visible = true;
            pnlFormulario.Visible = false;
        }

        private void LimpiarFormulario()
        {
            hdnProveedorID.Value = "";
            txtNombre.Text = "";
            txtContacto.Text = "";
            txtTelefono.Text = "";
            txtDireccion.Text = "";
            txtEmail.Text = "";
            txtRUC.Text = "";
        }
    }
}