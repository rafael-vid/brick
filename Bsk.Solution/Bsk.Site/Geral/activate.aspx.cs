using Bsk.BE;
using Bsk.Interface;
using Bsk.Site.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Geral
{
    public partial class activate : System.Web.UI.Page
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
            if(senha.Text == repsenha.Text)
            {
                if (Request.QueryString["type"] == "cli")
                {
                    _core.AtualizarSenhaCliente(Request.QueryString["token"], senha.Text);
                }
                else
                {
                    _core.AtualizarSenhaFonecedor(Request.QueryString["token"], senha.Text);              
                }
                lblMsg.Text = "A senha foi alterada com sucesso.";
            }
            else
            {
                lblMsg.Text = "As senhas não conferem.";
            }
        }
    }
}
