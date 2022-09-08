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
    public partial class dashboard : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CotacaoListaFronecedorModel> PegaCotacoes()
        {
            var l = Request.Cookies["loginFornecedor"].Value;
            var login = Funcoes.PegaLoginFornecedor(l);
            var cotCliente = _core.CotacaoFornecedorGet($" CF.IdFornecedor=" + login.IdFornecedor + " order by DataAlteracao desc") ;
            return cotCliente;
        }
    }
}