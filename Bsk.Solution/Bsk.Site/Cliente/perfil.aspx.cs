using Bsk.BE.Pag;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
                nome.Value = login.Nome;
                sobrenome.Value = login.Sobrenome;
                email.Value = login.Email;
                //cpf.Value = login.Cnpj;
                telefone.Value = login.Telefone;
                cep.Value = login.Cep;
                rua.Value = login.Logradouro;
                numero.Value = login.Numero;
                complemento.Value = login.Complemento;
                bairro.Text = login.Bairro;
                //cidade.Value = login.Municipio;
                uf.Value = login.Uf;
                prestaServicos.Checked = login.prestaServico == 1;

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
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            Bsk.BE.ParticipanteBE participanteBE = new BE.ParticipanteBE();
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
                var cliente = _core.Participante_Get(participanteBE, "IdParticipante=" + login.IdParticipante).FirstOrDefault();
                cliente.Logradouro = rua.Value;
                cliente.cidade = cidade.Value;
                cliente.Nome = nome.Value;
                cliente.Sobrenome = sobrenome.Value;
                cliente.Numero = numero.Value;
                cliente.Telefone = telefone.Value;
                cliente.Uf = uf.Value;
                cliente.Complemento = complemento.Value;
                cliente.Email = email.Value;
                cliente.Cep = cep.Value;
                cliente.Bairro = bairro.Text;
                cliente.Documento = cpf.Value;
                cliente.data = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                cliente.prestaServico = prestaServicos.Checked ? 1 : 0;

                _core.Participante_Update(cliente, "IdParticipante=" + cliente.IdParticipante);


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
                string script = " Swal.fire({\r\n                                text: 'Por favor preencher todos os campos',\r\n                                icon: 'error',\r\n                                 toast: 'true',\r\n                                confirmButtonColor: '#f08f00',\r\n                                confirmButtonText: 'Ok'\r\n                            });";
                ClientScript.RegisterStartupScript(this.GetType(), "swal", script, true);
            }


        }
    }
}