using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Reflection;
using System.Security;
using System.Text;
using System.Web;


// The AllowPartiallyTrustedCallersAttribute requires the assembly to be signed with a strong name key. 
// This attribute is necessary since the control is called by either an intranet or Internet 
// Web page that should be running under restricted permissions.
[assembly: AllowPartiallyTrustedCallers]
namespace Monitor.classes
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

            str = @"<html>
<head></head>
<body bgcolor='#f5f5f5' style='background-color:#f5f5f5'>

    <table width='600' cellpadding='0' cellspacing='0' border='0' align='center' bgcolor='#f5f5f5' class='m_-495586993307588921table'>

        <tbody>
            <tr>
                <td class='m_-495586993307588921height-0' height='14'></td>
            </tr>
            <tr valign='top'>
                <td>
                    <table>
                        <tbody>
                            <tr>


                                <td width='596' align='left' valign='top' style='font-family: Roboto,Arial; font-weight: normal; font-size: 12px; text-align: left; color: #333333; padding-bottom: 16px; line-height: 20px; width: 596px'>Agora você pode acessar seu ambiente de trabalho. Acesse <a href='http://www.grmsuite.com.br/' class='m_-495586993307588921forApple_footer' style='color: #3d82f7; text-decoration: none' target='_blank'><font style='color: #3d82f7'><span style='color:#3d82f7;white-space:nowrap'>www.grmsuite.com.br</span></font></a></td>

                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
            <tr>
                <td valign='top'>
                    <table width='600' cellpadding='0' cellspacing='0' border='0' bgcolor='#f5f5f5' class='m_-495586993307588921table' style='width: 600px!important' align='center'>
                        <tbody>
                            <tr>
                                <td style='min-width: 600px!important' class='m_-495586993307588921width-fixed'>
                                    <table width='600' border='0' cellpadding='0' cellspacing='0'>
                                        <tbody>

                                            <tr class='m_-495586993307588921display'>
                                                <td height='0'></td>
                                            </tr>

                                            <tr valign='top'>
                                                <td width='0' class='m_-495586993307588921display'></td>
                                                <td width='600' style='width: 600px!important;'>
                                                    <table width='100%' cellpadding='' cellspacing='0' border='0' class='m_-495586993307588921table'>
                                                        <tbody>
                                                            <tr>
                                                                <td class='m_-495586993307588921logo' height='26' style='border-collapse: collapse; margin: 0; padding-left: 0px; padding-right: 30px; padding-top: 20px; padding-bottom: 20px;'>
                                                                    <img src='http://www.brikk.com.br/img/logo4.png' height='35' style='border-left-style: none; border-top-style: none; border-bottom-style: none; border-right-style: none; display: block; height: 35px' alt='GRM Suite' class='CToWUd'>
                                                                </td>


                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>

                            <tr>
                                <td style='min-width: 600px!important' class='m_-495586993307588921width-fixed'>
                                    <table width='600' border='0' cellpadding='0' cellspacing='0' align='center' class='m_-495586993307588921table' style='width: 600px!important'>
                                        <tbody>
                                            <tr valign='top'>
                                                <td width='0' class='m_-495586993307588921display'></td>
                                                <td width='600' class='m_-495586993307588921table' style='width: 600px!important'>
                                                    <table width='600' cellpadding='0' cellspacing='0' border='0' align='center' class='m_-495586993307588921table' bgcolor='#FFFFFF' style='width: 600px!important'>
                                                        <tbody>
                                                            <tr>
                                                                <td width='100%' class='m_-495586993307588921display' style='border-collapse: collapse; margin: 0'>
                                                                    <a href='#' style='display: block' target='_blank'>
                                                                        <img src='https://www.brikk.com.br/externa/template/capa.jpg' width='100%' style='border-left-style: none; border-top-style: none; border-bottom-style: none; border-right-style: none; display: block' alt='GRM Suite' class='CToWUd'></a>
                                                                </td>
                                                            </tr>
                                                            <tr valign='top'>
                                                                <td class='m_-495586993307588921mobile-padding'>
                                                                    <table border='0' cellspacing='0' cellpadding='0'>
                                                                        <tbody>
                                                                            <tr valign='top'>
                                                                                <td width='30'></td>
                                                                                <td bgcolor='#FFFFFF'>
                                                                                    <table border='0' cellspacing='0' cellpadding='0' class='m_-495586993307588921display' align='left'>
                                                                                        <tbody>
                                                                                            <tr>
                                                                                                <td class='m_-495586993307588921height-0' height='14'></td>
                                                                                            </tr>
                                                                                            <tr valign='top'>
                                                                                                <td style='font-family: Roboto,Arial; line-height: 44px; font-size: 34px; color: #616161; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 4px; padding-right: 10px; text-align: left' align='left'>#TITLE#

                                                                                                </td>
                                                                                            </tr>

                                                                                            <tr valign='top'>
                                                                                                <td style='font-family: Roboto,Arial; line-height: 25px; font-size: 16px; color: #616161; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px; text-align: left' align='left'>#DESCRIPTION#
                                                                                                </td>
                                                                                            </tr>

                                                                                            <tr>
                                                                                                <td class='m_-495586993307588921height-0' height='20'></td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td align='center'></td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td width='100%' height='20'></td>
                                                                                            </tr>

                                                                                            <tr valign='top' class='m_-495586993307588921display'>
                                                                                                <td style='font-family: Roboto,Arial; line-height: 24px; font-size: 16px; color: #616161; margin-top: 0px; margin-bottom: 0px; padding-top: 0px; padding-bottom: 0px; text-align: left; text-align: left' align='left'>Atenciosamente,<br>
                                                                                                    <strong>Equipe GRM Suite</strong></td>
                                                                                            </tr>
                                                                                            <tr valign='top'>
                                                                                                <td class='m_-495586993307588921height-0' height='30'></td>
                                                                                            </tr>

                                                                                        </tbody>
                                                                                    </table>
                                                                                </td>
                                                                                <td width='30'>&nbsp;</td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td width='0' class='m_-495586993307588921display'></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <table width='600' cellpadding='0' cellspacing='0' border='0' align='center' bgcolor='#f5f5f5' class='m_-495586993307588921table' style='border-collapse: collapse'>
                        <tbody>

                            <tr>
                                <td valign='top' style='min-width: 600px' class='m_-495586993307588921width-fixed'>
                                    <table width='600' border='0' cellpadding='0' cellspacing='0' align='center' class='m_-495586993307588921table'>
                                        <tbody>
                                            <tr>
                                                <td width='30'>&nbsp;</td>
                                                <td class='m_-495586993307588921footerTC'>
                                                    <table width='540' style='width: 540px!important' border='0' cellspacing='0' cellpadding='0' align='left' class='m_-495586993307588921table'>
                                                        <tbody>
                                                            <tr valign='top'>
                                                                <td class='m_-495586993307588921height-10' height='20'></td>
                                                            </tr>
                                                            <tr valign='top'>
                                                                <td class='m_-495586993307588921font-T-and-C' style='font-family: Arial; font-size: 10px; line-height: 16px; color: #666666; text-align: left; word-break: break-all' align='left'>A GRM Suite é uma empresa do Grupo Marini.</td>
                                                            </tr>

                                                            <tr valign='top'>
                                                                <td class='m_-495586993307588921height-20' height='13'></td>
                                                            </tr>



                                                            <tr valign='top'>
                                                                <td class='m_-495586993307588921height-10' height='10'></td>
                                                            </tr>

                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td width='30'>&nbsp;</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>


</body>
</html>
";

            return str;
        }
    }
}