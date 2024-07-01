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
    using Bsk.Site.Geral;

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

                var fornecEmail = _core.Fornecedor_Get(_FornecedorBE, $"Email='{_fornecedor.Email}'");
                if (fornecEmail.Count > 0)
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
        [HttpPost]
        public JsonResult AdicionarServico(string service)
        {
            var servicos = service.Split(',');
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            List<ServicoCategoria> lista = new List<ServicoCategoria>();
            foreach (var servico in servicos)
            {
                if (!string.IsNullOrEmpty(servico))
                {
                    lista.Add(new ServicoCategoria()
                    {

                        IdCategoria = int.Parse(servico.Split(';').LastOrDefault()),
                        IdServico = int.Parse(servico.Split(';').FirstOrDefault())
                    });
                }

            }
            var categorias = lista.GroupBy(x => x.IdCategoria);
            _core.ExecFree($"delete from areafornecedor where IdFornecedor = {login.IdParticipante}");
            foreach (var categoria in categorias)
            {
                var servs = lista.Where(x => x.IdCategoria == categoria.Key).ToList();
                
                
                string idservicos = "";
                foreach (var item in servs)
                {
                    idservicos += item.IdServico + ",";
                }
                _core.AreaFornecedor_Insert(new AreaFornecedorBE { IdCategoria = categoria.Key, IdServico = idservicos,IdParticipante=login.IdParticipante });
            }
            return this.Json(new { Msg = "Ok" }, JsonRequestBehavior.AllowGet);
        }
    }
}