using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Admin
{

    using Bsk.BE;
    using Bsk.BE.Pag;
    using Bsk.Interface;
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class pagamento_transacao : System.Web.UI.Page
    {
        core _core = new core();
        TransacaoBE _TransacaoBE = new TransacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<TransacaoModel> PegaTransacoes()
        {

            return _core.TransacaoModel_Get("1=1 Order by T.Status");
        }

    }
}