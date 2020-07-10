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
    public partial class finalizado : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CotacaoBE> PegaCotacaoFinalizado()
        {
            var cotacoes = _core.Cotacao_Get(_CotacaoBE, $"Status='{StatusCotacao.Finalizado}'");
            foreach (var item in cotacoes)
            {
                item.Status = "Finalizado";
            }
            return cotacoes;            
        }
    }
}