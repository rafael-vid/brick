using Bsk.BE;
using Bsk.BE.Pag;
using Bsk.Site.Admin;
using Bsk.Site.Geral;
using Bsk.Util;
using K4os.Compression.LZ4.Encoders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{

    public partial class pagamento_cartao : System.Web.UI.Page
    {
        Bsk.Interface.core _core = new Interface.core();
        Bsk.BE.SolicitacaoBE SolicitacaoBE = new BE.SolicitacaoBE();
        Bsk.BE.CotacaoBE CotacaoBE = new BE.CotacaoBE();
        BskPag bskPag = new BskPag();
        Bsk.BE.ClienteBE clienteBE = new Bsk.BE.ClienteBE();
        Bsk.BE.FornecedorBE fornecedorBE = new Bsk.BE.FornecedorBE();
        Bsk.BE.ParticipanteBE participanteBE = new Bsk.BE.ParticipanteBE();

        protected void Page_Load(object sender, EventArgs e)
        {
                    var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
                    var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
                    nrcotacao.InnerText = cotacao.IdSolicitacao.ToString();
                    if (cotacao.Status != Bsk.Util.StatusCotacao.AguardandoPagamento)
                    {
                        Response.Redirect("minhas-cotacoes.aspx");
                    }
                    var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
                    var participante = _core.Participante_Get(participanteBE, "IdParticipante=" + login.IdParticipante).FirstOrDefault();
                    if (Request.QueryString["Deleta"] != null)
                    {
                        participante.MeioPagamento = "";
                        _core.Participante_Update(participante, "IdParticipante="+participante.IdParticipante);
                        Response.Redirect("pagamento-cartao.aspx?Id="+Request.QueryString["Id"]);
                    }

                    if (!IsPostBack)
                    {
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
                        valor.InnerText = String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor);


                        if (!String.IsNullOrEmpty(participante.MeioPagamento))
                        {
                            preencheDadosCartao(participante);
                        }
                        else
                        {
                            divCartao.Visible = false;
                        }

                    }
            
        }

        private void preencheDadosCartao(ParticipanteBE participante)
        {
            var ret = bskPag.ConsultaMeioPagamento(participante);
            var retApi = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(ret);
            try
            {
                numeroCartao.Value = "**** **** **** " + retApi["ultimosDigitos"] + "      (" + retApi["bandeira"] + ")";
                mes.Value = retApi["mes"];
                ano.Value = retApi["ano"];
                nomeCartao.Value = retApi["nome"];
                codigo.Value = "***";
                numeroCartao.Disabled = true;
                mes.Disabled = true;
                ano.Disabled = true;
                codigo.Disabled = true;
                nomeCartao.Disabled = true;
            }
            catch (Exception)
            {
            }
        }

        protected void btnPagamento_ServerClick(object sender, EventArgs e)
        {
            lbMsg.InnerText = "";
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
            var participanteCliente = _core.Participante_Get(participanteBE, "IdParticipante=" + cotacao.IdParticipante).FirstOrDefault();
            if (validaCartao())
            {
                if (valor.InnerText != String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor))
                {
                    lbMsg.InnerText = "Oops, parece que algém alterou algum dado da transação, confira os valores e tente novamente.";
                }
                else
                {
                    BskPag bskPag = new BskPag();
                    clienteBE = new Bsk.BE.ClienteBE();
                    fornecedorBE = new Bsk.BE.FornecedorBE();
                    participanteBE = new Bsk.BE.ParticipanteBE();
                    var fornecedor = _core.Participante_Get(participanteBE, "IdParticipante=" + cotacaoFornecedor.IdParticipante).FirstOrDefault();

                    string guidTransacao = Guid.NewGuid().ToString();
                    var vencimento = DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString("yyyy-MM-dd");

                    if (String.IsNullOrEmpty(participanteCliente.ZoopID))
                    {
                        Endereco endereco = new Endereco()
                        {
                            Bairro = participanteCliente.Bairro,
                            Cep = participanteCliente.Cep,
                            Cidade = participanteCliente.cidade,
                            Complemento = participanteCliente.Complemento,
                            Estado = participanteCliente.Uf,
                            Logradouro = participanteCliente.Logradouro,
                            Numero = participanteCliente.Numero,
                            Pais = "BR",
                            UF = participanteCliente.Uf,
                            IdUsuario = participanteCliente.IdParticipante
                        };

                        Usuario usuario = new Usuario()
                        {
                            IdCliente = participanteCliente.IdParticipante.ToString(),
                            BskPagID = participanteCliente.ZoopID,
                            CPF = participanteCliente.Documento,
                            DataAlteracao = DateTime.Now,
                            DataNascimento = DateTime.Parse("01/01/1990"),
                            Email = participanteCliente.Email,
                            Nome = participanteCliente.Nome,
                            Telefone = participanteCliente.Telefone
                        };

                        usuario.Enderecos = new List<Endereco>();
                        usuario.Enderecos.Add(endereco);

                        participanteCliente.ZoopID = bskPag.CadastrarComprador(usuario, fornecedor.SellerID);

                        //var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(cliente.ZoopID);

                        //cliente.ZoopID = ret["codigo"];

                        if (participanteCliente.ZoopID != "" && participanteCliente.ZoopID != "Erro")
                        {
                            _core.Participante_Update(participanteCliente, "IdParticipante=" + cotacao.IdParticipante);

                        }
                    }

                    if (!String.IsNullOrEmpty(participanteCliente.ZoopID))
                    {
                        if (String.IsNullOrEmpty(participanteCliente.MeioPagamento))
                        {
                            var cadastraCartao = bskPag.cadastraCartao(nomeCartao.Value, numeroCartao.Value, codigo.Value, mes.Value, ano.Value, participanteCliente.IdParticipante .ToString(), fornecedor.SellerID);
                            if (!cadastraCartao.Contains("erro"))
                            {
                                participanteCliente.MeioPagamento = cadastraCartao;
                                _core.Participante_Update(participanteCliente, "IdParticipante=" + participanteCliente.IdParticipante);
                            }
                            else
                            {
                                participanteCliente.MeioPagamento = "";
                            }

                        }


                        if (String.IsNullOrEmpty(participanteCliente.MeioPagamento))
                        {
                            lbMsg.InnerText = "Cartão inválido.";
                        }
                        else
                        {
                            //var retTran = bskPag.Transacao(cliente, vencimento, guidTransacao, "1", "C", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);
                            //var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(retTran);

                            string status = "";
                            string url = "";
                            //if (ret["status"] == "200")
                            //{
                                status = "1";
                            string script = @"
                                Swal.fire({
                                    text: 'Pagamento efetuado com sucesso',
                                    icon: 'success',
                                    confirmButtonColor: '#f08f00',
                                    confirmButtonText: 'Ok',
                                    customClass: {
                                        popup: 'swal-wide',
                                        title: 'swal-title',
                                        content: 'swal-text'
                                    }
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.href = 'pagamento.aspx?Id=" + cotacao.IdCotacao + @"';
                                    }
                                });
                            ";

                            ClientScript.RegisterStartupScript(this.GetType(), "swal", script, true);

                            //}
                            //else
                            //{
                            //    status = "3";
                            //}

                            Bsk.BE.TransacaoBE transacaoBE = new Bsk.BE.TransacaoBE()
                            {
                                Boleto = "",
                                DataEnvio = DateTime.Now.ToString("yyyy-MM-dd"),
                                DataVencimento = vencimento,
                                GuidTransacao = guidTransacao,
                                IdSolicitacao = cotacao.IdSolicitacao,
                                Observacao = $"Pagamento {cotacao.Titulo}",
                                ObservacaoStatus = "",
                                Parcelas = 1,
                                Status = status,
                                TipoPagamento = "Boleto",
                                Url = url,
                                IdExterno = Guid.NewGuid().ToString() //ret["codigo"]
                            };

                            if (status == "1")
                            {
                                _core.Transacao_Insert(transacaoBE);
                                cotacao.Status = StatusCotacao.EmAndamento;
                                _core.Cotacao_Update(cotacao, "IdSolicitacao=" + cotacao.IdSolicitacao);
                                //Response.Redirect("pagamento.aspx?Id=" + cotacao.IdCotacao);
                            }
                            //else
                            //{
                            //lbMsg.InnerText = msg;//ret["mensagem"].ToString().Split(';')[0];
                            //}
                        }
                    }
                    else
                    {
                        lbMsg.InnerText = "Não foi possível completar a transação. Por favor confira seus dados cadastrais e tente novamente.";
                    }
                }
            }
            else 
            { 
                lbMsg.InnerText = "Cartão inválido";
            }
                
        }

        private bool validaCartao()
        {
            // Obtém os valores dos campos preenchidos pelo usuário
            string cardNumber = numeroCartao.Value;
            string expiryMonth = mes.Value;
            string expiryYear = ano.Value;

            // Verifica se os campos obrigatórios foram preenchidos
            if (string.IsNullOrEmpty(cardNumber) || string.IsNullOrEmpty(expiryMonth) || string.IsNullOrEmpty(expiryYear))
            {
                return false; // Campos obrigatórios não preenchidos
            }

            // Converte os valores de mês e ano para inteiros
            if (!int.TryParse(expiryMonth, out int month) || !int.TryParse(expiryYear, out int year))
            {
                return false; // Mês ou ano inválidos
            }

            // Verifica se o número do cartão é válido usando o algoritmo de Luhn
            bool isValidNumber = CardUtils.IsCardNumberValid(cardNumber);

            // Verifica se a data de expiração é válida
            bool isValidExpiry = CardUtils.IsExpiryValid(month, year);

            // Opcional: Identifica o tipo do cartão
            string cardType = CardUtils.GetCardType(cardNumber);

            // Retorna true apenas se todas as validações forem bem-sucedidas
            return isValidNumber && isValidExpiry;
        }



        protected void btnAlterar_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("perfil.aspx?Red=pagamento-cartao&Id=" + Request.QueryString["Id"]);
        }
    }
    public class CardUtils
    {
        public static bool IsCardNumberValid(string cardNumber)
        {
            if (string.IsNullOrWhiteSpace(cardNumber) || !cardNumber.All(char.IsDigit))
            {
                return false; // Verifica se o número do cartão é nulo, vazio ou contém caracteres não numéricos
            }

            int sum = 0;
            bool doubleDigit = false;

            // Itera pelos dígitos do cartão da direita para a esquerda
            for (int i = cardNumber.Length - 1; i >= 0; i--)
            {
                int digit = int.Parse(cardNumber[i].ToString());

                if (doubleDigit)
                {
                    digit *= 2;
                    if (digit > 9)
                    {
                        digit -= 9; // Subtrai 9 se o valor for maior que 9
                    }
                }

                sum += digit;
                doubleDigit = !doubleDigit; // Alterna entre dobrar ou não o próximo dígito
            }

            return (sum % 10 == 0); // Retorna true se a soma for múltiplo de 10
        }


        public static bool IsExpiryValid(int month, int year)
        {
            DateTime lastDayOfMonth = new DateTime(year, month, DateTime.DaysInMonth(year, month));
            return DateTime.Now <= lastDayOfMonth;
        }

        public static string GetCardType(string cardNumber)
        {
            if (!string.IsNullOrEmpty(cardNumber))
            {
                switch (cardNumber[0])
                {
                    case '4': return "Visa";
                    case '5': return "MasterCard";
                    // Add more cases as needed
                    default: return "Unknown";
                }
            }
            return "Invalid";
        }
    }
}