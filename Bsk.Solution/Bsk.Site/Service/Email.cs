using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Reflection;
using System.Security;
using System.Text;
using System.Web;




namespace Bsk.Site.Service
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
            MailAddress sDe = new MailAddress("💡 Brikk <naoresponda@spsantos.com.br>"); 
            MailAddress sRpt = new MailAddress("naoresponda@brikk.com.br");

            oEmail.To.Add(destinatario);

            foreach (String cc in copias)
            {
                oEmail.CC.Add(cc);
            }
            oEmail.From = sDe;
            oEmail.ReplyTo = sRpt;
            oEmail.Priority = MailPriority.High;
            oEmail.Subject = title;
            oEmail.Body = body;
            oEmail.IsBodyHtml = true;

            SmtpClient oEnviar = new SmtpClient("smtp.gmail.com", 587);
            oEnviar.EnableSsl = true;
            oEnviar.UseDefaultCredentials = false;
            System.Net.NetworkCredential cred = new System.Net.NetworkCredential("naoresponda@spsantos.com.br", "Brikk@123"); 

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