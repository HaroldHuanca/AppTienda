<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Empleados.aspx.cs" Inherits="AppTienda.Empleados1" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Empleados</h2>
        
        <!-- Panel de Listado -->
        <asp:Panel ID="pnlListado" runat="server">
            <div class="d-flex justify-content-between mb-3">
                <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Empleado" 
                    CssClass="btn btn-primary" OnClick="btnNuevo_Click" />
                <div>
                    <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" 
                        placeholder="Buscar empleado..." AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged"></asp:TextBox>
                </div>
            </div>
            
            <asp:GridView ID="gvEmpleados" runat="server" AutoGenerateColumns="False"
                CssClass="table table-striped table-bordered" DataKeyNames="EmpleadoID"
                OnRowCommand="gvEmpleados_RowCommand">
                <Columns>
                    <asp:BoundField DataField="EmpleadoID" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="DNI" HeaderText="DNI" />
                    <asp:BoundField DataField="Cargo" HeaderText="Cargo" />
                    <asp:TemplateField HeaderText="Estado">
                        <ItemTemplate>
                            <asp:Label runat="server" 
                                CssClass='<%# (bool)Eval("Activo") ? "active-badge" : "inactive-badge" %>'
                                Text='<%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="action-buttons">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Editar" 
                                CommandArgument='<%# Eval("EmpleadoID") %>'
                                CssClass="btn btn-sm btn-warning" Text="Editar" />
                            <asp:LinkButton runat="server" CommandName="Eliminar" 
                                CommandArgument='<%# Eval("EmpleadoID") %>'
                                CssClass="btn btn-sm btn-danger" Text="Eliminar" 
                                OnClientClick="return confirm('¿Está seguro de eliminar este empleado?');" />
                            <asp:LinkButton runat="server" CommandName="ToggleEstado" 
                                CommandArgument='<%# Eval("EmpleadoID") %>'
                                CssClass='<%# (bool)Eval("Activo") ? "btn btn-sm btn-secondary" : "btn btn-sm btn-success" %>'
                                Text='<%# (bool)Eval("Activo") ? "Desactivar" : "Activar" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        
        <!-- Panel de Formulario -->
        <asp:Panel ID="pnlFormulario" runat="server" Visible="false">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <asp:Label ID="lblTituloForm" runat="server" Text="Nuevo Empleado"></asp:Label>
                </div>
                <div class="card-body">
                    <asp:HiddenField ID="hdnEmpleadoID" runat="server" />
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Nombre</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Apellido</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">DNI</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Teléfono</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Dirección</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Cargo</label>
                        <div class="col-sm-10">
                            <asp:DropDownList ID="ddlCargo" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Seleccione un cargo" Value="" />
                                <asp:ListItem Text="Cajero" Value="Cajero" />
                                <asp:ListItem Text="Almacenero" Value="Almacenero" />
                                <asp:ListItem Text="Gerente" Value="Gerente" />
                                <asp:ListItem Text="Administrador" Value="Administrador" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Fecha Contratación</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtFechaContratacion" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Salario</label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-text">S/</span>
                                <asp:TextBox ID="txtSalario" runat="server" CssClass="form-control" TextMode="Number" step="0.01"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Estado</label>
                        <div class="col-sm-10">
                            <div class="form-check">
                                <asp:CheckBox ID="chkActivo" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label" for="chkActivo">Activo</label>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <div class="col-sm-10 offset-sm-2">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" 
                                CssClass="btn btn-primary" OnClick="btnGuardar_Click" />
                            <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" 
                                CssClass="btn btn-secondary" OnClick="btnCancelar_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>