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
    public partial class aguardando_pagamento : System.Web.UI.Page
    {
        core _core = new core();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CotacaoFornecedorListaModel> PegaCotacoes()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cotacoes = _core.CotacaoFornecedorListaStatusGet(login.IdFornecedor, StatusCotacao.AguardandoPagamento);
            List<CotacaoFornecedorListaModel> lista = new List<CotacaoFornecedorListaModel>();
            foreach (var item in cotacoes)
            {
                bool adciona = true;
                if (item.Status == StatusCotacao.Aberto)
                {
                    item.Status = "Aberto";
                }
                else if (item.Status == StatusCotacao.EmAndamento)
                {
                    if (item.CFId != item.IdFornecedorDB)
                    {
                        adciona = false;
                    }
                    item.Status = "Em andamento";

                    if (item.FinalizaCliente == 0 && item.FinalizaFornecedor == 1)
                    {
                        item.Status = "Pendente de finalização do cliente";
                    }
                }
                else if (item.Status == StatusCotacao.AguardandoPagamento)
                {
                    if (item.CFId != item.IdFornecedorDB)
                    {
                        adciona = false;
                    }
                    item.Status = "Aguardando pagamento";
                }
                else if (item.Status == StatusCotacao.Finalizado)
                {
                    if (item.CFId != item.IdFornecedorDB)
                    {
                        adciona = false;
                    }
                    item.Status = "Finalizado";
                }
                if (adciona)
                {
                    lista.Add(item);
                }
            }
            return lista;
        }
    }
}