using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppTienda
{
    public partial class Clientes1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
            }
        }

        private void CargarClientes(string filtro = "")
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                var query = db.Clientes.AsQueryable();

                if (!string.IsNullOrEmpty(filtro))
                {
                    query = query.Where(c =>
                        c.Nombre.Contains(filtro) ||
                        c.Apellido.Contains(filtro) ||
                        c.Telefono.Contains(filtro));
                }

                gvClientes.DataSource = query.OrderBy(c => c.Nombre).ToList();
                gvClientes.DataBind();
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            lblTituloForm.Text = "Nuevo Cliente";
            pnlListado.Visible = false;
            pnlFormulario.Visible = true;
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                if (string.IsNullOrEmpty(hdnClienteID.Value))
                {
                    // Nuevo cliente
                    var cliente = new Clientes
                    {
                        Nombre = txtNombre.Text,
                        Apellido = txtApellido.Text,
                        Telefono = txtTelefono.Text,
                        Direccion = txtDireccion.Text,
                        Email = txtEmail.Text,
                        EsFrecuente = chkEsFrecuente.Checked,
                        FechaRegistro = DateTime.Now
                    };
                    db.Clientes.Add(cliente);
                }
                else
                {
                    // Editar cliente
                    int id = Convert.ToInt32(hdnClienteID.Value);
                    var cliente = db.Clientes.Find(id);
                    if (cliente != null)
                    {
                        cliente.Nombre = txtNombre.Text;
                        cliente.Apellido = txtApellido.Text;
                        cliente.Telefono = txtTelefono.Text;
                        cliente.Direccion = txtDireccion.Text;
                        cliente.Email = txtEmail.Text;
                        cliente.EsFrecuente = chkEsFrecuente.Checked;
                    }
                }
                db.SaveChanges();
            }

            MostrarListado();
            CargarClientes();
        }

        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Editar")
            {
                using (var db = new AbarrotesSaritaEntities())
                {
                    var cliente = db.Clientes.Find(id);
                    if (cliente != null)
                    {
                        hdnClienteID.Value = cliente.ClienteID.ToString();
                        txtNombre.Text = cliente.Nombre;
                        txtApellido.Text = cliente.Apellido;
                        txtTelefono.Text = cliente.Telefono;
                        txtDireccion.Text = cliente.Direccion;
                        txtEmail.Text = cliente.Email;
                        chkEsFrecuente.Checked = (bool)cliente.EsFrecuente;

                        lblTituloForm.Text = "Editar Cliente";
                        pnlListado.Visible = false;
                        pnlFormulario.Visible = true;
                    }
                }
            }
            else if (e.CommandName == "Eliminar")
            {
                using (var db = new AbarrotesSaritaEntities())
                {
                    var cliente = db.Clientes.Find(id);
                    if (cliente != null)
                    {
                        db.Clientes.Remove(cliente);
                        db.SaveChanges();
                        CargarClientes();
                    }
                }
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            MostrarListado();
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            CargarClientes(txtBuscar.Text.Trim());
        }

        private void MostrarListado()
        {
            pnlListado.Visible = true;
            pnlFormulario.Visible = false;
            txtBuscar.Text = "";
        }

        private void LimpiarFormulario()
        {
            hdnClienteID.Value = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtTelefono.Text = "";
            txtDireccion.Text = "";
            txtEmail.Text = "";
            chkEsFrecuente.Checked = false;
        }
    }
}