using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Bsk.Site.Controllers
{
    using Bsk.Util;
    using Bsk.Interface.Helpers;
    using Bsk.Interface;
    using Bsk.BE;

    public class FornecedorController : Controller
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();

        [HttpPost]
        public JsonResult CadastroFornecedor(FornecedorBE _fornecedor)
        {

            _fornecedor.Telefone = "";

            try
            {
                _core.Fornecedor_Insert(_fornecedor);

                return this.Json(new { Result = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                return this.Json(new { Result = "ERRO" }, JsonRequestBehavior.AllowGet);
            }
            
        }
    }
}