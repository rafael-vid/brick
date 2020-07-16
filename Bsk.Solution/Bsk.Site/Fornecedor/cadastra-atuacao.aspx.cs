using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    public partial class cadastra_atuacao : System.Web.UI.Page
    {
        core _core = new core();
        AreaFornecedorBE AreaFornecedorBE = new AreaFornecedorBE();
        ServicoBE ServicoBE = new ServicoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Del"] != null)
            {
                FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
                var cat = _core.AreaFornecedor_Get(AreaFornecedorBE, $"IdCategoria={Request.QueryString["Id"]} AND IdFornecedor={login.IdFornecedor} ").FirstOrDefault();
                cat.IdServico = cat.IdServico.Replace($"{Request.QueryString["Del"]},", "");
                _core.AreaFornecedor_Update(cat, "IdAreaFornecedor=" + cat.IdAreaFornecedor);

                Response.Redirect("cadastra-atuacao.aspx?Id=" + Request.QueryString["Id"]);
            }

            if (!IsPostBack)
            {
                ServicoBE servicoBE = new ServicoBE();
                var atuacoes = _core.Servico_Get(servicoBE, "IdCategoria=" + Request.QueryString["Id"]);
                slcAtu.DataSource = atuacoes;
                slcAtu.DataTextField = "Nome";
                slcAtu.DataValueField = "IdServico";
                slcAtu.DataBind();
            }

        }

        public List<Bsk.BE.ServicoBE> PegaServico()
        {
            List<ServicoBE> servicos = new List<ServicoBE>();
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cat = _core.AreaFornecedor_Get(AreaFornecedorBE, $"IdCategoria={Request.QueryString["Id"]} AND IdFornecedor={login.IdFornecedor} ").FirstOrDefault();
            if (cat != null)
            {
                servicos = _core.Servico_Get(ServicoBE, $"IdServico in ({cat.IdServico}0)");
            }
            return servicos;
        }

        public CategoriaBE PegaCategoria()
        {
            CategoriaBE categoriaBE = new CategoriaBE();
            return _core.Categoria_Get(categoriaBE, "IdCategoria=" + Request.QueryString["Id"]).FirstOrDefault();
        }

        protected void btnAdicionar_ServerClick(object sender, EventArgs e)
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cat = _core.AreaFornecedor_Get(AreaFornecedorBE, $"IdCategoria={Request.QueryString["Id"]} AND IdFornecedor={login.IdFornecedor} ").FirstOrDefault();
            if (cat!=null)
            {
                cat.IdServico += slcAtu.Value + ",";
                _core.AreaFornecedor_Update(cat, "IdAreaFornecedor="+cat.IdAreaFornecedor);
            }
            else
            {
                AreaFornecedorBE areaFornecedorBE = new AreaFornecedorBE()
                {
                    IdCategoria = int.Parse(Request.QueryString["Id"]),
                    IdFornecedor = login.IdFornecedor,
                    IdServico = slcAtu.Value + ","
                };

                _core.AreaFornecedor_Insert(areaFornecedorBE);

            }
            Response.Redirect("cadastra-atuacao.aspx?Id="+Request.QueryString["Id"]);
        }
    }
}