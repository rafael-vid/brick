using Bsk.BE;
using Bsk.Interface;
using Bsk.Site.Admin;
using Bsk.Site.Service;
using Bsk.Util;
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
        ParticipanteBE _ParticipanteBE = new ParticipanteBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var emailcookie = Request.Cookies["emailcookie"].Value;

        }
        protected void ResendEmailButton_Click(object sender, EventArgs e)
        {
            var email = Request.Cookies["emailcookie"].Value;
            ParticipanteBE participante = _core.Participante_Get(_ParticipanteBE, "email='" + email + "'").FirstOrDefault();
            string guid = participante.GuidColumn;
            string nome = participante.Nome;
            SendEmailBasedOnType(email, nome, guid);

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
            Label.Text = "Email de confirmação reenviado. Por favor, verifique sua caixa de entrada ou spam.";

        }
    }

}
