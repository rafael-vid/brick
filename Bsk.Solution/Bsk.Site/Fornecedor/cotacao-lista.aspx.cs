using Bsk.BE.Model;
using Bsk.Interface;
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

        public List<CotacaoListaModel> PegaCotacaoLista()
        {
            List<CotacaoListaModel> lista = new List<CotacaoListaModel>();

            lista = _core.CotacaoListaGet(Request.QueryString["Id"]);

            Bsk.BE.CotacaoBE cotacaoBE = new BE.CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + lista[0].CotacaoId).FirstOrDefault();

            if (cotacao.IdCotacaoFornecedor != 0)
            {
                List<CotacaoListaModel> listaCT = new List<CotacaoListaModel>();

                foreach (var item in lista)
                {
                    if (item.CotacaoFornecedorId == cotacao.IdCotacaoFornecedor)
                    {
                        listaCT.Add(item);
                    }
                }
                return listaCT;
            }
            else
            {
                return lista;
            }
        }
    }
}