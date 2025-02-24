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
        SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //public ParticipanteBE RetornaUsuario()
        //{
        //    HttpCookie login = Request.Cookies["Login"];
        //    ParticipanteBE usuario = new ParticipanteBE();
        //    if (login != null)
        //    {
        //        usuario = Funcoes.PegaLoginParticipante(login.Value);
        //        return usuario;
        //    }
        //    else
        //    {
        //        Response.Redirect("default.aspx");
        //        return usuario;
        //    }
        //}

        public CotacaoAvaliacaoFornecedorModel PegaCotacao()
        {
            CotacaoAvaliacaoFornecedorModel cotacao = _core.Cotacao_Avaliacao_Fornecedor_Get(Request.QueryString["id"]);
            depoimentoFornecedor.InnerText = cotacao.Observacao;

            if (!String.IsNullOrEmpty(cotacao.Observacao))
            {
                btnDepoimento.Visible = false;
            }
            return cotacao;
        }

        protected void btnDepoimento_ServerClick(object sender, EventArgs e)
        {
            CotacaoBE CotacaoBE = new CotacaoBE();
            var cf = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao="+Request.QueryString["id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + cf.IdSolicitacao).FirstOrDefault();
            cotacao.Observacao = depoimentoFornecedor.InnerText;
            _core.Cotacao_Update(cotacao, "IdSolicitacao=" + cf.IdSolicitacao);
            Response.Redirect("minhas-cotacoes.aspx");
        }
    }
}