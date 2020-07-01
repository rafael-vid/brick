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
        public string emailPadrao(string titulo, string mensagem, string link, string mensagemBotao)
        {
            string html = @"<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
	<meta http-equiv='Content-type' content='text/html; charset=utf-8' />
	<meta content='telephone=no' name='format-detection' />
	<title>Email Template</title>


	
</head>
<body class='body' style='padding:0 !important; margin:0 !important; display:block !important; background:#ffffff; -webkit-text-size-adjust:none'>

<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#ffffff'>
	<tr>
		<td align='center' valign='top'>
			<table width='800' border='0' cellspacing='0' cellpadding='0'>
				<!-- Header -->
				<tr>
					<td align='center' bgcolor='#1f1f1f'>
						<table width='100%' border='0' cellspacing='0' cellpadding='0'>
							<tr>
								<td><a href='#' target='_blank'><img src='http://www.winodes.com.br/imgEmail/logo.jpg' alt='' border='0' style='width: 100 %; height: 100 %;'  /></a></td>
                                 </tr>
						</table>
					</td>
				</tr>
				<!-- END Header -->
				<!-- Hero -->
				<tr>
					<td class='img' style='font-size:0pt; line-height:0pt; text-align:left'>
							</td>
				</tr>
				<!-- END Hero -->
				<!-- Content -->
				<tr>
					<td>
						<table width='100%' border='0' cellspacing='0' cellpadding='0'>
							<tr>
								<td class='img' style='font-size:0pt; line-height:0pt; text-align:left' width='90'></td>
								<h1>" + titulo+ @"</h1><br/><br/><br/><br/>
								<td>
									<div style='font-size:0pt; line-height:0pt; height:30px'><img src='http://www.winodes.com.br/imgEmail/empty.gif' width='1' height='30' style='height:30px' alt='' /></div>
<p>" + mensagem+@"</p>
<a href='"+link+@"'><input type='button' value='"+mensagemBotao+ @"'></a>
								</td>
								<td class='img' style='font-size:0pt; line-height:0pt; text-align:left' width='90'></td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- END Content -->
				<!-- Footer -->
				<tr>
					<td>
						<div class='img' style='font-size:0pt; line-height:0pt; text-align:left'><img src='http://www.winodes.com.br/imgEmail/footer_top.jpg' alt='' border='0' width='800' height='10' /></div>
						<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#eeefec'>
							<tr>
								<td>
									<div style='font-size:0pt; line-height:0pt; height:12px'><img src='http://www.winodes.com.br/imgEmail/empty.gif' width='1' height='12' style='height:12px' alt='' /></div>


									<div style='font-size:0pt; line-height:0pt; height:30px'><img src='http://www.winodes.com.br/imgEmail/empty.gif' width='1' height='30' style='height:30px' alt='' /></div>

									<div class='footer' style='color:#a9aaa9; font-family:Arial; font-size:11px; line-height:20px; text-align:center'>
										<div>
											www.winodes.com.br contato@winodes.com.br<br />
											Copyright &copy; <span>2016</span> <span>Winodes</span>.
										</div>
									</div>
									<div style='font-size:0pt; line-height:0pt; height:25px'><img src='http://www.winodes.com.br/imgEmail/empty.gif' width='1' height='25' style='height:25px' alt='' /></div>

								</td>
							</tr>
						</table>
					</td>
				</tr>
				<!-- END Footer -->
			</table>
		</td>
	</tr>
</table>

</body>
</html>

";

            return html;

        }
        public void enviaEmail(string html, string area, string email)
        {

            SmtpClient smtpClient = new SmtpClient(ConfigurationManager.AppSettings["smtp"].ToString(), 587);
            smtpClient.EnableSsl = false;
            MailMessage message = new MailMessage(new MailAddress(ConfigurationManager.AppSettings["email"].ToString(), area), new MailAddress(email, area));
            message.IsBodyHtml = true;
            string str = html;
            message.Body = str;
            message.Subject = area;
            NetworkCredential networkCredential = new NetworkCredential(ConfigurationManager.AppSettings["email"].ToString(), ConfigurationManager.AppSettings["emailsenha"].ToString(), "");
            smtpClient.Credentials = (ICredentialsByHost)networkCredential;
            Console.WriteLine("Enviando...");
            try
            {
                smtpClient.Send(message);
                Console.WriteLine("OK");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exceção:" + ((object)ex).ToString());
            }

        }
    }

}
