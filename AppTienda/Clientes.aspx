<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Clientes.aspx.cs" Inherits="AppTienda.Clientes1" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Clientes</h2>
        
        <!-- Panel de Listado -->
        <asp:Panel ID="pnlListado" runat="server">
            <div class="d-flex justify-content-between mb-3">
                <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Cliente" 
                    CssClass="btn btn-primary" OnClick="btnNuevo_Click" />
                <div>
                    <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control" 
                        placeholder="Buscar cliente..." AutoPostBack="true" OnTextChanged="txtBuscar_TextChanged"></asp:TextBox>
                </div>
            </div>
            
            <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False"
                CssClass="table table-striped table-bordered" DataKeyNames="ClienteID"
                OnRowCommand="gvClientes_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ClienteID" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:TemplateField HeaderText="Frecuente">
                        <ItemTemplate>
                            <asp:Label runat="server" CssClass='<%# (bool)Eval("EsFrecuente") ? "frequent-badge" : "" %>'
                                Text='<%# (bool)Eval("EsFrecuente") ? "Sí" : "No" %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="action-buttons">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Editar" 
                                CommandArgument='<%# Eval("ClienteID") %>'
                                CssClass="btn btn-sm btn-warning" Text="Editar" />
                            <asp:LinkButton runat="server" CommandName="Eliminar" 
                                CommandArgument='<%# Eval("ClienteID") %>'
                                CssClass="btn btn-sm btn-danger" Text="Eliminar" 
                                OnClientClick="return confirm('¿Está seguro de eliminar este cliente?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        
        <!-- Panel de Formulario -->
        <asp:Panel ID="pnlFormulario" runat="server" Visible="false">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <asp:Label ID="lblTituloForm" runat="server" Text="Nuevo Cliente"></asp:Label>
                </div>
                <div class="card-body">
                    <asp:HiddenField ID="hdnClienteID" runat="server" />
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Nombre</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Apellido</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
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
                        <label class="col-sm-2 col-form-label">Email</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Cliente Frecuente</label>
                        <div class="col-sm-10">
                            <div class="form-check">
                                <asp:CheckBox ID="chkEsFrecuente" runat="server" CssClass="form-check-input" />
                                <label class="form-check-label" for="chkEsFrecuente">Marcar como cliente frecuente</label>
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