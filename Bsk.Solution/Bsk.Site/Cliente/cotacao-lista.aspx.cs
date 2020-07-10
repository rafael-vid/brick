using Bsk.BE.Model;
using Bsk.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class cotacao_lista : System.Web.UI.Page
    {
        core _core = new core();
        protected void Page_Load(object sender, EventArgs e)
        {
            nrCotacao.InnerText = Request.QueryString["Id"];
        }

        public List<CotacaoListaModel> PegaCotacaoLista()
        {
            List<CotacaoListaModel> lista = new List<CotacaoListaModel>();

            lista = _core.CotacaoListaGet(Request.QueryString["Id"]);
            return lista;
        }
    }
}