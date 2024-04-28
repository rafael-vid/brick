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
    public partial class loginfornecedor : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        ClienteBE _ClienteBE = new ClienteBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnParceiroEntrar_ServerClick(object sender, EventArgs e)
        {
            if ((!String.IsNullOrEmpty(usuarioParceiro.Value)) && (!String.IsNullOrEmpty(senhaParceiro.Value)))
            {
                var _login = _core.Fornecedor_Get(_FornecedorBE, $" Email='{usuarioParceiro.Value.ToString()}'").FirstOrDefault();

                if (_login != null)
                {
                    if (_login.Senha == senhaParceiro.Value)
                    {
                        if (_login.Confirmado == 0)
                        {
                            msg.Text = "Seu email ainda não foi confirmado";
                            lblMsgParceiro.Text = msg.Text;
                        }
                        else
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

                            Response.Redirect("../Fornecedor/dashboard.aspx");
                        }
                    }
                    else
                    {

                        msg.Text = "Login ou senha inválidos";
                        lblMsgParceiro.Text = msg.Text;
                    }
                }
                else
                {
                    msg.Text = "Login ou senha inválidos";
                    lblMsgParceiro.Text = msg.Text;
                }

            }
        }
    }
}
