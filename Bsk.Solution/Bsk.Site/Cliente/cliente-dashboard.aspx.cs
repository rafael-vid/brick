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
    public partial class cliente_dashboard : System.Web.UI.Page
    {
        
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public List<Dashboard> GetDashboardCliente()
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            var cotCliente = _core.GetDashboardCliente();

            return cotCliente;
        }



        public List<CotacaoListaClienteModel> PegaCotacoes(int statusID)
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            var cotCliente = _core.CotacaoClienteGet($" CT.IdCliente=" + login.IdCliente + " and CT.status = "+statusID+" order by DataAlteracao desc");
           
            return cotCliente;
        }
    }
}