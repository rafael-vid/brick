using Bsk.BE;
using Bsk.Interface;
using Bsk.Site.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Geral
{
    public partial class cadastrofeito : System.Web.UI.Page
    {
        core _core = new core();
        ClienteBE _ClienteBE = new ClienteBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ResendEmailButton_Click(object sender, EventArgs e)
        {
            //codigo para reenviar o email
            Label.Text = "Email de ativação reenviado. Por favor, verifique sua caixa de entrada ou spam.";
        }

    }
}
