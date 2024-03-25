using Bsk.BE;
using Bsk.Interface;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Geral
{
    public partial class esqueciasenha : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        List<ClienteBE> _ClienteBE = new List<ClienteBE>();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnParceiroEntrar_ServerClick(object sender, EventArgs e)
        {

        }

        protected void btnCliente_ServerClick(object sender, EventArgs e)
        {

            _ClienteBE = _core.EsqueciASenha("Email = '"+usuarioCliente.Text+"'");
            //Email.Send(usuarioCliente.Text, new List<string>(), "Esqueci minha senha", _ClienteBE[0].Senha);
        }
    }
}
