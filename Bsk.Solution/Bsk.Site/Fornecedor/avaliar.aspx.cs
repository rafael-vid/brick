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

namespace Bsk.Site.Fornecedor
{
    public partial class avaliar : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public FornecedorBE RetornaUsuario()
        {
            HttpCookie login = Request.Cookies["LoginFornecedor"];
            FornecedorBE usuario = new FornecedorBE();
            if (login != null)
            {
                usuario = Funcoes.PegaLoginFornecedor(login.Value);
                return usuario;
            }
            else
            {
                Response.Redirect("default.aspx");
                return usuario;
            }
        }

        public CotacaoAvaliacaoFornecedorModel PegaCotacao()
        {
            CotacaoAvaliacaoFornecedorModel cotacao = _core.Cotacao_Avaliacao_Fornecedor_Get(Request.QueryString["Id"]);
            depoimentoFornecedor.InnerText = cotacao.Observacao;

            if (!String.IsNullOrEmpty(cotacao.Observacao))
            {
                btnDepoimento.Visible = false;
            }
            return cotacao;
        }

        protected void btnDepoimento_ServerClick(object sender, EventArgs e)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor="+Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            cotacao.Observacao = depoimentoFornecedor.InnerText;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);
            Response.Redirect("minhas-cotacoes.aspx");
        }
    }
}