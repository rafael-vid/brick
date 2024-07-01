using Bsk.BE;
using Bsk.BE.Model;
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
    public partial class cotacao_lista : System.Web.UI.Page
    {
        core _core = new core();
        protected void Page_Load(object sender, EventArgs e)
        {
            nrCotacao.InnerText = Request.QueryString["Id"];
        }

        public List<CotacaoListaFronecedorModel> PegaCotacaoLista()
        {
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            AreaFornecedorBE areaFornecedorBE = new AreaFornecedorBE();
            List<CotacaoListaFronecedorModel> lista = new List<CotacaoListaFronecedorModel>();
            var categorias = _core.AreaFornecedor_Get(areaFornecedorBE,"IdParticipante="+login.IdParticipante);
            string cats = "";
            foreach (var item in categorias)
            {
                cats += item.IdCategoria + ",";
            }
            lista = _core.CotacaoListaFronecedorGet(cats+"0", login.IdParticipante.ToString());

            return lista;
        }
    }
}