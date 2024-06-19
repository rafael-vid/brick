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
        CotacaoBE CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public ParticipanteBE RetornaUsuario()
        {
            HttpCookie login = Request.Cookies["login"];
            ParticipanteBE usuario = new ParticipanteBE();
            if (login != null)
            {
                usuario = Funcoes.PegaLoginParticipante(login.Value);
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
            Response.Redirect("busca.aspx?palavra=" + servico.Value);
            
            
        }
    }
}