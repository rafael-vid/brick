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

            try
            {
                var fornecCnpj = _core.Fornecedor_Get(_FornecedorBE, $"Cnpj='{_fornecedor.Cnpj}' or Cnpj='{_fornecedor.Cnpj.Replace(".", "").Replace("-", "").Replace("/", "")}'");
                if (fornecCnpj.Count > 0)
                {
                    return this.Json(new { Msg = "Esse cnpj já foi cadastrado" }, JsonRequestBehavior.AllowGet);
                }

                var fornecEmail = _core.Fornecedor_Get(_FornecedorBE,$"Email='{_fornecedor.Email}'");
                if (fornecEmail.Count>0)
                {
                    return this.Json(new { Msg = "Esse email já foi cadastrado" }, JsonRequestBehavior.AllowGet);
                }
                _core.Fornecedor_Insert(_fornecedor);

                return this.Json(new { Msg = "Ok" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception)
            {

                return this.Json(new { Result = "ERRO" }, JsonRequestBehavior.AllowGet);
            }
            
        }
    }
}