using Bsk.BE;
using Bsk.Interface;
using Bsk.Site.Admin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Geral
{
    public partial class confirmacaoemailfornecedor
        : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get the GUID from the URL query string.
                string guid = Request.QueryString["guid"];

                if (!string.IsNullOrEmpty(guid))
                {
                    // Use the GUID as needed in your application, for example:
                    var fornecedor = _core.Fornecedor_Get(_FornecedorBE, "GuidColumn= '" + guid+ "'").FirstOrDefault();
                    fornecedor.Confirmado = 1;
                    _core.Fornecedor_Update(fornecedor, "IdFornecedor = " + fornecedor.IdFornecedor);
                }
                else
                {
                    mensagem.Text = "No GUID found in URL.";
                }
            }
        }
    }
}
