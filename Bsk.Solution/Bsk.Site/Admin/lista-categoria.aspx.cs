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
    public partial class lista_categoria : System.Web.UI.Page
    {
        core _core = new core();
        CategoriaBE _CategoriaBE = new CategoriaBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CategoriaBE> Categoria()
        {

            return _core.Categoria_Get(_CategoriaBE, null);
        }

    }
}