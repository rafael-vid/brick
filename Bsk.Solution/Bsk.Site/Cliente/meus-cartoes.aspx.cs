using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class meus_cartoes : System.Web.UI.Page
    {
        core _core = new core();
        CartaoBE _cartaoBE = new CartaoBE();

        protected string SelectedId
        {
            get { return (string)(ViewState[nameof(SelectedId)] ?? string.Empty); }
            set { ViewState[nameof(SelectedId)] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCartoes();
                EnsureSelected();
                BindDetalhe();
            }
        }

        private void BindCartoes()
        {
            lvCartoes.DataSource = PegaCartoes();
            lvCartoes.DataBind();
        }

        private void EnsureSelected()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                SelectedId = Request.QueryString["id"];

            if (string.IsNullOrEmpty(SelectedId))
            {
                var first = PegaCartoes().FirstOrDefault();
                if (first != null) SelectedId = first.Id.ToString();
            }
        }

        private void BindDetalhe()
        {
            var card = GetSelected();
            if (card == null) { ClearDetail(); return; }

            lblNomeCartao.Text = card.NomeCartao;
            lblNumeroMascarado.Text = Mascara(card.NumeroCartao);
            lblTitular.Text = card.NomeTitular;
            lblExp.Text = $"Expira {card.MesExpiracao:00}/{card.AnoExpiracao}";
        }

        private void ClearDetail()
        {
            lblNomeCartao.Text = ""; lblNumeroMascarado.Text = ""; lblTitular.Text = ""; lblExp.Text = "";
        }

        public List<CartaoBE> PegaCartoes()
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cartoes = _core.Cartao_Get(_cartaoBE, "IdParticipante= " + login.IdParticipante);
            return cartoes ?? new List<CartaoBE>();
        }

        private CartaoBE GetSelected() => PegaCartoes().FirstOrDefault(c => c.Id.ToString() == SelectedId);

        protected void lvCartoes_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "selectCard")
            {
                SelectedId = e.CommandArgument.ToString();
                BindCartoes();
                BindDetalhe();
            }
        }

        protected void btnRemoverSelected_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(SelectedId)) return;
            _cartaoBE.Id = Convert.ToInt32(SelectedId);
            _core.Cartao_Delete(_cartaoBE);
            SelectedId = string.Empty;

            BindCartoes();
            EnsureSelected();
            BindDetalhe();

            ScriptManager.RegisterStartupScript(this, GetType(), "swalRem", "Swal.fire({icon:'success',title:'Removido',text:'Cartão removido com sucesso!'});", true);
        }

        // Toggle add form
        protected void AbrirModoAdicionar(object sender, EventArgs e)
        {
            areaAdd.Visible = true;
        }
        protected void FecharModoAdicionar(object sender, EventArgs e)
        {
            areaAdd.Visible = false;
        }

        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var novo = new CartaoBE();
            novo.IdParticipante = login.IdParticipante;
            novo.NomeCartao = nomeCartao.Value;
            novo.NomeTitular = nomeTItular.Value;
            novo.NumeroCartao = numeroCartao.Value.Replace(" ", "");
            novo.MesExpiracao = Convert.ToInt32(mes.Value);
            novo.AnoExpiracao = Convert.ToInt32(ano.Value);
            novo.CVV = codigo.Value;

            _core.Cartao_Insert(novo);

            areaAdd.Visible = false;
            BindCartoes();
            EnsureSelected();
            BindDetalhe();

            ScriptManager.RegisterStartupScript(
                this, GetType(), "swalAdd",
                "Swal.fire({icon:'success',title:'Adicionado',text:'Cartão salvo com sucesso!'})" +
                ".then(()=>{  });",
                true
            );
        }

        // Helpers used in binding
        public string Últimos4(object numero)
        {
            var n = (numero ?? string.Empty).ToString();
            if (n.Length <= 4) return n;
            return n.Substring(n.Length - 4);
        }
        private string Mascara(string numero)
        {
            if (string.IsNullOrWhiteSpace(numero)) return string.Empty;
            var last4 = numero.Length >= 4 ? numero.Substring(numero.Length - 4) : numero;
            return $"•••• •••• •••• {last4}";
        }
    }
}