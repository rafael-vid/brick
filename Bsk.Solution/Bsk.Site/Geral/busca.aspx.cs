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
    public partial class busca : System.Web.UI.Page
    {
        core _core = new core();
        SolicitacaoBE SolicitacaoBE = new SolicitacaoBE();
        public List<SolicitacaoBE> items = new List<SolicitacaoBE>();

        CategoriaBE CategoriaBE = new CategoriaBE();
        ServicoBE ServicoBE = new ServicoBE();
        AreaFornecedorBE AreaFornecedorBE = new AreaFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["palavra"]))
            {
                var servi = _core.Cotacao_Get(SolicitacaoBE, $" Titulo like '%{Request.QueryString["palavra"]}%'");
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


    }
}
