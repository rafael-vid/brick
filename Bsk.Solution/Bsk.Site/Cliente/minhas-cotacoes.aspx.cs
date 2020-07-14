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
    public partial class minhas_cotacoes : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CotacaoBE> PegaCotacoes()
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            var cotacoes = _core.Cotacao_Get(_CotacaoBE, $" IdCliente="+login.IdCliente);
            foreach (var item in cotacoes)
            {
                if (item.Status == StatusCotacao.Aberto)
                {
                    item.Status = "Aberto";
                }
                else if (item.Status == StatusCotacao.EmAndamento)
                {
                    item.Status = "Em andamento";
                }
                else if (item.Status == StatusCotacao.AguardandoPagamento)
                {
                    item.Status = "Aguardando pagamento";
                }
                else if (item.Status == StatusCotacao.Finalizado)
                {
                    item.Status = "Finalizado";
                }

            }
            return cotacoes;
        }
    }
}