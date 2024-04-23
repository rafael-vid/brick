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
    public partial class confirmacaoemail : System.Web.UI.Page
    {
        core _core = new core();
        ClienteBE _ClienteBE = new ClienteBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the GUID from the URL query string.
                string guid = Request.QueryString["guid"];

                if (!string.IsNullOrEmpty(guid))
                {
                    // Use the GUID as needed in your application, for example:
                    var cliente = _core.Cliente_Get(_ClienteBE, "GuidColumn= '" + guid+ "'").FirstOrDefault();
                    cliente.EmailConfirmado = 1;
                    _core.Cliente_Update(cliente, "IdCliente = " + cliente.IdCliente);
                    Label.Text = "Seu email foi confirmado!";
                }
                else
                {
                    Label.Text = "No GUID found in URL.";

                }
            }
        }
    }
}
