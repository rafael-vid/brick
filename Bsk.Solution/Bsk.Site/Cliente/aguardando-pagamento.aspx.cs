using Bsk.BE;
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
    public partial class aguardando_pagamento : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public List<CotacaoBE> PegaCotacaoPagamento()
        {
            var cotacoes = _core.Cotacao_Get(_CotacaoBE, $"Status='{StatusCotacao.AguardandoPagamento}'");
            foreach (var item in cotacoes)
            {
                item.Status = "Aguardando pagamento";
            }
            return cotacoes;
        }
    }
}