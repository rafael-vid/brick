using Bsk.BE;
using Bsk.Interface;
using Bsk.Site.Admin;
using Bsk.Site.Service;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Bsk.Site.Geral
{
    public partial class cadastro : System.Web.UI.Page
    {
        FornecedorBE _FornecedorBE = new FornecedorBE();
        ClienteBE _ClienteBE = new ClienteBE();
        ParticipanteBE _ParticipanteBE = new ParticipanteBE();
        core _core = new core();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {  
                if (userType.Value == "pj")
                {
                    pj.Checked = true;
                    pf.Checked = false;
                }
            }

            if (!String.IsNullOrEmpty(Request.QueryString["Red"]))
            {
                if (Request.QueryString["Red"] == "ok")
                {
                    string message = "Email de confirmação enviado";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage2('" + message + "');", true);
                }
            }
        }
        protected bool IsEmailRegisteredParticipante(string email)
        {
            ParticipanteBE ParticipanteBE = new ParticipanteBE();
            var emails = _core.Participante_Get(ParticipanteBE, $"email='{email}'");
            if (emails.Count > 0)
            {
                return true;
            }
            return false;
        }
        protected bool IsEmailConfirmedParticipante(string email)
        {
            ParticipanteBE ParticipanteBE = new ParticipanteBE();
            var emails = _core.Participante_Get(ParticipanteBE, $"email='{email}'");
            if (emails[0].EmailConfirmado > 0)
            {
                return true;
            }
            return false;
        }

        protected void btnFisica_ServerClick(object sender, EventArgs e)
        {
            string stremail = email.Value;
           
                if (IsEmailRegisteredParticipante(stremail))
                {
                    if (!IsEmailConfirmedParticipante(stremail))
                    {
                    HttpCookie emailcookie = new HttpCookie("emailcookie");
                    emailcookie.Value = email.Value;
                    Response.Cookies.Add(emailcookie);
                    Response.Redirect($"cadastro.aspx?Red=ok");
                }
                    string message = "Email já existe";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage3('" + message + "');", true);
                }
                else
                {
                    salvaFisicaParticipante();
                }
            
        }

        private void salvaFisicaParticipante()
        {
            string cpfValue = cpf.Value;
            if (!IsValidCPF(cpfValue))
            {
                string message = "CPF inválido";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                return;
            }
            DateTime dt = DateTime.MinValue;
            if (!String.IsNullOrEmpty(abertura.Value))
            {
                dt = DateTime.Parse(abertura.Value);
            }
            string guid = Guid.NewGuid().ToString();
            _ParticipanteBE = new ParticipanteBE()
            {
                Matriz = "0",
                Pj = "",
                Documento = cpf.Value,
                Nome = nome.Value,
                Sobrenome = sobrenome.Value,
                Logradouro = endereco.Value,
                Numero = numero.Value,
                Complemento = complemento.Value,
                Bairro = bairro.Value,
                cidade = cidade.Value,
                Uf = estado.Value,
                Cep = cep.Value,
                Telefone = telefone.Value,
                Email = email.Value,
                Senha = senha.Value,
                prestaServico = 0,
                GuidColumn = guid

            };
            if (
    !string.IsNullOrEmpty(cpf.Value) &&
    !string.IsNullOrEmpty(nome.Value) &&
    !string.IsNullOrEmpty(sobrenome.Value) &&
    !string.IsNullOrEmpty(endereco.Value) &&
    !string.IsNullOrEmpty(numero.Value) &&
    !string.IsNullOrEmpty(bairro.Value) &&
    !string.IsNullOrEmpty(cidade.Value) &&
    !string.IsNullOrEmpty(estado.Value) &&
    !string.IsNullOrEmpty(cep.Value) &&
    !string.IsNullOrEmpty(telefone.Value) &&
    !string.IsNullOrEmpty(email.Value) &&
    !string.IsNullOrEmpty(senha.Value)
)
            {
                var id = _core.Participante_Insert(_ParticipanteBE);
                var listaparticipante = _core.Participante_Get(_ParticipanteBE, "IdParticipante=" + id);
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
                Email.Send(email.Value, new List<string>(), "Email de confirmação BRIKK", htmlContent);
                if (listaparticipante[0].Email == "" || listaparticipante[0].Email != email.Value)
                {
                    msg.Text = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                }
                else
                {
                    HttpCookie emailcookie = new HttpCookie("emailcookie");
                    emailcookie.Value = email.Value;
                    Response.Cookies.Add(emailcookie);
                    Response.Redirect($"cadastro.aspx?Red=ok");
                }
            }
            else
            {
                string message = "Por favor preencha os campos obrigatórios";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
            }

        }

        

        protected void btnJuridica_ServerClick(object sender, EventArgs e)
        {
            string stremail = emailJuridica.Value;
            
                if (IsEmailRegisteredParticipante(stremail))
                {
                    string message = "Email já existe";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage3('" + message + "');", true);
                }
                else
                {
                    salvaJuridicaParticipante();
                }
           
        }

        private void salvaJuridicaParticipante()
        {
            if (!IsValidCNPJ(cnpj.Value))
            {
                string message = "CNPJ inválido. Por favor, verifique o número fornecido.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                return;
            }
            DateTime dt = DateTime.MinValue;
            if (!String.IsNullOrEmpty(abertura.Value))
            {
                dt = DateTime.Parse(abertura.Value);
            }
            string guid = Guid.NewGuid().ToString();
            _ParticipanteBE = new ParticipanteBE()
            {
                Matriz = "0",
                Pj = "",
                Documento = cnpj.Value,
                Nome = nomeJuridica.Value,
                Sobrenome = sobrenomeJuridica.Value,
                Logradouro = logradouroJuridica.Value,
                Numero = numeroJuridica.Value,
                Complemento = complementoJuridica.Value,
                Bairro = bairroJuridica.Value,
                cidade = cidadeJuridica.Value,
                Uf = estadoJuridica.Value,
                Cep = cepJuridica.Value,
                Telefone = telefoneJuridica.Value,
                Email = emailJuridica.Value,
                Senha = senhaJuridica.Value,
                prestaServico = 0,
                GuidColumn = guid
            };
            if (
    !string.IsNullOrEmpty(nomeJuridica.Value) &&
    !string.IsNullOrEmpty(sobrenomeJuridica.Value) &&
    !string.IsNullOrEmpty(emailJuridica.Value) &&
    !string.IsNullOrEmpty(cnpj.Value) &&
    !string.IsNullOrEmpty(razao.Value) &&
    !string.IsNullOrEmpty(fantasia.Value) &&
    !string.IsNullOrEmpty(situacao.Value) &&
    !string.IsNullOrEmpty(abertura.Value) &&
    //!string.IsNullOrEmpty(matriz.Value) &&
    !string.IsNullOrEmpty(telefoneJuridica.Value) &&
    !string.IsNullOrEmpty(bairroJuridica.Value) &&
    !string.IsNullOrEmpty(numeroJuridica.Value) &&
    !string.IsNullOrEmpty(cepJuridica.Value) &&
    !string.IsNullOrEmpty(cidadeJuridica.Value) &&
    !string.IsNullOrEmpty(estadoJuridica.Value) &&
    !string.IsNullOrEmpty(senhaJuridica.Value)
)
            {
                var id = _core.Participante_Insert(_ParticipanteBE);
                var listaparticipante = _core.Participante_Get(_ParticipanteBE, "IdParticipante=" + id);
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
                Email.Send(emailJuridica.Value, new List<string>(), "Email de confirmação BRIKK", htmlContent);

                if (listaparticipante[0].Email == "")
                {
                    msg.Text = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                }
                else
                {
                    HttpCookie emailcookie = new HttpCookie("emailcookie");
                    emailcookie.Value = email.Value;
                    Response.Cookies.Add(emailcookie);
                    Response.Redirect($"cadastro.aspx?Red=ok");
                }
            }
            else
            {
                string message = "Por favor preencha os campos obrigatórios";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
            }

        }

       

        public static bool IsValidCPF(string cpf)
        {
            int[] multiplier1 = new int[9] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplier2 = new int[10] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };

            cpf = cpf.Trim().Replace(".", "").Replace("-", "");
            if (cpf.Length != 11)
                return false;

            for (int j = 0; j < 10; j++)
                if (j.ToString().PadLeft(11, char.Parse(j.ToString())) == cpf)
                    return false;

            string tempCpf = cpf.Substring(0, 9);
            int sum = 0;

            for (int i = 0; i < 9; i++)
                sum += int.Parse(tempCpf[i].ToString()) * multiplier1[i];

            int remainder = sum % 11;
            if (remainder < 2)
                remainder = 0;
            else
                remainder = 11 - remainder;

            string digit = remainder.ToString();
            tempCpf += digit;
            sum = 0;
            for (int i = 0; i < 10; i++)
                sum += int.Parse(tempCpf[i].ToString()) * multiplier2[i];

            remainder = sum % 11;
            if (remainder < 2)
                remainder = 0;
            else
                remainder = 11 - remainder;

            digit += remainder.ToString();

            return cpf.EndsWith(digit);
        }

        public bool IsValidCNPJ(string cnpj)
        {
            int[] multiplier1 = new int[12] { 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplier2 = new int[13] { 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };

            cnpj = cnpj.Trim().Replace(".", "").Replace("-", "").Replace("/", "");
            if (cnpj.Length != 14)
                return false;

            string tempCnpj = cnpj.Substring(0, 12);
            int sum = 0;

            for (int i = 0; i < 12; i++)
                sum += int.Parse(tempCnpj[i].ToString()) * multiplier1[i];

            int remainder = (sum % 11);
            if (remainder < 2)
                remainder = 0;
            else
                remainder = 11 - remainder;

            string digit = remainder.ToString();
            tempCnpj += digit;
            sum = 0;
            for (int i = 0; i < 13; i++)
                sum += int.Parse(tempCnpj[i].ToString()) * multiplier2[i];

            remainder = (sum % 11);
            if (remainder < 2)
                remainder = 0;
            else
                remainder = 11 - remainder;

            digit += remainder.ToString();

            return cnpj.EndsWith(digit);
        }


    }
}