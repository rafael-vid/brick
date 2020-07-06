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
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class lista_fornecedor : System.Web.UI.Page
    {
        core _core = new core();
        CategoriaBE _CategoriaBE = new CategoriaBE();
        ServicoBE _ServicoBE = new ServicoBE();
        FornecedorBE _FornecedorBE = new FornecedorBE();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<FornecedorBE> CarregaFornecedor()
        {
            return _core.Fornecedor_Get(_FornecedorBE, null);
        }
    }
}