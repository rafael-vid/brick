using Bsk.BE;
using Bsk.Interface;
using Bsk.Site.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Geral
{
    public partial class cadastro : System.Web.UI.Page
    {
        FornecedorBE _FornecedorBE = new FornecedorBE();
        ClienteBE _ClienteBE = new ClienteBE();
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
            if (String.IsNullOrEmpty(Request.QueryString["Tipo"]))
            {
                Response.Redirect("login.aspx");
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

        protected bool IsEmailRegisteredCli(string email)
        {
            ClienteBE ClienteBE = new ClienteBE();
            var emails = _core.Cliente_Get(ClienteBE, $"email='{email}'");
            if (emails.Count > 0)
            {
                return true;
            }
            return false;
        }
        protected bool IsEmailRegisteredFor(string email)
        {
            FornecedorBE FornecedorBE = new FornecedorBE();
            var emails = _core.Fornecedor_Get(FornecedorBE, $"email='{email}'");
            if (emails.Count > 0)
            {
                return true;
            }
            return false;
        }

        protected void btnFisica_ServerClick(object sender, EventArgs e)
        {
            string stremail = email.Value;
            if (String.IsNullOrEmpty(Request.QueryString["Tipo"]))
            {
                Response.Redirect("login.aspx");
            }
            if (Request.QueryString["Tipo"] == "cli")
            {
                if (IsEmailRegisteredCli(stremail))
                {
                    string message = "Email já existe";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage3('" + message + "');", true);
                }
                else
                {
                    salvaFisicaCliente();
                }
            }
            else if (Request.QueryString["Tipo"] == "for")
            {
                if (IsEmailRegisteredFor(stremail))
                {
                    string message = "Email já existe";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage3('" + message + "');", true);
                }
                else
                {
                    salvaFisicaFornecedor();
                }

            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        private void salvaFisicaCliente()
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
            _ClienteBE = new ClienteBE()
            {
                Bairro = bairro.Value,
                Cep = cep.Value,
                Cnpj = cnpj.Value,
                Complemento = complemento.Value,
                CpfResponsavel = cpf.Value,
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                Email = email.Value,
                Fantasia = fantasia.Value,
                Logradouro = endereco.Value,
                MeioPagamento = "",
                Municipio = cidade.Value,
                Nome = nome.Value,
                NomeResponsavel = nome.Value,
                Numero = numero.Value,
                Senha = senha.Value,
                Situacao = situacao.Value,
                Sobrenome = sobrenome.Value,
                Status = "",
                Telefone = telefone.Value,
                Uf = estado.Value,
                ZoopID = "",
                WhatsApp = telefone.Value,
                DataAbertura = dt.ToString("yyyy-MM-dd HH:mm:ss"),
                //Matriz = matriz.Value,
                RazaoSocial = razao.Value,
                GuidColumn = guid

            };
            if (
    !string.IsNullOrEmpty(nome.Value) &&
    !string.IsNullOrEmpty(sobrenome.Value) &&
    !string.IsNullOrEmpty(email.Value) &&
    !string.IsNullOrEmpty(cpf.Value) &&
    !string.IsNullOrEmpty(telefone.Value) &&
    !string.IsNullOrEmpty(cep.Value) &&
    !string.IsNullOrEmpty(endereco.Value) &&
    !string.IsNullOrEmpty(bairro.Value) &&
    !string.IsNullOrEmpty(numero.Value) &&
    !string.IsNullOrEmpty(cidade.Value) &&
    !string.IsNullOrEmpty(estado.Value)
)
            {
                var id = _core.Cliente_Insert(_ClienteBE);
                var listacliente = _core.Cliente_Get(_ClienteBE, "IdCliente=" + id);
                Email.Send(email.Value, new List<string>(), "Email de confirmação BRIKK", "Olá "+ nome.Value+"! Clique no link a seguir para finalizar seu cadastro: http://44.198.11.245/Geral/confirmacaoemail.aspx?guid="+guid);
                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    msg.Text = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                }
                else
                {
                    HttpCookie emailcookie = new HttpCookie("emailcookie");
                    emailcookie.Value = email.Value + " 1";
                    Response.Cookies.Add(emailcookie);
                    Response.Redirect($"cadastro.aspx?Tipo={Request.QueryString["Tipo"]}&Red=ok");
                }
            }
            else
            {
                string message = "Por favor preencha os campos obrigatórios";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
            }

        }

        private void salvaFisicaFornecedor()
        {
            string cpfValue = cpf.Value;
            if (!IsValidCPF(cpfValue))
            {
                string message = "CPF inválido";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                return;
            }
            DateTime dt = DateTime.Now;
            if (!String.IsNullOrEmpty(abertura.Value))
            {
                dt = Convert.ToDateTime(abertura.Value);
            }
            string guid = Guid.NewGuid().ToString();
            _FornecedorBE = new FornecedorBE()
            {
                Bairro = bairro.Value,
                Cep = cep.Value,
                Cnpj = cnpj.Value,
                Complemento = complemento.Value,
                CpfResponsavel = cpf.Value,
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                Email = email.Value,
                NomeFantasia = nome.Value,
                Logradouro = endereco.Value,
                Municipio = cidade.Value,
                Responsavel = nome.Value,
                Numero = numero.Value,
                Senha = senha.Value,
                Situacao = situacao.Value,
                SobreNome = sobrenome.Value,
                Status = "",
                Telefone = telefone.Value,
                Uf = estado.Value,
                WhatsApp = telefone.Value,
                //Matriz = matriz.Value,
                RazaoSocial = razao.Value,
                Abertura = dt.ToString("yyyy-MM-dd"),
                Tipo = "MATRIZ",
                SellerID = "586de6c5-f696-49d6-8b0c-592d3a038524",
                GuidColumn = guid
            };
            if (
    !string.IsNullOrEmpty(nome.Value) &&
    !string.IsNullOrEmpty(sobrenome.Value) &&
    !string.IsNullOrEmpty(email.Value) &&
    !string.IsNullOrEmpty(cpf.Value) &&
    !string.IsNullOrEmpty(telefone.Value) &&
    !string.IsNullOrEmpty(cep.Value) &&
    !string.IsNullOrEmpty(endereco.Value) &&
    !string.IsNullOrEmpty(bairro.Value) &&
    !string.IsNullOrEmpty(numero.Value) &&
    !string.IsNullOrEmpty(cidade.Value) &&
    !string.IsNullOrEmpty(estado.Value)
)
            {
                var id = _core.Fornecedor_Insert(_FornecedorBE);
                var listacliente = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + id);
                Email.Send(email.Value, new List<string>(), "Email de confirmação BRIKK", "Olá " + nome.Value + "! Clique no link para confirmar seu e-mail: http://44.198.11.245/Geral/confirmacaoemailfornecedor.aspx?guid=" + guid);
                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    msg.Text = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                }
                else
                {
                    HttpCookie emailcookie = new HttpCookie("emailcookie");
                    emailcookie.Value = email.Value + " 2";
                    Response.Cookies.Add(emailcookie);
                    Response.Redirect($"cadastro.aspx?Tipo={Request.QueryString["Tipo"]}&Red=ok");
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
            if (String.IsNullOrEmpty(Request.QueryString["Tipo"]))
            {
                Response.Redirect("login.aspx");
            }
            if (Request.QueryString["Tipo"] == "cli")
            {
                if (IsEmailRegisteredCli(stremail))
                {
                    string message = "Email já existe";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage3('" + message + "');", true);
                }
                else
                {
                    salvaJuridicaCliente();
                }
            }
            else if (Request.QueryString["Tipo"] == "for")
            {
                if (IsEmailRegisteredFor(stremail))
                {
                    string message = "Email já existe";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage3('" + message + "');", true);
                }
                else
                {
                    salvaJuridicaFornecedor();
                }

            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        private void salvaJuridicaFornecedor()
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
            _FornecedorBE = new FornecedorBE()
            {
                Bairro = bairroJuridica.Value,
                Cep = cepJuridica.Value,
                Cnpj = cnpj.Value,
                Complemento = complementoJuridica.Value,
                CpfResponsavel = cpf.Value,
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                Email = emailJuridica.Value,
                NomeFantasia = fantasia.Value,
                Logradouro = endereco.Value,
                Municipio = cidadeJuridica.Value,
                Responsavel = nomeJuridica.Value,
                Numero = numeroJuridica.Value,
                Senha = senhaJuridica.Value,
                Situacao = situacao.Value,
                SobreNome = sobrenomeJuridica.Value,
                Status = "",
                Telefone = telefoneJuridica.Value,
                Uf = estadoJuridica.Value,
                WhatsApp = telefoneJuridica.Value,
                //Matriz = matriz.Value,
                RazaoSocial = razao.Value,
                Abertura = dt.ToString("yyyy-MM-dd"),
                Tipo = "MATRIZ",
                SellerID = "586de6c5-f696-49d6-8b0c-592d3a038524",
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
                var id = _core.Fornecedor_Insert(_FornecedorBE);
                var listacliente = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor=" + id);
                Email.Send(email.Value, new List<string>(), "Email de confirmação BRIKK", "Olá " + nome.Value + "! Clique no link para confirmar seu e-mail: http://44.198.11.245/Geral/confirmacaoemailfornecedor.aspx?guid=" + guid);

                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    msg.Text = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                }
                else
                {
                    HttpCookie emailcookie = new HttpCookie("emailcookie");
                    emailcookie.Value = email.Value + " 2";
                    Response.Cookies.Add(emailcookie);
                    Response.Redirect($"cadastro.aspx?Tipo={Request.QueryString["Tipo"]}&Red=ok");
                }
            }
            else
            {
                string message = "Por favor preencha os campos obrigatórios";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
            }

        }

        private void salvaJuridicaCliente()
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
            _ClienteBE = new ClienteBE()
            {
                Bairro = bairroJuridica.Value,
                Cep = cepJuridica.Value,
                Cnpj = cnpj.Value,
                Complemento = complementoJuridica.Value,
                CpfResponsavel = cpf.Value,
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                Email = emailJuridica.Value,
                Fantasia = fantasia.Value,
                Logradouro = endereco.Value,
                MeioPagamento = "",
                Municipio = cidadeJuridica.Value,
                Nome = nomeJuridica.Value,
                NomeResponsavel = nomeJuridica.Value,
                Numero = numeroJuridica.Value,
                Senha = senhaJuridica.Value,
                Situacao = situacao.Value,
                Sobrenome = sobrenomeJuridica.Value,
                Status = "",
                Telefone = telefoneJuridica.Value,
                Uf = estadoJuridica.Value,
                ZoopID = "",
                WhatsApp = telefoneJuridica.Value,
                DataAbertura = dt.ToString("yyyy-MM-dd HH:mm:ss"),
                //Matriz = matriz.Value,
                RazaoSocial = razao.Value,
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
                var id = _core.Cliente_Insert(_ClienteBE);
                var listacliente = _core.Cliente_Get(_ClienteBE, "IdCliente=" + id);
                Email.Send(email.Value, new List<string>(), "Email de confirmação BRIKK", "Olá " + nome.Value + "! Clique no link para confirmar seu e-mail: http://44.198.11.245/Geral/confirmacaoemail.aspx?guid=" + guid);
                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    msg.Text = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                }
                else
                {
                    HttpCookie emailcookie = new HttpCookie("emailcookie");
                    emailcookie.Value = email.Value + " 1";
                    Response.Cookies.Add(emailcookie);
                    Response.Redirect($"cadastro.aspx?Tipo={Request.QueryString["Tipo"]}&Red=ok");
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