using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor.Master
{
    public partial class layout : System.Web.UI.MasterPage
    {
        core _core = new core();
        ServicoBE ServicoBE = new ServicoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public FornecedorBE RetornaUsuario()
        {
            HttpCookie login = Request.Cookies["LoginFornecedor"];
            FornecedorBE usuario = new FornecedorBE();
            if (login != null)
            {
                usuario = Funcoes.PegaLoginFornecedor(login.Value);
                return usuario;
            }
            else
            {
                Response.Redirect("default.aspx");
                return usuario;
            }
        }

        protected void btnBuscaCatSel_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(servico.Value))
            {
                var servi = _core.Servico_Get(ServicoBE, $" Nome like '%{servico.Value}%'");
                string categorias = "";
                if (servi.Count > 0)
                {
                    foreach (var item in servi)
                    {
                        categorias += item.IdCategoria + ",";
                    }
                    Response.Redirect("minhas-areas.aspx?Cat=" + categorias + "0");
                }
                else
                {
                    Response.Redirect("minhas-areas.aspx?Cat=0");
                }
            }
            else
            {
                Response.Redirect("minhas-areas.aspx");
            }
        }
    }
}