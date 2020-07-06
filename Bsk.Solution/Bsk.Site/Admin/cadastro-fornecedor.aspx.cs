using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Admin
{
    using Bsk.BE;
    using Bsk.Interface;
    using Bsk.Site.Fornecedor;
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class cadastro_fornecedor : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {

            if(!IsPostBack)
            {
                CarregaFornecedor();
            }

        }

        public void CarregaFornecedor()
        {
            if (!String.IsNullOrEmpty(Request.QueryString["IdFornecedor"]))
            {
                var Fornecedor = _core.Fornecedor_Get(_FornecedorBE, $" IdFornecedor={Request.QueryString["IdFornecedor"]}").FirstOrDefault();

                if(Fornecedor!=null)
                {
                    cnpj.Value = Fornecedor.Cnpj;
                    RazaoSocial.Value = Fornecedor.RazaoSocial;
                    NomeFantasia.Value = Fornecedor.NomeFantasia;
                    Status.InnerText = (Fornecedor.Status == "1")?"ATIVO":"INATIVO";
                    Telefone.Value = Fornecedor.Telefone;
                    Responsavel.Value = Fornecedor.Responsavel;
                    WhatsApp.Value = Fornecedor.WhatsApp;
                }
            }
        }

        protected void Status_ServerClick(object sender, EventArgs e)
        {

            if (!String.IsNullOrEmpty(Request.QueryString["IdFornecedor"]))
            {
                var Fornecedor = _core.Fornecedor_Get(_FornecedorBE, $" IdFornecedor={Request.QueryString["IdFornecedor"]}").FirstOrDefault();

                if (Fornecedor != null)
                {
                    Fornecedor.Status = (Fornecedor.Status == "1") ? "0" : "1";
                    _core.Fornecedor_Update(Fornecedor, $" IdFornecedor={Request.QueryString["IdFornecedor"]}");
                    CarregaFornecedor();
                }
            }

        }

        protected void btnDeletar_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["IdFornecedor"]))
            {
                var Fornecedor = _core.Fornecedor_Get(_FornecedorBE, $" IdFornecedor={Request.QueryString["IdFornecedor"]}").FirstOrDefault();

                if (Fornecedor != null)
                {
                    _core.Fornecedor_Delete(Fornecedor);
                    Response.Redirect("msg.aspx?Chave=DeletaFornecedor");
                }
            }
        }

        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["IdFornecedor"]))
            {
                var Fornecedor = _core.Fornecedor_Get(_FornecedorBE, $" IdFornecedor={Request.QueryString["IdFornecedor"]}").FirstOrDefault();

                if (Fornecedor != null)
                {
                    Fornecedor.Cnpj = cnpj.Value;
                    Fornecedor.RazaoSocial = RazaoSocial.Value ;
                    Fornecedor.NomeFantasia = NomeFantasia.Value ;
                    Fornecedor.Telefone = Telefone.Value;
                    Fornecedor.Responsavel = Responsavel.Value;
                    Fornecedor.WhatsApp = WhatsApp.Value ;
                    _core.Fornecedor_Update(Fornecedor, $" IdFornecedor={Request.QueryString["IdFornecedor"]}");
                    Response.Redirect("msg.aspx?Chave=AtualizaFornecedor");
                }
            }
        }
    }
}