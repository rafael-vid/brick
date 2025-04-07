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
    public partial class login : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        ClienteBE _ClienteBE = new ClienteBE();
        ParticipanteBE _ParticipanteBE = new ParticipanteBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        

        protected void btnCliente_ServerClick(object sender, EventArgs e)
        {
            var _login = _core.Participante_Get(_ParticipanteBE, $" Email='{usuarioCliente.Value.ToString()}'").FirstOrDefault();

            if (_login != null)
            {
                if (_login.Senha == senhaCliente.Value)
                {
                    if (_login.EmailConfirmado == 0)
                    {
                        lblMsg.Text = "Seu email ainda não foi confirmado, deseja reenviar?";
                        btnMensagem.Style["display"] = "inline-block"; // Torna o botão visível
                        btnMensagem.Attributes.Remove("disabled");     // Habilita o botão
                        btnMensagem.Attributes.Remove("tabindex");     // Permite foco e clique
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
                        if (_login.prestaServico == 0) {
                            Response.Redirect("../Cliente/cliente-dashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("../Fornecedor/dashboard.aspx");
                        }
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
        protected void btnReenviar_ServerClick(object sender, EventArgs e)
        {
            var _login = _core.Participante_Get(_ParticipanteBE, $" Email='{usuarioCliente.Value.ToString()}'").FirstOrDefault();
            SendEmailBasedOnType(_login.Email,_login.Nome,_login.GuidColumn);
        }
        private void SendEmailBasedOnType(string email, string nome, string guid)
        {

            string url = "http://44.198.11.245/Geral/confirmacaoemail.aspx?guid=" + guid;
            string htmlContent = @"
                    <table>
                        <tbody>
                        <tr>
                            <td style=""font-family:'Rajdhani Sans','Roboto',Arial,sans-serif;direction:ltr;text-align:center;font-weight:normal;color:#5f6368;word-break:normal;font-size:20px;line-height:32px;padding:36px 0px 0px 3px;"">
                            <div style=""color:#25272b;font-size:16px;line-height:26px;"">Falta pouco! Clique no botão para confirmar o seu email.</div>
                            </td>
                        </tr>
                        <tr>
                            <td style=""text-align:center;"">
                            <div style=""margin-bottom: 10px;""></div>
                            <a class=""m_-3092646683337883856showdesktop"" style=""background-color:#770e18;direction:ltr;border-radius:2px;color:#ffffff;display:inline-block;font-size:16px;line-height:24px;font-weight:400;text-align:center;text-decoration:none;padding:14px 20px 13px 20px;font-family:'Google Sans','Roboto',Arial,sans-serif;letter-spacing:0.75px;font-weight:normal;font-size:14px;line-height:21px;border-radius:4px"" target=""_blank"" href=""{url}"">Confirmar email</a>
                            <div style=""margin-top: 16px;""></div>                                
                            </td>
                        <br/>
                        </tr>
                        </tbody>
                    </table>
                    ".Replace("{url}", url);

            Email.Send(email, new List<string>(), "Email de confirmação BRIKK", htmlContent);
            lblMsg.Text = "Email de confirmação reenviado. Por favor, verifique sua caixa de entrada ou spam.";

        }
    }
}
