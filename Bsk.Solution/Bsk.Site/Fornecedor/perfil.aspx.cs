using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    public partial class perfil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var login = Funcoes.PegaLoginFornecedor(Request.Cookies["loginFornecedor"].Value);
                nome.Value = login.NomeFantasia;
                email.Value = login.Email;
                cpf.Value = login.Cnpj;
                telefone.Value = login.Telefone;
                cep.Value = login.Cep;
                rua.Value = login.Logradouro;
                numero.Value = login.Numero;
                complemento.Value = login.Complemento;
                bairro.Value = login.Bairro;
                cidade.Value = login.Municipio;
                uf.Value = login.Uf;
            }
        }

        protected void btnAlterar_ServerClick(object sender, EventArgs e)
        {
            var login = Funcoes.PegaLoginFornecedor(Request.Cookies["loginFornecedor"].Value);
            Bsk.BE.FornecedorBE clienteBE = new BE.FornecedorBE();
            Bsk.Interface.core _core = new Interface.core();
            var cliente = _core.Fornecedor_Get(clienteBE, "IdCliente=" + login.IdFornecedor).FirstOrDefault();
            cliente.Logradouro = rua.Value;
            cliente.Municipio = cidade.Value;
            cliente.NomeFantasia = nome.Value;
            cliente.Numero = numero.Value;
            cliente.Telefone = telefone.Value;
            cliente.Uf = uf.Value;
            cliente.Complemento = complemento.Value;
            cliente.Email = email.Value;
            cliente.Cep = cep.Value;
            cliente.Bairro = bairro.Value;
            cliente.Cnpj = cpf.Value;
            _core.Fornecedor_Update(cliente, "IdFornecedor=" + cliente.IdFornecedor);


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
                HttpCookie lg = new HttpCookie("loginFornecedor");
                cliente.Senha = "xxx";
                lg.Value = Newtonsoft.Json.JsonConvert.SerializeObject(cliente);


                Response.Cookies.Add(lg);
            }
        }
    }
}