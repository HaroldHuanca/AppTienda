<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Proveedores.aspx.cs" Inherits="AppTienda.Proveedores1" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2>Gestión de Proveedores</h2>
        
        <!-- Panel de Listado -->
        <asp:Panel ID="pnlListado" runat="server">
            <asp:Button ID="btnNuevo" runat="server" Text="Nuevo Proveedor" 
                CssClass="btn btn-primary mb-3" OnClick="btnNuevo_Click" />
            
            <asp:GridView ID="gvProveedores" runat="server" AutoGenerateColumns="False"
                CssClass="table table-striped table-bordered" DataKeyNames="ProveedorID"
                OnRowCommand="gvProveedores_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ProveedorID" HeaderText="ID" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="Contacto" HeaderText="Contacto" />
                    <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                    <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="action-buttons">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="Editar" 
                                CommandArgument='<%# Eval("ProveedorID") %>'
                                CssClass="btn btn-sm btn-warning" Text="Editar" />
                            <asp:LinkButton runat="server" CommandName="Eliminar" 
                                CommandArgument='<%# Eval("ProveedorID") %>'
                                CssClass="btn btn-sm btn-danger" Text="Eliminar" 
                                OnClientClick="return confirm('¿Está seguro de eliminar este proveedor?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        
        <!-- Panel de Formulario -->
        <asp:Panel ID="pnlFormulario" runat="server" Visible="false">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <asp:Label ID="lblTituloForm" runat="server" Text="Nuevo Proveedor"></asp:Label>
                </div>
                <div class="card-body">
                    <asp:HiddenField ID="hdnProveedorID" runat="server" />
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Nombre</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="form-group row mb-3">
                        <label class="col-sm-2 col-form-label">Contacto</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtContacto" runat="server" CssClass="form-control"></asp:TextBox>
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
                        <label class="col-sm-2 col-form-label">RUC</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtRUC" runat="server" CssClass="form-control"></asp:TextBox>
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