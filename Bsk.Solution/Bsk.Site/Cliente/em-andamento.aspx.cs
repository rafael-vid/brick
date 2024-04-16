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

namespace Bsk.Site.Cliente
{
    public partial class em_andamento : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<Dashboard> GetDashboardCliente()
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            var cotCliente = _core.GetDashboardCliente($" s.id in (4,5,6)");

            return cotCliente;
        }

        public List<CotacaoBE> PegaCotacaoAndamento()
        {
            var cotacoes = _core.Cotacao_Get(_CotacaoBE, $" Status in (4,5,6)");
            foreach (var item in cotacoes)
            {
                if(item.Status == "4")
                    item.Status = "Em andamento";

                if (item.Status == "5")
                    item.Status = "Aguardando aceite";

                if (item.Status == "6")
                    item.Status = "Aguardando avaliação";
            }
            return cotacoes;
        }
    }
}