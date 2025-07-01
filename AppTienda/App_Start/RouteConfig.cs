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

            // Redirige la ruta ra�z ("/") a Nosotros.aspx
            routes.MapPageRoute(
                routeName: "Inicio",
                routeUrl: "", // Ruta vac�a = p�gina principal
                physicalFile: "~/About.aspx" // Nueva p�gina de inicio
            );
        }
    }
}

