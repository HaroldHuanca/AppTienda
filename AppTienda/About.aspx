<%@ Page Title="Nosotros" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="AppTienda.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <!-- Cabecera con logo y nombre -->
        <div class="row mb-4">
            <div class="col-md-2">
                <asp:Image ID="imgLogo" runat="server" ImageUrl="~/Images/logo.png" CssClass="img-fluid" AlternateText="Logo Abarrotes Sarita" />
            </div>
            <div class="col-md-10 align-self-center">
                <h1 class="display-4">Abarrotes Sarita</h1>
                <p class="lead">Tu tienda de confianza en Gordon Magne</p>
            </div>
        </div>

        <!-- Misión, Visión y Valores -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header bg-primary text-white">
                        <h4>Misión</h4>
                    </div>
                    <div class="card-body">
                        <p>Ofrecer productos de primera necesidad a precios justos para las familias del barrio, con atención cercana, cordial y personalizada.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header bg-success text-white">
                        <h4>Visión</h4>
                    </div>
                    <div class="card-body">
                        <p>Ser la tienda de abarrotes preferida de la comunidad, reconocida por su trato humano, variedad de productos y mejora continua en el servicio.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header bg-info text-white">
                        <h4>Valores</h4>
                    </div>
                    <div class="card-body">
                        <ul>
                            <li>Honestidad</li>
                            <li>Respeto al cliente</li>
                            <li>Trabajo constante</li>
                            <li>Apoyo a proveedores locales</li>
                            <li>Limpieza y orden</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Descripción General -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">
                        <h4>Descripción General</h4>
                    </div>
                    <div class="card-body">
                        <p><strong>Abarrotes Sarita</strong> es una microempresa dedicada a la venta al por menor de abarrotes y productos alimenticios en comercios especializados. Ubicada en Gordon Magne, la tienda ofrece una amplia variedad de productos de consumo diario, satisfaciendo las necesidades de los clientes con calidad, precios accesibles y un servicio personalizado.</p>
                        <p>Además, la empresa se involucra en otras actividades de servicios personales para complementar su oferta, garantizando una atención integral. Como EIRL, <strong>Abarrotes Sarita</strong> se distingue por su enfoque cercano a la comunidad y compromiso con la satisfacción del cliente.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Galería de Imágenes -->
        <div class="row mb-4">
            <div class="col-12">
                <h3 class="text-center mb-3">Nuestra Tienda</h3>
                <div id="tiendaCarousel" class="carousel slide" data-bs-ride="carousel">
    <!-- Indicadores -->
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#tiendaCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#tiendaCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#tiendaCarousel" data-bs-slide-to="2"></button>
    </div>
    
    <!-- Imágenes -->
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="/Images/tienda1.jpg" class="d-block w-100" alt="Fachada">
        </div>
        <div class="carousel-item">
            <img src="/Images/tienda2.jpg" class="d-block w-100" alt="Interior">
        </div>
        <div class="carousel-item">
            <img src="/Images/tienda3.jpg" class="d-block w-100" alt="Productos">
        </div>
    </div>
    
    <!-- Controles -->
    <button class="carousel-control-prev" type="button" data-bs-target="#tiendaCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#tiendaCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>
            </div>
        </div>

        <!-- Información de Contacto -->
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-warning">
                        <h4>Contacto</h4>
                    </div>
                    <div class="card-body">
                        <p><strong>Dirección:</strong> Gordon Magne, Cusco</p>
                        <p><strong>Teléfono:</strong> (084) 123456</p>
                        <p><strong>Email:</strong> contacto@abarrotessarita.com</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-warning">
                        <h4>Horario de Atención</h4>
                    </div>
                    <div class="card-body">
                        <p><strong>Lunes a Viernes:</strong> 7:00 am - 9:00 pm</p>
                        <p><strong>Sábados:</strong> 7:00 am - 8:00 pm</p>
                        <p><strong>Domingos:</strong> 8:00 am - 2:00 pm</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>