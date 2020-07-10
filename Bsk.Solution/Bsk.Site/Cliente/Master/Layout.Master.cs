using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente.Master
{
    using Bsk.Util;
    using Bsk.Interface.Helpers;
    using Bsk.Interface;
    using Bsk.BE;
    using System.Net.Configuration;
    using Newtonsoft.Json;
    public partial class Layout : System.Web.UI.MasterPage
    {
        core _core = new core();
        MasterBE _MasterBE = new MasterBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public MasterBE RetornaUsuario()
        {
            HttpCookie login = Request.Cookies["login"];
            MasterBE usuario = new MasterBE();
            if (login != null)
            {
                usuario = Newtonsoft.Json.JsonConvert.DeserializeObject<MasterBE>(login.Value.ToString());
                return usuario;
            }
            else
            {
                Response.Redirect("default.aspx");
                return usuario;
            }
        }
    }
}