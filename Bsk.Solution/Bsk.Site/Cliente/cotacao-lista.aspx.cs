using Bsk.BE.Model;
using Bsk.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class cotacao_lista : System.Web.UI.Page
    {
        core _core = new core();
        protected void Page_Load(object sender, EventArgs e)
        {
            nrCotacao.InnerText = Request.QueryString["Id"];
            Bsk.BE.SolicitacaoBE SolicitacaoBE = new BE.SolicitacaoBE();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + Request.QueryString["Id"]).FirstOrDefault();
            titulo.InnerText = cotacao.Titulo;
            descricao.Text = cotacao.Descricao;
            var lista = _core.CotacaoListaGet(Request.QueryString["Id"]);


            valorMedioCotacoes.InnerText = "R$ 0,00";
            valorMaximoCotacoes.InnerText = "R$ 0,00";
            valorMinimoCotacoes.InnerText = "R$ 0,00";


            if (cotacao.IdCotacao != 0)
            {
                decimal valor = 0;
                decimal valorMax = 0;
                decimal valorMin = 0;
                foreach (var item in lista)
                {
                    valor += item.Valor;
                    if (item.Valor > valorMax)
                    {
                        valorMax = item.Valor;
                    }
                    if (valorMin == 0)
                    {
                        valorMin = item.Valor;
                        if (item.Valor < valorMin)
                        {
                            valorMin = item.Valor;
                        }
                    }

                }
                valor = valor / lista.Count;
                valorMedioCotacoes.InnerText = string.Format("{0:C}", valor);
                valorMaximoCotacoes.InnerText = string.Format("{0:C}", valorMax);
                valorMinimoCotacoes.InnerText = string.Format("{0:C}", valorMin);
            }
            else
            {
                decimal valor = 0;
                decimal valorMax=0;
                decimal valorMin = 0;
                foreach (var item in lista)
                {
                    valor += item.Valor;
                    if(item.Valor > valorMax)
                    {
                        valorMax = item.Valor;
                    }
                    if (valorMin == 0)
                    {
                        valorMin = item.Valor;
                        if (item.Valor < valorMin)
                        {
                            valorMin = item.Valor;
                        }
                    }

                }
                valor = valor / lista.Count;
                valorMedioCotacoes.InnerText = string.Format("{0:C}", valor);
                valorMaximoCotacoes.InnerText = string.Format("{0:C}", valorMax);
                valorMinimoCotacoes.InnerText = string.Format("{0:C}", valorMin);
            }

            if (valorMedioCotacoes.InnerText.ToLower() == "nan")
            {
                valorMedioCotacoes.InnerText = "R$ 0,00";
            }

        }

        public List<CotacaoListaModel> PegaCotacaoLista()
        {
            List<CotacaoListaModel> lista = new List<CotacaoListaModel>();

            lista = _core.CotacaoListaGet(Request.QueryString["Id"]);

            Bsk.BE.SolicitacaoBE SolicitacaoBE = new BE.SolicitacaoBE();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + Request.QueryString["Id"]).FirstOrDefault();
            if (cotacao.IdCotacao != 0)
            {

                List<CotacaoListaModel> listaCT = new List<CotacaoListaModel>();

                foreach (var item in lista)
                {
                    if (item.IdFornecedorDB == cotacao.IdCotacao)
                    {
                        listaCT.Add(item);
                    }
                }
                return listaCT;
            }
            else
            {
                return lista;
            }
        }
    }
}