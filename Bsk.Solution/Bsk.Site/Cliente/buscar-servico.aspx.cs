using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class buscar_servico : System.Web.UI.Page
    {
        core _core = new core();
        CategoriaBE CategoriaBE = new CategoriaBE();
        ServicoBE ServicoBE = new ServicoBE();
        AreaFornecedorBE AreaFornecedorBE = new AreaFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["CatSel"]))
            {
                var servi = _core.Servico_Get(ServicoBE, $" Nome like '%{Request.QueryString["CatSel"]}%'");
                string categorias = "";
                if (servi.Count > 0)
                {
                    foreach (var item in servi)
                    {
                        categorias += item.IdCategoria + ",";
                    }
                    Response.Redirect("buscar-servico.aspx?Cat=" + categorias + "0");
                }
                else
                {
                    Response.Redirect("buscar-servico.aspx?Cat=0");
                }
            }
        }
        public List<ServicoBE> PegaServicoTodos(CategoriaBE categoria)
        {
            List<ServicoBE> servicos = new List<ServicoBE>();
            ServicoBE servicoBE = new ServicoBE();
            servicos = _core.Servico_Get(servicoBE, "IdCategoria=" + categoria.IdCategoria);
            return servicos;
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