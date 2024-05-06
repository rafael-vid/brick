using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class perfil : System.Web.UI.Page
    {
        Bsk.Interface.core _core = new Interface.core();
        Bsk.BE.ClienteBE clienteBE = new Bsk.BE.ClienteBE();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
                var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + login.IdCliente).FirstOrDefault();

                nome.Value = cliente.Nome;
                sobrenome.Value = cliente.Sobrenome;
                email.Value = cliente.Email;
                cpf.Value = cliente.Cnpj;
                telefone.Value = cliente.Telefone;
                cep.Value = cliente.Cep;
                rua.Value = cliente.Logradouro;
                numero.Value = cliente.Numero;
                complemento.Value = cliente.Complemento;
                bairro.Text = cliente.Bairro;
                cidade.Value = cliente.Municipio;
                uf.Value = cliente.Uf;
            }
        }
        protected Boolean validatePhone(String phone)
        {
            Regex rg = new Regex("^((1[1-9])|([2-9][0-9]))((3[0-9]{3}[0-9]{4})|(9[0-9]{3}[0-9]{5}))$");
            return rg.IsMatch(phone);
        }
        protected Boolean validateCep(String cep)
        {
            Regex rg = new Regex("\\d{5}[-.\\s]?\\d{3}");
            return rg.IsMatch(cep);
        }
        protected Boolean validateCpf(String cpf)
        {
            Regex rg = new Regex("([0-9]{2}[\\.]?[0-9]{3}[\\.]?[0-9]{3}[\\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\\.]?[0-9]{3}[\\.]?[0-9]{3}[-]?[0-9]{2})");
            return rg.IsMatch(cpf);
        }
        protected void btnAlterar_ServerClick(object sender, EventArgs e)
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            Bsk.BE.ClienteBE clienteBE = new BE.ClienteBE();
            Bsk.Interface.core _core = new Interface.core();
            Boolean AtualizarCampos = true;
            if (String.IsNullOrEmpty(nome.Value))
            {
                msgnome.InnerText = "Erro: favor inserir um nome.";
                AtualizarCampos = false;
            }
            else
            {
                msgnome.InnerText = "";
            }
            if (String.IsNullOrEmpty(sobrenome.Value))
            {
                msgsobrenome.InnerText = "Erro: favor inserir um sobrenome.";
                AtualizarCampos = false;
            }
            else
            {
                msgsobrenome.InnerText = "";
            }
            if (String.IsNullOrEmpty(email.Value))
            {
                msgemail.InnerText = "Erro: favor inserir um endereço de e-mail.";
                AtualizarCampos = false;
            }
            else
            {
                msgemail.InnerText = "";
            }
            if (!validateCpf(cpf.Value))
            {
                msgcpf.InnerText = "Erro: favor inserir um número de cpf.";
                AtualizarCampos = false;
            }
            else
            {
                msgcpf.InnerText = "";
            }
            if (!validatePhone(telefone.Value))
            {
                msgtelefone.InnerText = "Erro: favor inserir um número de telefone.";
                AtualizarCampos = false;
            }
            else
            {
                msgtelefone.InnerText = "";
            }
            if (String.IsNullOrEmpty(rua.Value))
            {
                msgrua.InnerText = "Erro: favor inserir um logradouro.";
                AtualizarCampos = false;
            }
            else
            {
                msgrua.InnerText = "";
            }
            if (String.IsNullOrEmpty(bairro.Text))
            {
                msgbairro.InnerText = "Erro: favor inserir um bairro.";
                AtualizarCampos = false;
            }
            else
            {
                msgbairro.InnerText = "";
            }
            if (String.IsNullOrEmpty(numero.Value))
            {
                msgnumero.InnerText = "Erro: favor inserir um número.";
                AtualizarCampos = false;
            }
            else
            {
                msgnumero.InnerText = "";
            }
            if (!validateCep(cep.Value))
            {
                msgcep.InnerText = "Erro: favor inserir um cep.";
                AtualizarCampos = false;
            }
            else
            {
                msgcep.InnerText = "";
            }
            if (String.IsNullOrEmpty(cidade.Value))
            {
                msgcidade.InnerText = "Erro: favor inserir uma cidade.";
                AtualizarCampos = false;
            }
            else
            {
                msgcidade.InnerText = "";
            }
            if (String.IsNullOrEmpty(uf.Value))
            {
                msguf.InnerText = "Erro: favor inserir um estado.";
                AtualizarCampos = false;
            }
            else
            {
                msguf.InnerText = "";
            }
            if (AtualizarCampos == true)
            {
                var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + login.IdCliente).FirstOrDefault();
                cliente.Logradouro = rua.Value;
                cliente.Municipio = cidade.Value;
                cliente.Nome = nome.Value;
                cliente.Sobrenome = sobrenome.Value;
                cliente.Numero = numero.Value;
                cliente.Telefone = telefone.Value;
                cliente.Uf = uf.Value;
                cliente.Complemento = complemento.Value;
                cliente.Email = email.Value;
                cliente.Cep = cep.Value;
                cliente.Bairro = bairro.Text;
                cliente.Cnpj = cpf.Value;
                cliente.DataAbertura = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                _core.Cliente_Update(cliente, "IdCliente=" + cliente.IdCliente);


                if (Request.QueryString["Red"] != null)
                {
                    HttpCookie lg = new HttpCookie("login");
                    cliente.Senha = "xxx";
                    lg.Value = Newtonsoft.Json.JsonConvert.SerializeObject(cliente);


                    Response.Cookies.Add(lg);

                    Response.Redirect(Request.QueryString["Red"] + ".aspx?Id=" + Request.QueryString["Id"]);
                }
                else
                {
                    HttpCookie lg = new HttpCookie("login");
                    cliente.Senha = "xxx";
                    lg.Value = Newtonsoft.Json.JsonConvert.SerializeObject(cliente);


                    Response.Cookies.Add(lg);
                }
            }
            else
            {
                {
                    string script = "Swal.fire('Favor preencher todos os campos')";
                    ClientScript.RegisterStartupScript(this.GetType(), "swal", script, true);
                }
            }


        }
    }
}