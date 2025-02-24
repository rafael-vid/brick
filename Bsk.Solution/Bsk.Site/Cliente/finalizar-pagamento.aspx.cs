using Bsk.BE;
using Bsk.Interface;
using Bsk.Interface.Helpers;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class finalizar_pagamento : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();

            if (cotacao.Status != Bsk.Util.StatusCotacao.AguardandoPagamento)
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }

            var fornecedor = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdParticipanteFornecedor).FirstOrDefault();
            nrCotacao.Text = cotacao.IdSolicitacao.ToString();
            titulo.Text = cotacao.Titulo;
            valor.Text = cotacaoFornecedor.Valor.ToString();
            prestador.Text = fornecedor.NomeFantasia;

        }

        protected void btnLiberar_ServerClick(object sender, EventArgs e)
        {
            CotacaoBE CotacaoBE = new CotacaoBE();
            var cf = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            SolicitacaoBE SolicitacaoBE = new SolicitacaoBE();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cf.IdSolicitacao).FirstOrDefault();

            string titulo = $"pagamento da cotação Nº no valor de {cf.Valor} foi liberado pelo cliente!";
            string link = ConfigurationManager.AppSettings["host"].ToString()+ "Fornecedor/negociar-cotacao.aspx?Id="+cf.IdCotacao;
            string mensagem = $"pagamento da cotação Nº no valor de {cf.Valor} foi liberado pelo cliente! Acesse a plataforma BRIKK para mais detalhes:<br><a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
            string imagem = VariaveisGlobais.Logo;
            ClienteBE clienteBE = new ClienteBE();
            var forn = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + cf.IdParticipanteFornecedor).FirstOrDefault();
            string email = forn.Email;

            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);
            emailTemplate.enviaEmail(html, titulo, email);

            _core.Cotacao_Update(cotacao, "IdSolicitacao=" + cf.IdSolicitacao);

            Response.Redirect("minhas-cotacoes.aspx");
        }
    }
}