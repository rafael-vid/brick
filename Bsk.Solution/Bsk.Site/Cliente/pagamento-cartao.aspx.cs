using Bsk.BE;
using Bsk.BE.Pag;
using Bsk.Site.Admin;
using Bsk.Util;
using K4os.Compression.LZ4.Encoders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{

    public partial class pagamento_cartao : System.Web.UI.Page
    {
        Bsk.Interface.core _core = new Interface.core();
        Bsk.BE.CotacaoBE CotacaoBE = new BE.CotacaoBE();
        Bsk.BE.CotacaoFornecedorBE CotacaoFornecedorBE = new BE.CotacaoFornecedorBE();
        BskPag bskPag = new BskPag();
        Bsk.BE.ClienteBE clienteBE = new Bsk.BE.ClienteBE();
        Bsk.BE.FornecedorBE fornecedorBE = new Bsk.BE.FornecedorBE();

        protected void Page_Load(object sender, EventArgs e)
        {
                    var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
                    var cotacao = _core.Cotacao_Get(CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();
                    nrcotacao.InnerText = cotacao.IdCotacao.ToString();
                    if (cotacao.Status != Bsk.Util.StatusCotacao.AguardandoPagamento)
                    {
                        Response.Redirect("minhas-cotacoes.aspx");
                    }
                    var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
                    var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + login.IdCliente).FirstOrDefault();
                    if (Request.QueryString["Deleta"] != null)
                    {
                        cliente.MeioPagamento = "";
                        _core.Cliente_Update(cliente, "IdCliente="+cliente.IdCliente);
                        Response.Redirect("pagamento-cartao.aspx?Id="+Request.QueryString["Id"]);
                    }

                    if (!IsPostBack)
                    {
                        nome.InnerText = login.Nome;
                        email.InnerText = login.Email;
                        cpf.InnerText = login.Cnpj;
                        telefone.InnerText = login.Telefone;
                        cep.InnerText = login.Cep;
                        rua.InnerText = login.Logradouro;
                        numero.InnerText = login.Numero;
                        complemento.InnerText = login.Complemento;
                        bairro.InnerText = login.Bairro;
                        cidade.InnerText = login.Municipio;
                        uf.InnerText = login.Uf;
                        valor.InnerText = String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor);


                        if (!String.IsNullOrEmpty(cliente.MeioPagamento))
                        {
                            preencheDadosCartao(cliente);
                        }
                        else
                        {
                            divCartao.Visible = false;
                        }

                    }
            
        }

        private void preencheDadosCartao(ClienteBE cliente)
        {
            var ret = bskPag.ConsultaMeioPagamento(cliente);
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
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();
            var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();
            if (validaCartao(cliente))
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
                    var fornecedor = _core.Fornecedor_Get(fornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdFornecedor).FirstOrDefault();

                    string guidTransacao = Guid.NewGuid().ToString();
                    var vencimento = DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString("yyyy-MM-dd");

                    if (String.IsNullOrEmpty(cliente.ZoopID))
                    {
                        Endereco endereco = new Endereco()
                        {
                            Bairro = cliente.Bairro,
                            Cep = cliente.Cep,
                            Cidade = cliente.Municipio,
                            Complemento = cliente.Complemento,
                            Estado = cliente.Uf,
                            Logradouro = cliente.Logradouro,
                            Numero = cliente.Numero,
                            Pais = "BR",
                            UF = cliente.Uf,
                            IdUsuario = cliente.IdCliente
                        };

                        Usuario usuario = new Usuario()
                        {
                            IdCliente = cliente.IdCliente.ToString(),
                            BskPagID = cliente.ZoopID,
                            CPF = cliente.Cnpj,
                            DataAlteracao = DateTime.Now,
                            DataNascimento = DateTime.Parse("01/01/1990"),
                            Email = cliente.Email,
                            Nome = cliente.Nome,
                            Telefone = cliente.Telefone
                        };

                        usuario.Enderecos = new List<Endereco>();
                        usuario.Enderecos.Add(endereco);

                        cliente.ZoopID = bskPag.CadastrarComprador(usuario, fornecedor.SellerID);

                        //var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(cliente.ZoopID);

                        //cliente.ZoopID = ret["codigo"];

                        if (cliente.ZoopID != "" && cliente.ZoopID != "Erro")
                        {
                            _core.Cliente_Update(cliente, "IdCliente=" + cotacao.IdCliente);

                        }
                    }

                    if (!String.IsNullOrEmpty(cliente.ZoopID))
                    {
                        if (String.IsNullOrEmpty(cliente.MeioPagamento))
                        {
                            var cadastraCartao = bskPag.cadastraCartao(nomeCartao.Value, numeroCartao.Value, codigo.Value, mes.Value, ano.Value, cliente.IdCliente.ToString(), fornecedor.SellerID);
                            if (!cadastraCartao.Contains("erro"))
                            {
                                cliente.MeioPagamento = cadastraCartao;
                                _core.Cliente_Update(cliente, "IdCliente=" + cliente.IdCliente);
                            }
                            else
                            {
                                cliente.MeioPagamento = "";
                            }

                        }


                        if (String.IsNullOrEmpty(cliente.MeioPagamento))
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
                            var msg = "pagamento efetuado com sucesso";//ret["mensagem"].ToString();
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
                                IdCotacao = cotacao.IdCotacao,
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
                                _core.Cotacao_Update(cotacao, "IdCotacao=" + cotacao.IdCotacao);
                                Response.Redirect("pagamento.aspx?Id=" + cotacao.IdCotacaoFornecedor);
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

        private bool validaCartao(BE.ClienteBE cliente)
        {
            //if (!String.IsNullOrEmpty(cliente.MeioPagamento))
            //{
            //    var retApi = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(bskPag.ConsultaMeioPagamento(cliente));
            //    string cardNumber = retApi["numeroCompleto"];
            //   int month = int.Parse(retApi["mes"]);
            //    int year = int.Parse(retApi["ano"]);
            //
            //    bool isValidNumber = CardUtils.IsCardNumberValid(cardNumber);
            //    bool isValidExpiry = CardUtils.IsExpiryValid(month, year);
            //    string cardType = CardUtils.GetCardType(cardNumber);
            //
            // Optionally check for a specific card type
            // bool isExpectedType = cardType == "Visa";

            //    return isValidNumber && isValidExpiry; // && isExpectedType;
            //}
            //return false;
            return true;
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
            int sum = 0;
            bool alternate = false;

            for (int i = cardNumber.Length - 1; i >= 0; i--)
            {
                char[] digits = cardNumber.ToCharArray();
                int n = int.Parse(digits[i].ToString());

                if (alternate)
                {
                    n *= 2;
                    if (n > 9)
                    {
                        n = (n % 10) + 1;
                    }
                }
                sum += n;
                alternate = !alternate;
            }
            return (sum % 10 == 0);
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