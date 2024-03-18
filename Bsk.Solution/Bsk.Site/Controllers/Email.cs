using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Reflection;
using System.Security;
using System.Text;
using System.Web;



[assembly: AllowPartiallyTrustedCallers]
namespace Bsk.Site.Controllers
{
    public class Email
    {

        public static Boolean Send(String destinatario, List<String> copias, String title, String body)
        {
            String template = Template();
            //StreamReader sr = new StreamReader(Path.GetDirectoryName(@"template/") + @"\contato.html");
            //template = sr.ReadToEnd();
            //sr.Close();

            MailMessage oEmail = new MailMessage();
            MailAddress sDe = new MailAddress("💡 Brikk <no-reply@brikk.com.br>"); 
            MailAddress sRpt = new MailAddress("no-reply@brikk.com.br");

            oEmail.To.Add(destinatario);

            foreach (String cc in copias)
            {
                oEmail.CC.Add(cc);
            }
            oEmail.From = sDe;
            //oEmail.ReplyTo = sRpt;
            oEmail.Priority = MailPriority.High;
            oEmail.Subject = title;
            oEmail.Body = body;
            oEmail.IsBodyHtml = true;

            SmtpClient oEnviar = new SmtpClient("mail.brikk.com.br", 26);
            oEnviar.EnableSsl = false;
            oEnviar.UseDefaultCredentials = false;
            System.Net.NetworkCredential cred = new System.Net.NetworkCredential("no-reply@brikk.com.br", "SENHA"); 

            oEnviar.Credentials = cred;

            oEnviar.Send(oEmail);
            oEmail.Dispose();
            return true;

        }



        public static string Template()
        {
            String str = "";

            str = @"
";

            return str;
        }
    }
}