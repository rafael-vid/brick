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
            switch (tipo)
            {
                case "1":
                    Email.Send(email, new List<string>(), "Email de confirmação BRIKK", "Olá " + nome + "! Clique no link a seguir para finalizar seu cadastro: http://localhost:57642/Geral/confirmacaoemail.aspx?guid=" + guid);
                    Label.Text = "Email de confirmação reenviado. Por favor, verifique sua caixa de entrada ou spam.";
                    break;
                case "2":
                    Email.Send(email, new List<string>(), "Email de confirmação BRIKK", "Olá " + nome + "! Clique no link a seguir para finalizar seu cadastro: http://localhost:57642/Geral/confirmacaoemailfornecedor.aspx?guid=" + guid);
                    Label.Text = "Email de confirmação reenviado. Por favor, verifique sua caixa de entrada ou spam.";
                    break;
                default:
                    Label.Text = "Tipo de email desconhecido.";
                    break;
            }
        }

    }
}
