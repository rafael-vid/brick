using Bsk.BE;
using Bsk.Interface;
using Bsk.Interface.Helpers;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class pagamento : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        TransacaoBE _TransacaoBE = new TransacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();

            var transacao = _core.Transacao_Get(_TransacaoBE, " Status=1 AND IdCotacao=" + cotacao.IdCotacao).FirstOrDefault();

            if (transacao != null)
            {
                divPagamento.Visible = false;
                BskPag bskPag = new BskPag();
                var recibo = bskPag.RenderizaRecibo(transacao.IdExterno);
                WebClient cl = new WebClient();
                try
                {
                    ltRecibo.Text = cl.DownloadString(recibo.ToString());
                }
                catch (Exception)
                {
                    Response.Redirect("minhas-cotacoes.aspx");
                }

            }
            else
            {
                var tran = _core.Transacao_Get(_TransacaoBE, " Status=2 AND IdCotacao=" + cotacao.IdCotacao);

                if (tran.Count > 0)
                {
                    divPagamento.Visible = false;
                    WebClient cl = new WebClient();
                    ltBoleto.Text = cl.DownloadString(tran.LastOrDefault().Url);
                }
            }

            var fornecedor = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdFornecedor).FirstOrDefault();
            nrCotacao.Text = cotacao.IdCotacao.ToString();
            titulo.Text = cotacao.Titulo;
            valor.Text = cotacaoFornecedor.Valor.ToString();
            fornecedorNome.InnerText = fornecedor.NomeFantasia;

        }

        protected void btnBoleto_ServerClick(object sender, EventArgs e)
        {

            //pagaCotacao();
        }

        private void pagaCotacao()
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();
            cotacao.Status = StatusCotacao.EmAndamento;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cotacao.IdCotacao);
            var fornecedor = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdFornecedor).FirstOrDefault();

            string titulo = $"A cotação Nº {cotacao.IdCotacao}, teve seu status alterado para pago.";
            string mensagem = $"A cotação Nº {cotacao.IdCotacao}, foi liberada para iniciar. Acesse a plataforma BRIKK para mais detalhes.";
            string imagem = "http://studiobrasuka.com.br/logoBrik.png";
            string email = "";
            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);

            if (String.IsNullOrEmpty(fornecedor.Email))
            {
                email = "harrymangiapelo@gmail.com";
            }
            else
            {
                email = fornecedor.Email;
            }
            emailTemplate.enviaEmail(html, titulo, email);

            Response.Redirect("em-andamento.aspx");
        }

        protected void btnCartao_ServerClick(object sender, EventArgs e)
        {

        }
    }
}