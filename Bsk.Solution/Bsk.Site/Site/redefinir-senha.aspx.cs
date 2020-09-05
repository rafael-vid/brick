using Bsk.BE;
using Bsk.Interface;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Site
{
    public partial class redefinir_senha : System.Web.UI.Page
    {
        core _core = new core();
        ClienteBE _ClienteBE = new ClienteBE();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        RedefinirSenhaBE _RedefinirSenhaBE = new RedefinirSenhaBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var senha = _core.RedefinirSenha_Get(_RedefinirSenhaBE, $"Guid='" + Request.QueryString["log"]+"'").FirstOrDefault();

            if (Request.QueryString["Acao"] != null)
            {
                if (Request.QueryString["Acao"] == "Expirado")
                {
                    campos.Visible = false;
                }
            }

            if (senha == null)
            {
                Response.Redirect(ConfigurationManager.AppSettings["host"].ToString());
            }
            else
            {
                DateTime hj = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd"));
                DateTime criacao = DateTime.Parse(senha.DataCriacao);

                if (hj.AddDays(1) < criacao)
                {
                    Response.Redirect(ConfigurationManager.AppSettings["host"].ToString() + "Site/redefinir-senha.aspx?log=" + Request.QueryString["log"] + "&Acao=Expirado");
                }

            }
        }

        protected void btnAltera_ServerClick(object sender, EventArgs e)
        {

            if (String.IsNullOrEmpty(senha1.Value.ToString()) || String.IsNullOrEmpty(senha2.Value.ToString()))
            {
                Response.Redirect(ConfigurationManager.AppSettings["host"].ToString() + "Site/redefinir-senha.aspx?log=" + Request.QueryString["log"] + "&Acao=Campos");
            }
            else if (senha1.Value.ToString() != senha2.Value.ToString())
            {
                Response.Redirect(ConfigurationManager.AppSettings["host"].ToString() + "Site/redefinir-senha.aspx?log=" + Request.QueryString["log"] + "&Acao=Diferentes");
            }
            else
            {
                var senha = _core.RedefinirSenha_Get(_RedefinirSenhaBE, $"Guid='" + Request.QueryString["log"]+"'").FirstOrDefault();
                if (senha.Tipo=="F")
                {
                    var fornecedor = _core.Fornecedor_Get(_FornecedorBE, "IdFornecedor="+senha.Id).FirstOrDefault();
                    fornecedor.Senha = senha1.Value;
                    _core.Fornecedor_Update(fornecedor, "IdFornecedor=" + senha.Id);
                }
                else
                {
                    var cliente = _core.Cliente_Get(_ClienteBE, "IdCliente=" + senha.Id).FirstOrDefault();
                    cliente.Senha = senha1.Value;
                    _core.Cliente_Update(cliente, "IdCliente=" + senha.Id);
                }
                Response.Redirect(ConfigurationManager.AppSettings["host"].ToString() + "Site/redefinir-senha.aspx?log=" + Request.QueryString["log"] + "&Acao=Certo");
            }

        }
    }
}