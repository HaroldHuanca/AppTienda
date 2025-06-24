using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AppTienda
{
    public partial class Empleados1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarEmpleados();
                txtFechaContratacion.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        private void CargarEmpleados(string filtro = "")
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                var query = db.Empleados.AsQueryable();

                if (!string.IsNullOrEmpty(filtro))
                {
                    query = query.Where(e =>
                        e.Nombre.Contains(filtro) ||
                        e.Apellido.Contains(filtro) ||
                        e.DNI.Contains(filtro) ||
                        e.Cargo.Contains(filtro));
                }

                gvEmpleados.DataSource = query.OrderBy(e => e.Nombre).ToList();
                gvEmpleados.DataBind();
            }
        }

        protected void btnNuevo_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            lblTituloForm.Text = "Nuevo Empleado";
            pnlListado.Visible = false;
            pnlFormulario.Visible = true;
            txtFechaContratacion.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            using (var db = new AbarrotesSaritaEntities())
            {
                if (string.IsNullOrEmpty(hdnEmpleadoID.Value))
                {
                    // Nuevo empleado
                    var empleado = new Empleados
                    {
                        Nombre = txtNombre.Text,
                        Apellido = txtApellido.Text,
                        DNI = txtDNI.Text,
                        Telefono = txtTelefono.Text,
                        Direccion = txtDireccion.Text,
                        Cargo = ddlCargo.SelectedValue,
                        FechaContratacion = DateTime.Parse(txtFechaContratacion.Text),
                        Salario = decimal.Parse(txtSalario.Text),
                        Activo = chkActivo.Checked
                    };
                    db.Empleados.Add(empleado);
                }
                else
                {
                    // Editar empleado
                    int id = Convert.ToInt32(hdnEmpleadoID.Value);
                    var empleado = db.Empleados.Find(id);
                    if (empleado != null)
                    {
                        empleado.Nombre = txtNombre.Text;
                        empleado.Apellido = txtApellido.Text;
                        empleado.DNI = txtDNI.Text;
                        empleado.Telefono = txtTelefono.Text;
                        empleado.Direccion = txtDireccion.Text;
                        empleado.Cargo = ddlCargo.SelectedValue;
                        empleado.FechaContratacion = DateTime.Parse(txtFechaContratacion.Text);
                        empleado.Salario = decimal.Parse(txtSalario.Text);
                        empleado.Activo = chkActivo.Checked;
                    }
                }
                db.SaveChanges();
            }

            MostrarListado();
            CargarEmpleados();
        }

        protected void gvEmpleados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            using (var db = new AbarrotesSaritaEntities())
            {
                if (e.CommandName == "Editar")
                {
                    var empleado = db.Empleados.Find(id);
                    if (empleado != null)
                    {
                        hdnEmpleadoID.Value = empleado.EmpleadoID.ToString();
                        txtNombre.Text = empleado.Nombre;
                        txtApellido.Text = empleado.Apellido;
                        txtDNI.Text = empleado.DNI;
                        txtTelefono.Text = empleado.Telefono;
                        txtDireccion.Text = empleado.Direccion;
                        ddlCargo.SelectedValue = empleado.Cargo;
                        txtFechaContratacion.Text = empleado.FechaContratacion?.ToString("yyyy-MM-dd") ?? DateTime.Now.ToString("yyyy-MM-dd"); ;
                        txtSalario.Text = empleado.Salario?.ToString("0.00") ?? "0.00";
                        chkActivo.Checked = (bool)empleado.Activo;

                        lblTituloForm.Text = "Editar Empleado";
                        pnlListado.Visible = false;
                        pnlFormulario.Visible = true;
                    }
                }
                else if (e.CommandName == "Eliminar")
                {
                    var empleado = db.Empleados.Find(id);
                    if (empleado != null)
                    {
                        db.Empleados.Remove(empleado);
                        db.SaveChanges();
                        CargarEmpleados();
                    }
                }
                else if (e.CommandName == "ToggleEstado")
                {
                    var empleado = db.Empleados.Find(id);
                    if (empleado != null)
                    {
                        empleado.Activo = !empleado.Activo;
                        db.SaveChanges();
                        CargarEmpleados();
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
            CargarEmpleados(txtBuscar.Text.Trim());
        }

        private void MostrarListado()
        {
            pnlListado.Visible = true;
            pnlFormulario.Visible = false;
            txtBuscar.Text = "";
        }

        private void LimpiarFormulario()
        {
            hdnEmpleadoID.Value = "";
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtDNI.Text = "";
            txtTelefono.Text = "";
            txtDireccion.Text = "";
            ddlCargo.SelectedIndex = 0;
            txtFechaContratacion.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtSalario.Text = "";
            chkActivo.Checked = true;
        }
    }
}