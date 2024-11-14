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
    public partial class teste : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Bsk.Util.API api = new Bsk.Util.API();

            
            //api.GetLogin();
        }


    }
}
