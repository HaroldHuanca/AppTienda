using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace AppTienda
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            // Redirige la ruta raíz ("/") a Nosotros.aspx
            routes.MapPageRoute(
                routeName: "Inicio",
                routeUrl: "", // Ruta vacía = página principal
                physicalFile: "~/About.aspx" // Nueva página de inicio
            );
        }
    }
}

