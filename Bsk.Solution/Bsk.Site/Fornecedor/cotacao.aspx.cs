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
            titulo.Value = cotacao.Titulo;
            descricao.Value = cotacao.Descricao;
            nrCotacao.InnerText = cotacao.IdCotacao.ToString();

            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cf = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, $" IdCotacao={Request.QueryString["Cotacao"]} and IdFornecedor={login.IdFornecedor}").FirstOrDefault();
            if (cf!=null)
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
                Valor =0,
                DataEntrega=""
            };

            var id = _core.CotacaoFornecedor_Insert(cotacaoFornecedorBE);
            Response.Redirect("negociar-cotacao.aspx?Id="+id);
        }
    }
}