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
        CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();

            if (cotacao.Status != Bsk.Util.StatusCotacao.AguardandoPagamento)
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }

            var fornecedor = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdFornecedor).FirstOrDefault();
            nrCotacao.Text = cotacao.IdCotacao.ToString();
            titulo.Text = cotacao.Titulo;
            valor.Text = cotacaoFornecedor.Valor.ToString();
            prestador.Text = fornecedor.NomeFantasia;

        }

        protected void btnLiberar_ServerClick(object sender, EventArgs e)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();

            string titulo = $"pagamento da cotação Nº no valor de {cf.Valor} foi liberado pelo cliente!";
            string link = ConfigurationManager.AppSettings["host"].ToString()+ "Fornecedor/negociar-cotacao.aspx?Id="+cf.IdCotacaoFornecedor;
            string mensagem = $"pagamento da cotação Nº no valor de {cf.Valor} foi liberado pelo cliente! Acesse a plataforma BRIKK para mais detalhes:<br><a>href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
            string imagem = VariaveisGlobais.Logo;
            ClienteBE clienteBE = new ClienteBE();
            var forn = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + cf.IdFornecedor).FirstOrDefault();
            string email = forn.Email;

            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);
            emailTemplate.enviaEmail(html, titulo, email);

            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);

            Response.Redirect("finalizado.aspx");
        }
    }
}