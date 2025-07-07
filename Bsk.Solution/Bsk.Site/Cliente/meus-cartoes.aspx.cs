using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class meus_cartoes : System.Web.UI.Page
    {
        core _core = new core();
        CartaoBE _cartaoBE = new CartaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rptCartoes.DataSource = PegaCartoes();
                rptCartoes.DataBind();
            }
        }
        public List<CartaoBE> PegaCartoes()
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cartoes = _core.Cartao_Get(_cartaoBE, "IdParticipante= " + login.IdParticipante);

            return cartoes;
        }
        public void RemoverCartao(object sender, EventArgs e)
        {
            var Id = Convert.ToInt32(((LinkButton)sender).CommandArgument);
            _cartaoBE.Id = Id;
            _core.Cartao_Delete(_cartaoBE);
            Response.Redirect(Request.RawUrl);
        }
        public void btnAdicionar_ServerClick(object sender, EventArgs e)
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            _cartaoBE.IdParticipante = login.IdParticipante;
            _cartaoBE.NomeCartao = nomeCartao.Value;
            _cartaoBE.NomeTitular = nomeTItular.Value;
            _cartaoBE.NumeroCartao = numeroCartao.Value;
            _cartaoBE.MesExpiracao = Convert.ToInt32(mes.Value);
            _cartaoBE.AnoExpiracao = Convert.ToInt32(ano.Value);
            _cartaoBE.CVV = codigo.Value;
            _core.Cartao_Insert(_cartaoBE);
            Response.Redirect(Request.RawUrl);
        }


    }
}