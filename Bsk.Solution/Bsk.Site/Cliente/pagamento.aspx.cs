using Bsk.BE;
using Bsk.Interface;
using Bsk.Interface.Helpers;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Configuration;
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
        CotacaoBE _CotacaoBE = new CotacaoBE();
        SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
        ParticipanteBE _ParticipanteBE = new ParticipanteBE();
        TransacaoBE _TransacaoBE = new TransacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();

            var transacao = _core.Transacao_Get(_TransacaoBE, " Status=1 AND IdSolicitacao=" + cotacao.IdSolicitacao).FirstOrDefault();

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
                var tran = _core.Transacao_Get(_TransacaoBE, " Status=2 AND IdSolicitacao=" + cotacao.IdSolicitacao);

                if (tran.Count > 0)
                {
                    divPagamento.Visible = false;
                    WebClient cl = new WebClient();
                    ltBoleto.Text = cl.DownloadString(tran.LastOrDefault().Url);
                }
            }

            var participante = _core.Participante_Get(_ParticipanteBE, "IdParticipante=" + cotacaoFornecedor.IdParticipante).FirstOrDefault();
            nrCotacao.Text = cotacao.IdSolicitacao.ToString();
            tituloServ.InnerText = cotacao.Titulo;
            valorServ.InnerText = string.Format("{0:C}", cotacaoFornecedor.Valor);
            fornecedorNome.InnerText = participante.nomeFantasia;
            descricao.InnerText = cotacao.Descricao;
            try
            {
                dtEntrega.InnerText = DateTime.Parse(cotacao.DataTermino).ToString("dd/MM/yyyy");
            }
            catch (Exception)
            {
                dtEntrega.InnerText = "-";
            }

            nrServico.InnerText = cotacao.IdSolicitacao.ToString();
        }

        protected void btnBoleto_ServerClick(object sender, EventArgs e)
        {

            //pagaCotacao();
        }

        private void pagaCotacao()
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
            cotacao.Status = StatusCotacao.EmAndamento;
            _core.Cotacao_Update(cotacao, "IdSolicitacao=" + cotacao.IdSolicitacao);
            var participante = _core.Participante_Get(_ParticipanteBE, "IdParticipante=" + cotacaoFornecedor.IdParticipante).FirstOrDefault();

            string titulo = $"A cotação Nº {cotacao.IdSolicitacao}, teve seu status alterado para pago.";
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Fornecedor/negociar-cotacao.aspx?Id=" + cotacaoFornecedor.IdCotacao;
            string mensagem = $"A cotação Nº {cotacao.IdSolicitacao}, foi liberada para iniciar. Acesse a plataforma BRIKK para mais detalhes.:<br><a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
            string imagem = VariaveisGlobais.Logo;
            string email = "";
            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);

            if (String.IsNullOrEmpty(participante.Email))
            {
                email = "harrymangiapelo@gmail.com";
            }
            else
            {
                email = participante.Email;
            }
            emailTemplate.enviaEmail(html, titulo, email);

            Response.Redirect("minhas-cotacoes.aspx");
        }

        protected void btnCartao_ServerClick(object sender, EventArgs e)
        {

        }
    }
}