using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    public partial class cadastra_atuacao : System.Web.UI.Page
    {
        core _core = new core();
        AreaFornecedorBE AreaFornecedorBE = new AreaFornecedorBE();
        ServicoBE ServicoBE = new ServicoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Del"]!=null)
            {
                FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
                var cat = _core.AreaFornecedor_Get(AreaFornecedorBE, $"IdCategoria={Request.QueryString["Id"]} AND IdFornecedor={login.IdFornecedor} ").FirstOrDefault();
                cat.IdServico = cat.IdServico.Replace($"{Request.QueryString["Del"]},","");
                _core.AreaFornecedor_Update(cat, "IdAreaFornecedor="+cat.IdAreaFornecedor);

                Response.Redirect("cadastra-atuacao.aspx?Id="+ Request.QueryString["Id"]);
            }

        }

        public List<Bsk.BE.ServicoBE> PegaServico()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cat = _core.AreaFornecedor_Get(AreaFornecedorBE,$"IdCategoria={Request.QueryString["Id"]} AND IdFornecedor={login.IdFornecedor} ").FirstOrDefault();
            var servicos = _core.Servico_Get(ServicoBE,$"IdServico in ({cat.IdServico}0)");

            return servicos;
        }
    }
}