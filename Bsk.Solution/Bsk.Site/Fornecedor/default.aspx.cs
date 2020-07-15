using Bsk.BE;
using Bsk.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    public partial class _default : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEntrar_ServerClick(object sender, EventArgs e)
        {
            if ((!String.IsNullOrEmpty(login.Value)) && (!String.IsNullOrEmpty(senha.Value)))
            {
                var _login = _core.Fornecedor_Get(_FornecedorBE, $" Email='{login.Value.ToString()}'").FirstOrDefault();

                if (_login != null)
                {
                    if (_login.Senha == senha.Value)
                    {
                        //Cria a estancia do obj HttpCookie passando o nome do mesmo
                        HttpCookie login = new HttpCookie("loginFornecedor");
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

                        Response.Redirect("minhas-cotacoes.aspx");
                    }
                    else
                    {
                        msg.Text = "Login ou senha, inválidos.";
                    }
                }

            }
        }
    }
}