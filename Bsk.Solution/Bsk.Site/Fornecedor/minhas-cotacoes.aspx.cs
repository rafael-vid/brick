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

            lista = _core.CotacaoListaFronecedorGet(cats + "0", login.IdFornecedor.ToString());
            
        }
        public List<Dashboard> GetDashboardCliente()
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            var cotCliente = _core.GetDashboardCliente($" s.id in (1,2,3)");

            return cotCliente;
        }
        public List<CotacaoFornecedorListaModel> PegaCotacoes()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            AreaFornecedorBE areaFornecedorBE = new AreaFornecedorBE();
            var categorias = _core.AreaFornecedor_Get(areaFornecedorBE, "IdFornecedor=" + login.IdFornecedor);
            string cats = "";
            foreach (var item in categorias)
            {
                cats += item.IdCategoria + ",";
            }


            var cotacoes = _core.CotacaoFornecedorListaGet(cats+"0", login.IdFornecedor);
            List<CotacaoFornecedorListaModel> lista = new List<CotacaoFornecedorListaModel>();
            double total = 0;
            foreach (var item in cotacoes)
            {
                if (!String.IsNullOrEmpty(item.DataEntrega))
                {

                }
                /*
                if (item.Status == StatusCotacao.Aberto || item.Status == StatusCotacao.Criacao)
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
                        total += item.Valor;
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
                        total += item.Valor;
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
                        total += item.Valor;
                        item.Status = "Finalizado";
                    }
                }*/

            }
            totalReceber.InnerText = string.Format("{0:C}", total);
            return cotacoes;
        }
    }
}