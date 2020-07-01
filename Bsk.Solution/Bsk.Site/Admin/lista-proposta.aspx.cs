using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Admin
{
    using Bsk.BE;
    using Bsk.Interface;
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class lista_proposta : System.Web.UI.Page
    {
        core _core = new core();
        PropostaBE _PropostaBE = new PropostaBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<PropostaBE> ListarProposta()
        {

           return _core.Proposta_Get(_PropostaBE, " 1=1 order by IdProposta");

        }

        protected void BtnNovo_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("proposta.aspx");
        }
    }
}