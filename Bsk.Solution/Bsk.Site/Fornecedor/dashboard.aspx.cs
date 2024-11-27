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
    public partial class dashboard : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<Dashboard> GetDashboardFornecedor()
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cotCliente = _core.GetDashboardCliente(" s.id <> 8 ");

            return cotCliente;
        }

        public List<CotacaoListaFronecedorModel> PegaCotacoes(int statusID)
        {
            var l = Request.Cookies["login"].Value;
            var login = Funcoes.PegaLoginParticipante(l);
            var cotCliente = _core.CotacaoFornecedorGet($" CF.idParticipanteFornecedor=" + login.IdParticipante + " and CT.status = " + statusID + " AND CF.Ativo=1  order by DataAlteracao desc") ;
            return cotCliente;
        }
        public List<CotacaoListaFronecedorModel> PegaCotacoesEmAndamento()
        {
            var l = Request.Cookies["login"].Value;
            var login = Funcoes.PegaLoginParticipante(l);
            var cotCliente = _core.CotacaoFornecedorGet($" CF.idParticipanteFornecedor=" + login.IdParticipante + " AND CF.Ativo=0 AND Status=3  order by DataAlteracao desc");
            return cotCliente;
        }
    }
}