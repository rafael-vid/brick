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
    public partial class login : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        ClienteBE _ClienteBE = new ClienteBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        

        protected void btnCliente_ServerClick(object sender, EventArgs e)
        {
            var _login = _core.Cliente_Get(_ClienteBE, $" Email='{usuarioCliente.Value.ToString()}'").FirstOrDefault();

            if (_login != null)
            {
                if (_login.Senha == senhaCliente.Value)
                {
                    if (_login.EmailConfirmado == 0)
                    {
                        string msg = "Seu email ainda não foi confirmado";
                        lblMsg.Text = msg;
                    }
                    else
                    {
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
                    
                }
                else
                {
                    string msg = "Login ou senha inválidos";
                    lblMsg.Text = msg;
                }
            }
            else
            {
                string msg = "Login ou senha inválidos";
                lblMsg.Text = msg;
            }

        }
    }
}
