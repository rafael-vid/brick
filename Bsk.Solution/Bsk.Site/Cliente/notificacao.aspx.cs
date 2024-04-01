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
    public partial class notificacao : System.Web.UI.Page
    {
        core _core = new core();
        NotificacaoBE _NotificacaoBE = new NotificacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            String param = Request.QueryString["id"];
            _core.NotificacaoUpdate(Convert.ToInt32(param));
            Response.Redirect(Request.QueryString["link"]);
        }

    }
}