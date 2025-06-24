<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ventas.aspx.cs" Inherits="AppTienda.Ventas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Punto de Venta - Abarrotes Sarita</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        .card {
            margin-bottom: 20px;
        }
        .product-card {
            cursor: pointer;
            transition: all 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .quantity-control {
            width: 80px;
        }
        #productosContainer {
            max-height: 500px;
            overflow-y: auto;
        }
        .selected-product {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid mt-3">
            <div class="row">
                <!-- Panel de Búsqueda y Productos -->
                <div class="col-md-5">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5>Buscador de Productos</h5>
                        </div>
                        <div class="card-body">
                            <div class="input-group mb-3">
                                <asp:TextBox ID="txtBuscarProducto" runat="server" CssClass="form-control" 
                                    placeholder="Buscar producto..." AutoPostBack="true" OnTextChanged="txtBuscarProducto_TextChanged"></asp:TextBox>
                                <button class="btn btn-outline-secondary" type="button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                            
                            <div id="productosContainer" class="row row-cols-2 row-cols-md-3 g-4">
                                <asp:Repeater ID="rptProductos" runat="server" OnItemCommand="rptProductos_ItemCommand">
                                    <ItemTemplate>
                                        <div class="col">
                                            <div class="card product-card h-100">
                                                <div class="card-body text-center">
                                                    <h6 class="card-title"><%# Eval("Nombre") %></h6>
                                                    <p class="card-text text-success"><%# Eval("PrecioVenta", "{0:C}") %></p>
                                                    <p class="card-text text-muted small">Stock: <%# Eval("StockMinimo") %></p>
                                                    <asp:HiddenField ID="hfProductoID" runat="server" Value='<%# Eval("ProductoID") %>' />
                                                    <div class="input-group input-group-sm">
                                                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control quantity-control" 
                                                            TextMode="Number" Text="1" min="1" step="1"></asp:TextBox>
                                                        <asp:LinkButton ID="btnAgregar" runat="server" CommandName="Agregar" 
                                                            CssClass="btn btn-sm btn-success" Text="+" CommandArgument='<%# Eval("ProductoID") %>' />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Panel de Venta Actual -->
                <div class="col-md-7">
                    <div class="card">
                        <div class="card-header bg-success text-white">
                            <h5>Venta en Proceso</h5>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Cliente</label>
                                    <asp:DropDownList ID="ddlClientes" runat="server" CssClass="form-select">
                                        <asp:ListItem Text="Cliente General" Value="0" Selected="True" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Fecha</label>
                                    <asp:TextBox ID="txtFechaVenta" runat="server" CssClass="form-control" 
                                        TextMode="Date" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            
                            <div class="table-responsive">
                                <asp:GridView ID="gvDetalleVenta" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-sm" ShowFooter="True" OnRowCommand="gvDetalleVenta_RowCommand">
                                    <Columns>
                                        <asp:BoundField DataField="ProductoID" HeaderText="ID" Visible="false" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Producto" />
                                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio" DataFormatString="{0:C}" />
                                        <asp:TemplateField HeaderText="Cantidad">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCantidadItem" runat="server" Text='<%# Eval("Cantidad") %>'
                                                    CssClass="form-control form-control-sm" TextMode="Number" min="1" 
                                                    AutoPostBack="true" OnTextChanged="txtCantidadItem_TextChanged" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="SubTotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnEliminarItem" runat="server" CommandName="Eliminar"
                                                    CommandArgument='<%# Eval("ProductoID") %>' CssClass="btn btn-sm btn-danger"
                                                    Text="X" ToolTip="Eliminar producto" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#f8f9fa" Font-Bold="True" />
                                </asp:GridView>
                            </div>
                            
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <div class="input-group mb-3">
                                        <asp:TextBox ID="txtDescuento" runat="server" CssClass="form-control" 
                                            TextMode="Number" Text="0" min="0" step="0.01"></asp:TextBox>
                                        <span class="input-group-text">%</span>
                                        <asp:Button ID="btnAplicarDescuento" runat="server" Text="Aplicar" 
                                            CssClass="btn btn-outline-secondary" OnClick="btnAplicarDescuento_Click" />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="text-end">
                                        <h5>Total: <asp:Label ID="lblTotal" runat="server" Text="0.00" CssClass="text-success"></asp:Label></h5>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-3">
                                <asp:Button ID="btnCancelarVenta" runat="server" Text="Cancelar Venta" 
                                    CssClass="btn btn-danger me-md-2" OnClick="btnCancelarVenta_Click" />
                                <asp:Button ID="btnFinalizarVenta" runat="server" Text="Finalizar Venta" 
                                    CssClass="btn btn-success" OnClick="btnFinalizarVenta_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    
    <!-- Scripts necesarios -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js"></script>
</body>
</html>