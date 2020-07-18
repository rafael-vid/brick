using Bsk.BE;
using Bsk.BE.Model;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class avaliar : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
      
        public ClienteBE RetornaUsuario()
        {
            if (Request.Cookies["Login"].Value != null)
            {
                return Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            }
            else
            {
                Response.Redirect("default.aspx");
                return null;
            }
        }

        public CotacaoAvaliacaoModel PegaCotacao()
        {
            CotacaoAvaliacaoModel cotacao = _core.Cotacao_Avaliacao_Get(Request.QueryString["Id"]);
            depoimento.Value = cotacao.Depoimento;
            return cotacao;
        }

        protected void btnDepoimento_ServerClick(object sender, EventArgs e)
        {
            var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            cotacao.Depoimento = depoimento.Value;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + Request.QueryString["Id"]);
            Response.Redirect("finalizado.aspx");
        }
    }
}