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
        private readonly PagarMeWalletClient _wallet = new PagarMeWalletClient();
        private List<PagarMeCard> _cards;

        private string CustomerId
        {
            get
            {
                var cookie = Request.Cookies["Login"];
                var login = Funcoes.PegaLoginParticipante(cookie?.Value ?? string.Empty);
                return login.IdParticipante.ToString();
            }
        }

        private List<PagarMeCard> Cards => _cards ?? (_cards = _wallet.ListCards(CustomerId));

        protected string SelectedId
        {
            get { return (string)(ViewState[nameof(SelectedId)] ?? string.Empty); }
            set { ViewState[nameof(SelectedId)] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                _cards = _wallet.ListCards(CustomerId);
                BindCartoes();
                EnsureSelected();
                BindDetalhe();
            }
        }

        private void BindCartoes()
        {
            lvCartoes.DataSource = Cards;
            lvCartoes.DataBind();
            phSemCartoes.Visible = !Cards.Any();
        }

        private void EnsureSelected()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["id"]))
                SelectedId = Request.QueryString["id"];

            if (string.IsNullOrEmpty(SelectedId))
            {
                var first = Cards.FirstOrDefault();
                if (first != null) SelectedId = first.Id;
            }
        }
        private PagarMeCard GetSelected() => Cards.FirstOrDefault(c => c.Id == SelectedId);

        private void BindDetalhe()
        {
            var card = GetSelected();
            if (card == null)
            {
                ClearDetail();
                return;
            }

            lblNomeCartao.Text = card.Brand;
            lblNumeroMascarado.Text = Mascara(card.LastFourDigits);
            lblTitular.Text = card.HolderName;
            lblExp.Text = $"Expira {card.ExpMonth:00}/{card.ExpYear}";
            btnRemover.Visible = true;
        }

        private void ClearDetail()
        {
            lblNomeCartao.Text = ""; lblNumeroMascarado.Text = ""; lblTitular.Text = ""; lblExp.Text = "";
            btnRemover.Visible = false;
        }

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
            _wallet.DeleteCard(CustomerId, SelectedId);
            SelectedId = string.Empty;

            _cards = _wallet.ListCards(CustomerId);
            BindCartoes();
            EnsureSelected();
            BindDetalhe();

            ScriptManager.RegisterStartupScript(this, GetType(), "swalRem", "Swal.fire({icon:'success',title:'Removido',text:'Cartão removido com sucesso!'});", true);
        }

        // Toggle add form
        protected void AbrirModoAdicionar(object sender, EventArgs e)
        {
            nomeTItular.Value = numeroCartao.Value = mes.Value = ano.Value = codigo.Value = string.Empty;
            areaAdd.Visible = true;
        }
        protected void FecharModoAdicionar(object sender, EventArgs e)
        {
            areaAdd.Visible = false;
            nomeTItular.Value = numeroCartao.Value = mes.Value = ano.Value = codigo.Value = string.Empty;
        }

        protected void btnAdicionar_Click(object sender, EventArgs e)
        {
            var req = new PagarMeCardCreateRequest
            {
                HolderName = nomeTItular.Value,
                Number = numeroCartao.Value.Replace(" ", ""),
                ExpMonth = Convert.ToInt32(mes.Value),
                ExpYear = Convert.ToInt32(ano.Value),
                Cvv = codigo.Value
            };

            var added = _wallet.AddCard(CustomerId, req);

            areaAdd.Visible = false;
            nomeTItular.Value = numeroCartao.Value = mes.Value = ano.Value = codigo.Value = string.Empty;

            _cards = _wallet.ListCards(CustomerId);
            SelectedId = added?.Id;
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

        private string Mascara(string last4)
        {
            if (string.IsNullOrWhiteSpace(last4)) return string.Empty;
            return $"•••• •••• •••• {last4}";
        }
    }

}

