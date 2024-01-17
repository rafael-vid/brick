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
    public partial class notificacoes : System.Web.UI.Page
    {
        core _core = new core();
        NotificacaoBE _NotificacaoBE = new NotificacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<NotificacaoModel> Notificacoes()
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            var nofi = _core.NotificacaoGet($" CT.idcliente=" + login.IdCliente + " ORDER BY idnotificacao DESC");
            

            return nofi;
        }
    }
}