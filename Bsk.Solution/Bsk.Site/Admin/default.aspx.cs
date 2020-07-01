using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Configuration;
using Bsk.BE;
using Bsk.Interface;

namespace Bsk.Site.Admin
{
    public partial class _default : System.Web.UI.Page
    {
        core _core = new core();
        AdminBE _AdminBE = new AdminBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_ServerClick(object sender, EventArgs e)
        {
            var admin = _core.Admin_Get(_AdminBE, $" Login='{login.Value}' ").FirstOrDefault();

            if(admin != null)
            {
                if (admin.Senha == senha.Value)
                {
                    admin.Senha = "xxxxx";
                    Session["Usuario"] = admin;
                    Response.Redirect("lista-proposta.aspx");
                }
                else
                {
                    msg.Text = "Login ou senha incorretos";
                }
            }
            else
            {
                msg.Text = "Login ou senha incorretos";
            }

        }
    }
}