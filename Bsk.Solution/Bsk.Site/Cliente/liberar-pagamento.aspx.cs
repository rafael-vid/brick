using Bsk.BE.Model;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class liberar_pagamento : System.Web.UI.Page
    {
        core _core = new core();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CotacaoPagamentoModel> PegaCotacaoPagamento()
        {
            List<CotacaoPagamentoModel> cotacaoPagamentoModels = new List<CotacaoPagamentoModel>();
            cotacaoPagamentoModels = _core.CotacaoStatusGet(StatusCotacao.AguardandoPagamento);
            return cotacaoPagamentoModels;
        }
    }
}