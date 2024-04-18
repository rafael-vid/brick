using Bsk.BE;
using Bsk.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using static AjaxControlToolkit.AsyncFileUpload.Constants;
using MySql.Data.MySqlClient;

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
                // Assuming you have logic here to handle form submission and you set the value of userType hidden field
                // to "pf" or "pj" based on the submission.

                // Check if the userType hidden field value is set to "pj" for Pessoa Jurídica
                if (userType.Value == "pj")
                {
                    // Ensure the Pessoa Jurídica radio button is checked
                    pj.Checked = true;
                    pf.Checked = false; // Optionally, make sure Pessoa Física is not checked
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
                    string message = "Cadastro efetuado com sucesso!";
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
        protected bool IsEmailRegisteredFor (string email)
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
            DateTime dt = DateTime.MinValue;
            if (!String.IsNullOrEmpty(abertura.Value))
            {
                dt = DateTime.Parse(abertura.Value);
            }
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
                Matriz = matriz.Value,
                RazaoSocial = razao.Value

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
                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    string message = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                }
                else
                {
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
            DateTime dt = DateTime.Now;
            if (!String.IsNullOrEmpty(abertura.Value))
            {
                dt = Convert.ToDateTime(abertura.Value);
            }
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
                Matriz = matriz.Value,
                RazaoSocial = razao.Value,
                Abertura = dt.ToString("yyyy-MM-dd"),
                Tipo = "MATRIZ",
                SellerID = "586de6c5-f696-49d6-8b0c-592d3a038524"
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
                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    string message = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                }
                else
                {
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
            DateTime dt = DateTime.MinValue;
            if (!String.IsNullOrEmpty(abertura.Value))
            {
                dt = DateTime.Parse(abertura.Value);
            }
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
                Matriz = matriz.Value,
                RazaoSocial = razao.Value,
                Abertura = dt.ToString("yyyy-MM-dd"),
                Tipo = "MATRIZ",
                SellerID = "586de6c5-f696-49d6-8b0c-592d3a038524"
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
    !string.IsNullOrEmpty(matriz.Value) &&
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
                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    string message = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                }
                else
                {
                    Response.Redirect($"cadastro.aspx?Tipo={Request.QueryString["Tipo"]}&Red=ok");
                }
            }
            else
            {
                string message = "Por favor preencha os campos obrigatórios";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                userType.Value = "pj";
            }

        }

        private void salvaJuridicaCliente()
        {
            DateTime dt = DateTime.MinValue;
            if (!String.IsNullOrEmpty(abertura.Value))
            {
                dt = DateTime.Parse(abertura.Value);
            }
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
                Matriz = matriz.Value,
                RazaoSocial = razao.Value

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
    !string.IsNullOrEmpty(matriz.Value) &&
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
                if (listacliente[0].Email == "" || listacliente[0].Email != email.Value)
                {
                    string message = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                }
                else
                {
                    Response.Redirect($"cadastro.aspx?Tipo={Request.QueryString["Tipo"]}&Red=ok");
                }
            }
            else
            {
                string message = "Por favor preencha os campos obrigatórios";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "displayPopup", "displayPopupMessage('" + message + "');", true);
                userType.Value = "pj";
            }

        }
    }
}