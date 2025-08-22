using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bsk.BE;
using Bsk.BE.Pag;
using Bsk.Site.Geral;
using Bsk.Util;
using Google.Protobuf.WellKnownTypes;

namespace Bsk.Site.Cliente
{
    public partial class pagamento_cartao : Page
    {
        // Core dependencies
        private readonly Interface.core _core = new Interface.core();
        private readonly SolicitacaoBE SolicitacaoBE = new SolicitacaoBE();
        private readonly CotacaoBE CotacaoBE = new CotacaoBE();
        private readonly BskPag bskPag = new BskPag();
        private ClienteBE clienteBE = new ClienteBE();
        private FornecedorBE fornecedorBE = new FornecedorBE();
        private ParticipanteBE participanteBE = new ParticipanteBE();

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            // Attach data-pagarmecheckout-form attribute to the master form
            if (Page?.Form != null)
            {
                Page.Form.Attributes.Add("data-pagarmecheckout-form", string.Empty);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
            nrcotacao.InnerText = cotacao.IdSolicitacao.ToString();

            if (cotacao.Status != StatusCotacao.AguardandoPagamento)
                Response.Redirect("minhas-cotacoes.aspx");

            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var participante = _core.Participante_Get(participanteBE, "IdParticipante=" + login.IdParticipante).FirstOrDefault();

            if (Request.QueryString["Deleta"] != null)
            {
                participante.MeioPagamento = string.Empty;
                _core.Participante_Update(participante, "IdParticipante=" + participante.IdParticipante);
                Response.Redirect("pagamento-cartao.aspx?Id=" + Request.QueryString["Id"]);
            }

            if (!IsPostBack)
            {
                // Populate user details
                nome.InnerText = participante.Nome;
                email.InnerText = participante.Email;
                cpf.InnerText = participante.Documento;
                telefone.InnerText = participante.Telefone;
                cep.InnerText = participante.Cep;
                rua.InnerText = participante.Logradouro;
                numero.InnerText = participante.Numero;
                complemento.InnerText = participante.Complemento;
                bairro.InnerText = participante.Bairro;
                cidade.InnerText = participante.cidade;
                uf.InnerText = participante.Uf;
                valor.InnerText = string.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor);

                if (!string.IsNullOrEmpty(participante.MeioPagamento))
                    preencheDadosCartao(participante);
                else
                    divCartao.Visible = false;
            }
        }

        private void preencheDadosCartao(ParticipanteBE participante)
        {
            var ret = bskPag.ConsultaMeioPagamento(participante);
            var retApi = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(ret);
            try
            {
                //numeroCartao.Value = $"**** **** **** {retApi.ultimosDigitos} ({retApi.bandeira})";
                //mes.Value = retApi.mes;
                //ano.Value = retApi.ano;
                //nomeCartao.Value = retApi.nome;
                //codigo.Value = "***";
                //numeroCartao.Disabled = mes.Disabled = ano.Disabled = codigo.Disabled = nomeCartao.Disabled = true;
            }
            catch { /* ignore parse errors */ }
        }

        protected void btnPagamento_ServerClick(object sender, EventArgs e)
        {
            lbMsg.InnerText = string.Empty;

            // 1) Retrieve token
            var token = Request.Form["pagarmetoken"];
            if (string.IsNullOrWhiteSpace(token))
            {
                lbMsg.InnerText = "Não foi possível gerar o token do cartão. Tente novamente.";
                return;
            }

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
            var participanteCliente = _core.Participante_Get(participanteBE, "IdParticipante=" + cotacao.IdParticipante).FirstOrDefault();

            // 2) Verify value hasn't changed
            if (valor.InnerText != string.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor))
            {
                lbMsg.InnerText = "Oops, parece que alguém alterou algum dado da transação, confira os valores e tente novamente.";
                return;
            }

            //// 3) Ensure buyer registration
            //if (string.IsNullOrEmpty(participanteCliente.ZoopID))
            //{
            //    var endereco = new Endereco
            //    {
            //        Bairro = participanteCliente.Bairro,
            //        Cep = participanteCliente.Cep,
            //        Cidade = participanteCliente.cidade,
            //        Complemento = participanteCliente.Complemento,
            //        Estado = participanteCliente.Uf,
            //        Logradouro = participanteCliente.Logradouro,
            //        Numero = participanteCliente.Numero,
            //        Pais = "BR",
            //        UF = participanteCliente.Uf,
            //        IdUsuario = participanteCliente.IdParticipante
            //    };
            //    var usuario = new Usuario
            //    {
            //        IdCliente = participanteCliente.IdParticipante.ToString(),
            //        CPF = participanteCliente.Documento,
            //        DataAlteracao = DateTime.Now,
            //        DataNascimento = DateTime.Parse("01/01/1990"),
            //        Email = participanteCliente.Email,
            //        Nome = participanteCliente.Nome,
            //        Telefone = participanteCliente.Telefone,
            //        Enderecos = new List<Endereco> { endereco }
            //    };
            //    participanteCliente.ZoopID = bskPag.CadastrarComprador(usuario, fornecedorBE.SellerID);
            //    if (!string.IsNullOrEmpty(participanteCliente.ZoopID) && participanteCliente.ZoopID != "Erro")
            //    {
            //        _core.Participante_Update(participanteCliente, "IdParticipante=" + participanteCliente.IdParticipante);
            //    }
            //}
            //if (string.IsNullOrEmpty(participanteCliente.ZoopID))
            //{
            //    lbMsg.InnerText = "Não foi possível completar a transação. Por favor confira seus dados cadastrais e tente novamente.";
            //    return;
            //}

            //// 4) Register card via token if not already
            //if (string.IsNullOrEmpty(participanteCliente.MeioPagamento))
            //{
            //    var cadastroResult = bskPag.CadastraCartaoPorToken(token,
            //        participanteCliente.IdParticipante.ToString(), fornecedorBE.SellerID);
            //    if (cadastroResult.Contains("erro"))
            //    {
            //        lbMsg.InnerText = "Cartão inválido.";
            //        return;
            //    }
            //    participanteCliente.MeioPagamento = cadastroResult;
            //    _core.Participante_Update(participanteCliente, "IdParticipante=" + participanteCliente.IdParticipante);
            //}

            // 5) Create transaction
            var guidTransacao = Guid.NewGuid().ToString();
            var vencimento = DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString("yyyy-MM-dd");
            var transacao = new TransacaoBE
            {
                GuidTransacao = guidTransacao,
                IdSolicitacao = cotacao.IdSolicitacao,
                DataEnvio = DateTime.Now.ToString("yyyy-MM-dd"),
                DataVencimento = vencimento,
                Parcelas = 1,
                Status = "1",
                TipoPagamento = "Cartão",
                Observacao = $"Pagamento {cotacao.Titulo}",
                IdExterno = Guid.NewGuid().ToString()
            };
            _core.Transacao_Insert(transacao);
            cotacao.Status = StatusCotacao.EmAndamento;
            _core.Cotacao_Update(cotacao, "IdSolicitacao=" + cotacao.IdSolicitacao);

            // 6) Show success popup and redirect
            var script = @"Swal.fire({
                text: 'Pagamento efetuado com sucesso',
                icon: 'success',
                confirmButtonColor: '#f08f00',
                confirmButtonText: 'Ok',
                customClass: { popup: 'swal-wide', title: 'swal-title', content: 'swal-text' }
            }).then(result => { if (result.isConfirmed) {
                    window.location.href = 'pagamento.aspx?Id=" + cotacao.IdCotacao + @"';
                }});";
            ClientScript.RegisterStartupScript(GetType(), "success", script, true);
        }

        protected void btnAlterar_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("perfil.aspx?Red=pagamento-cartao&Id=" + Request.QueryString["Id"]);
        }
    }
}

// Helper class retained
public static class CardUtils
{
    public static bool IsCardNumberValid(string cardNumber)
    {
        if (string.IsNullOrWhiteSpace(cardNumber) || !cardNumber.All(char.IsDigit))
            return false;
        int sum = 0; bool doubleDigit = false;
        for (int i = cardNumber.Length - 1; i >= 0; i--)
        {
            int digit = int.Parse(cardNumber[i].ToString());
            if (doubleDigit)
            {
                digit *= 2;
                if (digit > 9) digit -= 9;
            }
            sum += digit;
            doubleDigit = !doubleDigit;
        }
        return sum % 10 == 0;
    }

    public static bool IsExpiryValid(int month, int year)
    {
        var lastDay = new DateTime(year, month, DateTime.DaysInMonth(year, month));
        return DateTime.Now <= lastDay;
    }

    public static string GetCardType(string cardNumber)
    {
        if (!string.IsNullOrEmpty(cardNumber))
        {
            switch (cardNumber[0])
            {
                case '4': return "Visa";
                case '5': return "MasterCard";
                default: return "Unknown";
            }
        }
        return "Invalid";
    }
}