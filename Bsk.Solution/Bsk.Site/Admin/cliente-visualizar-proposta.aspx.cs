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
    public partial class cliente_visualizar_proposta : System.Web.UI.Page
    {
        core _core = new core();
        PropostaBE _PropostaBE = new PropostaBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public string HtmlProposta(string CodigoProposta)
        {
            _PropostaBE = _core.Proposta_Get(_PropostaBE, $" CodigoProposta='{CodigoProposta}'").FirstOrDefault();

            if (_PropostaBE == null)
            {
                Response.Redirect("lista-proposta.aspx");
            }

            return _PropostaBE.HTML;
        }
    }
}