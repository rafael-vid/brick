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
    public partial class cotacao : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoAnexosBE _CotacaoAnexosBE = new CotacaoAnexosBE();
        SolicitacaoBE SolicitacaoBE = new SolicitacaoBE();
        CotacaoBE CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();
            titulo.InnerText = cotacao.Titulo;
            descricao.InnerText = cotacao.Descricao;
            nrCotacao.InnerText = cotacao.IdSolicitacao.ToString();

            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cf = _core.CotacaoFornecedor_Get(CotacaoBE, $" IdSolicitacao={Request.QueryString["Cotacao"]} and IdParticipanteFornecedor={login.IdParticipante}").FirstOrDefault();
            if (cf != null)
            {
                btnAdicionar.Visible = false;
            }

        }

        public List<CotacaoAnexosBE> PegaAnexo()
        {
            return _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdSolicitacao=" + Request.QueryString["Cotacao"]);
        }

        protected void btnAdicionar_ServerClick(object sender, EventArgs e)
        {
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);

            CotacaoBE CotacaoBE = new CotacaoBE()
            {
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                IdSolicitacao = int.Parse(Request.QueryString["Cotacao"]),
                IdParticipanteFornecedor = login.IdParticipante,
                Valor = 0,
                DataEntrega = "",
                Ativo = 1,
                Novo = 1
            };

            var id = _core.CotacaoFornecedor_Insert(CotacaoBE);
            SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
            var cotacao2 = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + CotacaoBE.IdSolicitacao).FirstOrDefault();

            NotificacaoBE notif = new NotificacaoBE();

            notif.titulo = "Interesse";
            notif.mensagem = "Um novo fornecedor está interessado em sua cotação";
            notif.data = DateTime.Now;
            notif.link = $"cotacao-lista.aspx?Id={CotacaoBE.IdSolicitacao}";
            notif.visualizado = "0";
            notif.idcliente = cotacao2.IdCliente;

            _core.NotificacaoInsert(notif);


            Response.Redirect("negociar-cotacao.aspx?Id=" + id + "&Cotacao=" + Request.QueryString["Cotacao"]);
        }
    }
}