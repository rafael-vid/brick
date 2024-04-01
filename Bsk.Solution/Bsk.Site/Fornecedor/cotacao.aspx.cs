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
        CotacaoBE CotacaoBE = new CotacaoBE();
        CotacaoFornecedorBE CotacaoFornecedorBE = new CotacaoFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacao = _core.Cotacao_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();
            titulo.InnerText = cotacao.Titulo;
            descricao.InnerText = cotacao.Descricao;
            nrCotacao.InnerText = cotacao.IdCotacao.ToString();

            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cf = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, $" IdCotacao={Request.QueryString["Cotacao"]} and IdFornecedor={login.IdFornecedor}").FirstOrDefault();
            if (cf != null)
            {
                btnAdicionar.Visible = false;
            }

        }

        public List<CotacaoAnexosBE> PegaAnexo()
        {
            return _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdCotacao=" + Request.QueryString["Cotacao"]);
        }

        protected void btnAdicionar_ServerClick(object sender, EventArgs e)
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);

            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE()
            {
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                IdCotacao = int.Parse(Request.QueryString["Cotacao"]),
                IdFornecedor = login.IdFornecedor,
                Valor = 0,
                DataEntrega = "",
                Ativo = 1,
                Novo = 1
            };

            var id = _core.CotacaoFornecedor_Insert(cotacaoFornecedorBE);
            CotacaoBE _CotacaoBE = new CotacaoBE();
            var cotacao2 = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cotacaoFornecedorBE.IdCotacao).FirstOrDefault();

            NotificacaoBE notif = new NotificacaoBE();

            notif.titulo = "Interesse";
            notif.mensagem = "Um novo fornecedor está interessado em sua cotação";
            notif.data = DateTime.Now;
            notif.link = $"cotacao-lista.aspx?Id={cotacaoFornecedorBE.IdCotacao}";
            notif.visualizado = "0";
            notif.idcliente = cotacao2.IdCliente;

            _core.NotificacaoInsert(notif);


            Response.Redirect("negociar-cotacao.aspx?Id=" + id);
        }
    }
}