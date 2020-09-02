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
    public partial class minhas_cotacoes : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            AreaFornecedorBE areaFornecedorBE = new AreaFornecedorBE();
            List<CotacaoListaFronecedorModel> lista = new List<CotacaoListaFronecedorModel>();
            var categorias = _core.AreaFornecedor_Get(areaFornecedorBE, "IdFornecedor=" + login.IdFornecedor);
            string cats = "";
            foreach (var item in categorias)
            {
                cats += item.IdCategoria + ",";
            }
            lista = _core.CotacaoListaFronecedorGet(cats + "0");
            if (lista.Count>0)
            {
                temCotacao.InnerText = "N";
            }
            else
            {
                temCotacao.InnerText = "";
            }
        }

        public List<CotacaoFornecedorListaModel> PegaCotacoes()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cotacoes = _core.CotacaoFornecedorListaGet(login.IdFornecedor);
            List<CotacaoFornecedorListaModel> lista = new List<CotacaoFornecedorListaModel>();

            foreach (var item in cotacoes)
            {

                if (item.Status == StatusCotacao.Aberto)
                {
                    item.Status = "Aberto";
                }
                else if (item.Status == StatusCotacao.EmAndamento)
                {
                    if (item.CFId != item.CotacaoFornecedorId)
                    {
                        item.Status = "Recusado";
                    }
                    else
                    {
                        item.Status = "Em andamento";
                    }

                    if (item.FinalizaCliente == 0 && item.FinalizaFornecedor == 1)
                    {
                        item.Status = "Pendente de finalização do cliente";
                    }
                }
                else if (item.Status == StatusCotacao.AguardandoPagamento)
                {
                    if (item.CFId != item.CotacaoFornecedorId)
                    {
                        item.Status = "Recusado";
                    }
                    else
                    {
                        item.Status = "Aguardando pagamento";
                    }

                }
                else if (item.Status == StatusCotacao.Finalizado)
                {
                    if (item.CFId != item.CotacaoFornecedorId)
                    {
                        item.Status = "Recusado";
                    }
                    else
                    {
                        item.Status = "Finalizado";
                    }
                }

            }
            return cotacoes;
        }
    }
}