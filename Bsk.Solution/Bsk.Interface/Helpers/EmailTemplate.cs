using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;
using System.Configuration;

namespace Bsk.Interface.Helpers
{
    public class EmailTemplate
    {
        public string emailPadrao(string titulo, string mensagem, string imagem)
        {
            string html = $@"<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
	<meta http-equiv='Content-type' content='text/html; charset=utf-8' />
	<meta content='telephone=no' name='format-detection' />
	<title>Email Template</title>


	
</head>
<body class='body' style='padding:0 !important; margin:0 !important; display:block !important; background:#ffffff; -webkit-text-size-adjust:none'>
<img src='{imagem}' />
<h1>{titulo}</h1>
<span>{mensagem}</span>
</body>
</html>

";

            return html;

        }

        public bool enviaEmail(string html, string area, string email)
        {
            bool sucesso = true;
            SmtpClient smtpClient = new SmtpClient(ConfigurationManager.AppSettings["smtp"].ToString(), 587);
            smtpClient.EnableSsl = true;
            MailMessage message = new MailMessage(new MailAddress(ConfigurationManager.AppSettings["email"].ToString(), area), new MailAddress(email, area));
            message.IsBodyHtml = true;
            string str = html;
            message.Body = str;
            message.Subject = area;
            NetworkCredential networkCredential = new NetworkCredential(ConfigurationManager.AppSettings["email"].ToString(), ConfigurationManager.AppSettings["emailsenha"].ToString(), "");
            smtpClient.Credentials = new NetworkCredential(ConfigurationManager.AppSettings["email"].ToString(), ConfigurationManager.AppSettings["emailsenha"].ToString());// (ICredentialsByHost)networkCredential;
            Console.WriteLine("Enviando...");
            try
            {
                smtpClient.Send(message);
                Console.WriteLine("OK");
            }
            catch (Exception ex)
            {
                sucesso = false;
                Console.WriteLine("Exceção:" + ((object)ex).ToString());
            }
            return sucesso;
        }
    }

}
