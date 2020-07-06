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

    public partial class msg : System.Web.UI.Page
    {
        core _core = new core();
        AlertBE _AlertBE = new AlertBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!String.IsNullOrEmpty(Request.QueryString["Chave"]))
            {
               var alert = _core.Alert_Get(_AlertBE, $" Chave='#{Request.QueryString["Chave"]}'").FirstOrDefault();

                if(alert!=null)
                {
                    titulo.Text = alert.Titulo;
                    mensagem.Text = alert.Conteudo;
                    retorno.Value = alert.Retorno;
                }

            }
        }
    }
}