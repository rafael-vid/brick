using Bsk.BE;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor.Master
{
    public partial class layout : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public FornecedorBE RetornaUsuario()
        {
            HttpCookie login = Request.Cookies["LoginFornecedor"];
            FornecedorBE usuario = new FornecedorBE();
            if (login != null)
            {
                usuario = Funcoes.PegaLoginFornecedor(login.Value);
                return usuario;
            }
            else
            {
                Response.Redirect("default.aspx");
                return usuario;
            }
        }
    }
}