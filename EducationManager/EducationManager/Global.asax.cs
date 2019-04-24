using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace EducationManager
{
    // 注意: 有关启用 IIS6 或 IIS7 经典模式的说明，
    // 请访问 http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            //默认路由
            routes.MapRoute(
                "Default", // 路由名称
                "{controller}/{action}/{id}", // 带有参数的 URL
                new { controller = "UserInfo", action = "LoginOn", id = UrlParameter.Optional } // 参数默认值
            );
            //新增路由
            routes.MapRoute(
              "", // 路由名称
              "{controller}/{action}/{id}/{cid}", // 带有参数的 URL
              new { controller = "UserInfo", action = "LoginOn", id = UrlParameter.Optional } // 参数默认值
          );

        }

        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            RegisterRoutes(RouteTable.Routes);
        }
    }
}