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
            template = template.Replace("{TITULO}", title).Replace("{BOTAO}", body);
            //StreamReader sr = new StreamReader(Path.GetDirectoryName(@"template/") + @"\contato.html");
            //template = sr.ReadToEnd();
            //sr.Close();

            MailMessage oEmail = new MailMessage();
            MailAddress sDe = new MailAddress("💡 Brikk <naoresponda@brikk.com.br>"); 
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
            oEmail.Body = template;
            oEmail.IsBodyHtml = true;
            oEmail.Sender = sDe;

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

            str = @"<td style=""max-width:598px;padding:0;margin:0;width:598px;border:1px solid #e0e0e0;min-width:598px"" width=""598"" align=""center"" valign=""top"">
    <div>
        <div>


        </div>
    </div>

    
 

    <table cellspacing=""0"" cellpadding=""0"" border=""0"" width=""100%"" valign=""top"" role=""presentation"" style=""margin:auto;width:100%"">
        <tbody>
            <tr>
                <td style=""text-align:center;padding:43px 65px 39px 91px;padding:40px 40px 32px 40px;color:#202124"" valign=""top"">
                    <img src=""http://44.198.11.245/imagens/logo.png"" alt="""" color=""#770e18"" width=""400"" height=""auto"" style=""width:400px;height:auto;border:0"" valign=""top"" class=""CToWUd"" data-bit=""iit"">
                </td>
            </tr>
            <tr>
                <td align=""center"" style=""font-family:'Rajdhani Sans','Roboto',Arial,sans-serif;text-align:center;padding:0px 40px 19px 40px;color:#202124;font-size:42px;line-height:54px;direction:ltr;font-weight:normal;word-break:normal;color:#25272b;font-size:32px;line-height:39px;padding:2px 55px 6px 73px"" dir=""ltr"">
                    {TITULO}
                </td>
            </tr>

        

   

    <table cellspacing=""0"" cellpadding=""0"" border=""0"" width=""auto"" align=""center"" role=""presentation"">
        <tbody>
            <tr>
                <td>
                    <table cellspacing=""0"" cellpadding=""0"" border=""0"" style=""border-collapse:collapse;clear:both;padding:0;Margin:0;table-layout:fixed"" role=""presentation"">
                        <tbody>
                            <tr>
                                <td style=""border-collapse:collapse;word-break:normal;padding:31px 0px 4px 0px;direction:ltr"" align=""center"" dir=""ltr"">
                                    <div>
                                        {BOTAO}
                                        </br></br>
                                    </div>

                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
    <table cellspacing=""0"" cellpadding=""0"" border=""0"" width=""480"" style=""width:480px"" role=""presentation"">
    </table>


   

</td>
";

            return str;
        }
    }
}