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
    public partial class busca : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE CotacaoBE = new CotacaoBE();
        List<CotacaoBE> items = new List<CotacaoBE>();

        CategoriaBE CategoriaBE = new CategoriaBE();
        ServicoBE ServicoBE = new ServicoBE();
        AreaFornecedorBE AreaFornecedorBE = new AreaFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["palavra"]))
            {
                var servi = _core.Cotacao_Get(CotacaoBE, $" Titulo like '%{Request.QueryString["palavra"]}%'");
                items = servi;
                string categorias = "";
                if (servi.Count > 0)
                {
                    foreach (var item in servi)
                    {
                        categorias += item.IdCategoria + ",";
                    }
                    //Response.Redirect("minhas-areas.aspx?Cat=" + categorias + "0");
                }
                else
                {
                    //Response.Redirect("minhas-areas.aspx?Cat=0");
                }
            }
            else
            {
                Response.Redirect("minhas-areas.aspx");
            }

        }

        public List<CategoriaBE> BuscaAreas()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var af = _core.AreaFornecedor_Get(AreaFornecedorBE, "IdFornecedor="+login.IdFornecedor);
            string filtro = "";
            foreach (var item in af)
            {
                filtro += item.IdCategoria+",";
            }
            return _core.Categoria_Get(CategoriaBE, $" IdCategoria in ({filtro}0)");
        }

        public List<CategoriaBE> BuscaCategoria()
        {
            if (Request.QueryString["Cat"] != null)
            {
                return _core.Categoria_Get(CategoriaBE, $" IdCategoria in ({Request.QueryString["Cat"]})");
            }
            else
            {
                return _core.Categoria_Get(CategoriaBE, "1=1");
            }

        }       
    }
}