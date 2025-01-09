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
        SolicitacaoBE _CotacaoBE = new SolicitacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<SolicitacaoBE> PegaCotacaoFinalizado()
        {
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);

            var cotacoes = _core.Cotacao_Get(_CotacaoBE, $"Status='{StatusCotacao.Finalizado}' AND idParticipante=" + login.IdParticipante);
            foreach (var item in cotacoes)
            {
                item.Status = "Finalizado";
            }
            return cotacoes;
        }
    }
}