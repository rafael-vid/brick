using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Bsk.BE;
using Bsk.Interface;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO;
using System.Drawing;
using System.Net.Mail;
using System.Configuration;
using System.Net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Text;
using Bsk.Util;
using Bsk.Interface.Helpers;


namespace Bsk.Site.Controllers
{
    public class ComumController : Controller
    {
       
        core _core = new core();
        public ActionResult Index()
        {
            Response.Redirect("Admin/default.aspx");

            return View();
        }

      
    }
}