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
                    var _login = _core.Cliente_Get(_ClienteBE, $" GuidColumn='{guid}'").FirstOrDefault();
                    //Cria a estancia do obj HttpCookie passando o nome do mesmo
                    HttpCookie login = new HttpCookie("login");
                    _login.Senha = "xxx";
                    //Define o valor do cookie
                    login.Value = Newtonsoft.Json.JsonConvert.SerializeObject(_login);

                    //Time para expiração (1min)
                    //DateTime dtNow = DateTime.Now;
                    //TimeSpan tsMinute = new TimeSpan(0, 0, 1, 0);
                    //cookie.Expires = dtNow + tsMinute;
                    //Adiciona o cookie
                    Response.Cookies.Add(login);

                    //Cria o obj cookie e recebe o mesmo pelo obj Request
                    //HttpCookie cookie = Request.Cookies["login"];
                    //Imprime o valor do cookie
                    //Response.Write(cookie.Value.ToString());

                    Response.Redirect("../Cliente/cliente-dashboard.aspx");
                }
                else
                {
                    Label.Text = "No GUID found in URL.";

                }
                
            }
        }
    }
}
