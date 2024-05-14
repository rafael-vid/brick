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
        ClienteBE _ClienteBE = new ClienteBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var emailcookie = Request.Cookies["emailcookie"].Value;

        }
        protected void ResendEmailButton_Click(object sender, EventArgs e)
        {
            var emailcookie = Request.Cookies["emailcookie"].Value;
            string[] parts = emailcookie.Split(' ');
            if (parts.Length == 2)
            {
                string email = parts[0];
                string tipo = parts[1];
                ClienteBE cliente = _core.Cliente_Get(_ClienteBE, "email='"+email+"'").FirstOrDefault();
                string guid = cliente.GuidColumn;
                string nome = cliente.Nome;
                SendEmailBasedOnType(email, tipo, nome, guid);

            }
            else
            {
                Label.Text = "Erro ao processar os dados do cookie.";
            }
        }
        private void SendEmailBasedOnType(string email, string tipo, string nome, string guid)
        {
            string url = "http://44.198.11.245/Geral/confirmacaoemail.aspx?guid=" + guid;
            switch (tipo)
            {
                case "1":
                    Email.Send(email, new List<string>(), "Email de confirmação BRIKK", "</tbody>\r\n    </table>\r\n<td style=\"font-family:'Google Sans','Roboto',Arial,sans-serif;direction:ltr;text-align:center;font-weight:normal;color:#5f6368;word-break:normal;font-size:20px;line-height:32px;color:#5f6368;padding:36px 0px 0px 3px;font-size:16px;line-height:26px;font-weight:normal;color:#25272b\" dir=\"ltr\">\r\n      {CONTEUDO}\r\n      </td><a class=\"m_-3092646683337883856showdesktop\" style=\"background-color:#1a73e8;direction:ltr;border-radius:2px;color:#ffffff;display:inline-block;font-size:16px;line-height:24px;font-weight:400;text-align:center;text-decoration:none;padding:14px 20px 13px 20px;font-family:'Google Sans','Roboto',Arial,sans-serif;letter-spacing:0.75px;font-weight:normal;font-size:14px;line-height:21px;border-radius:4px\" target=\"_blank\" href=" + url+">Confirmar email</a>");
                    Label.Text = "Email de confirmação reenviado. Por favor, verifique sua caixa de entrada ou spam.";
                    break;
                case "2":
                    Email.Send(email, new List<string>(), "Email de confirmação BRIKK", "Olá " + nome + "! Clique no link a seguir para finalizar seu cadastro: http://44.198.11.245/Geral/confirmacaoemailfornecedor.aspx?guid=" + guid);
                    Label.Text = "Email de confirmação reenviado. Por favor, verifique sua caixa de entrada ou spam.";
                    break;
                default:
                    Label.Text = "Tipo de email desconhecido.";
                    break;
            }
        }

    }
}
