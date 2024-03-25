using Bsk.BE;
using Bsk.Interface;
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
            if (String.IsNullOrEmpty(Request.QueryString["Tipo"]))
            {
                Response.Redirect("login.aspx");
            }

            if (!String.IsNullOrEmpty(Request.QueryString["Red"]))
            {
                if (Request.QueryString["Red"] == "ok")
                {
                    msg.Text = "Cadastro efetuado com sucesso!";
                }
            }
        }

        protected void btnFisica_ServerClick(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request.QueryString["Tipo"]))
            {
                Response.Redirect("login.aspx");
            }
            if (Request.QueryString["Tipo"] == "cli")
            {
                salvaFisicaCliente();
            }
            else if (Request.QueryString["Tipo"] == "for")
            {
                salvaFisicaFornecedor();
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
           var id = _core.Cliente_Insert(_ClienteBE);
            if (string.IsNullOrEmpty(id))
            {
                msg.Text = "Estamos com problemas para efetuar o seu cadastro, por favor tente novamente mais tarde";
            }
            else
            {
                Response.Redirect($"cadastro.aspx?Tipo={Request.QueryString["Tipo"]}&Red=ok");
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
                NomeFantasia = fantasia.Value,
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
            _core.Cliente_Insert(_ClienteBE);
        }

        protected void btnJuridica_ServerClick(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request.QueryString["Tipo"]))
            {
                Response.Redirect("login.aspx");
            }
            if (Request.QueryString["Tipo"] == "cli")
            {
                salvaJuridicaCliente();
            }
            else if (Request.QueryString["Tipo"] == "for")
            {
                salvaJuridicaFornecedor();
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        private void salvaJuridicaFornecedor()
        {
            DateTime dt = DateTime.MinValue;
            if (String.IsNullOrEmpty(abertura.Value))
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
            _core.Cliente_Insert(_ClienteBE);
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
            _core.Cliente_Insert(_ClienteBE);
        }
    }
}