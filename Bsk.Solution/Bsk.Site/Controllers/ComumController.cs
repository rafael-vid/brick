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



namespace Bsk.Site.Controllers
{
    using Bsk.Util;
    using Bsk.Interface.Helpers;
    public class ComumController : Controller
    {
       
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        public ActionResult Index()
        {
            Response.Redirect("Fornecedor/cadastro.aspx");

            return View();
        }

        [HttpGet]
        public JsonResult PegaTeste()
        {
            return this.Json(new { Result = "Não foi possível inserir o usuário" }, JsonRequestBehavior.AllowGet);
        }




    }
}