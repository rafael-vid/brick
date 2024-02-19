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
    public partial class notificacoes : System.Web.UI.Page
    {
        core _core = new core();
        NotificacaoBE _NotificacaoBE = new NotificacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<NotificacaoModel> Notificacoes()
        {
            var login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var nofi = _core.NotificacaoGet($" CT.idFornecedor=" + login.IdFornecedor + " ORDER BY idnotificacao DESC");
            

            return nofi;
        }
    }
}