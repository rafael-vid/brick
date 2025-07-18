using Bsk.BE;
using Bsk.BE.Pag;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using Newtonsoft.Json;
using System.Threading.Tasks;


namespace Bsk.Site.Cliente
{
    public class LastTransaction
    {
        public string pdf { get; set; }
    }

    public class Charge
    {
        public LastTransaction last_transaction { get; set; }
    }

    public class OrderResponse
    {
        public List<Charge> charges { get; set; }
    }

    public partial class pagamento_boleto : System.Web.UI.Page
    {
        Bsk.Interface.core _core = new Interface.core();
        Bsk.BE.SolicitacaoBE SolicitacaoBE = new BE.SolicitacaoBE();
        Bsk.BE.CotacaoBE CotacaoBE = new BE.CotacaoBE();
        BskPag bskPag = new BskPag();
        ClienteBE clienteBE = new ClienteBE();
        FornecedorBE fornecedorBE = new FornecedorBE();
        ParticipanteBE participanteBE = new ParticipanteBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Session["ApiResponse"] != null)
            {
                lblApiResponse.Text = Session["ApiResponse"].ToString();
                Session.Remove("ApiResponse");
            }

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
            nrcotacao.InnerText = cotacao.IdSolicitacao.ToString();
            if (cotacao.Status != Bsk.Util.StatusCotacao.AguardandoPagamento)
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }

            if (!IsPostBack)
            {
                var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
                nomeBol.InnerText = login.Nome;
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
            }
        }

        protected async void btnGerar_ServerClick(object sender, EventArgs e)

        {
            lbMsg.InnerText = "";
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();

            if (valor.InnerText != String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor))
            {
                lbMsg.InnerText = "Oops, parece que algém alterou algum dado da transação, confira os valores e tente novamente.";
            }
            else
            {
              
                var fornecedor = _core.Fornecedor_Get(fornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdParticipante).FirstOrDefault();
                var cliente = _core.Participante_Get(participanteBE, "IdParticipante=" + cotacao.IdParticipante).FirstOrDefault();
                string guidTransacao = Guid.NewGuid().ToString();
                var vencimento = DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString("yyyy-MM-dd");
                var apiKey = "sk_test_80e7e479b25d4918a190862ac303e002";
                var url = "https://api.pagar.me/core/v5/orders";

                var order = new
                {
                    items = new[]
                    {
        new {
            code = "item1",
            amount = (int)(cotacaoFornecedor.Valor * 100), // value in cents
            description = cotacao.Titulo,
            quantity = 1
        }
    },
                    customer = new
                    {
                        name = cliente.Nome,
                        email = cliente.Email,
                        document_type = "CPF", // or "CNPJ"
                        document = new string(cliente.Documento.Where(char.IsDigit).ToArray()),

                        type = "individual", // or "corporation"
                        address = new
                        {
                            line_1 = $"{cliente.Numero}, {cliente.Logradouro}, {cliente.Bairro}",
                            line_2 = cliente.Complemento,
                            zip_code = cliente.Cep,
                            city = cliente.cidade,
                            state = cliente.Uf,
                            country = "BR"
                        }
                    },
                    payments = new[]
                    {
        new {
            payment_method = "boleto",
            boleto = new {
                instructions = "Pagar até o vencimento",
                due_at = vencimento + "T00:00:00Z",
                document_number = cotacao.IdSolicitacao.ToString(),
                type = "DM"
            }
        }
    }
                };

                var json = JsonConvert.SerializeObject(order);

                System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;

                using (var client = new HttpClient())
                {
                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", Convert.ToBase64String(Encoding.UTF8.GetBytes(apiKey + ":")));
                    var content = new StringContent(json, Encoding.UTF8, "application/json");
                    var response = await client.PostAsync(url, content);
                    var responseString = await response.Content.ReadAsStringAsync();
                    OrderResponse orderResponse = JsonConvert.DeserializeObject<OrderResponse>(responseString);

                    Console.WriteLine(responseString);
                    lblApiResponse.Text = responseString;
                    Session["ApiResponse"] = responseString;

                    // After getting the boleto PDF URL from the API response
                    hfBoletoUrl.Value = orderResponse.charges[0].last_transaction.pdf;
                    ScriptManager.RegisterStartupScript(this, GetType(), "OpenBoleto", "openBoletoWindow();", true);

                }
                if (!String.IsNullOrEmpty(cliente.ZoopID))
                {
                    //var retTran = bskPag.Transacao(cliente, vencimento, guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);
                    //var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(retTran);

                    //string status = "";
                    //string url = "";
                    //if (ret["status"] == "200")
                    //{
                    //    status = "2";
                    //    var msg = ret["mensagem"].ToString().Split(';');
                    //    url = msg[1];
                    //}
                    //else
                    //{
                    //    status = "3";
                    //}

                    TransacaoBE transacaoBE = new TransacaoBE()
                    {
                        Boleto = "",
                        DataEnvio = DateTime.Now.ToString("yyyy-MM-dd"),
                        DataVencimento = vencimento,
                        GuidTransacao = guidTransacao,
                        IdSolicitacao = cotacao.IdSolicitacao,
                        Observacao = $"Pagamento {cotacao.Titulo}",
                        ObservacaoStatus = "",
                        Parcelas = 1,
                        //Status = status,
                        TipoPagamento = "Boleto",
                        //Url = url,
                        //IdExterno = ret["codigo"]
                    };

                    //if (status == "2")
                    //{ 
                    //    _core.Transacao_Insert(transacaoBE);
                    //    Response.Redirect("pagamento.aspx?Id=" + cotacao.IdCotacao);                       
                    //}
                    //else
                    //{
                    //    lbMsg.InnerText = ret["mensagem"].ToString().Split(';')[0];
                    //}

                }
                else
                {
                    Endereco endereco = new Endereco()
                    {
                        Bairro = cliente.Bairro,
                        Cep = cliente.Cep,
                        Cidade = cliente.cidade,
                        Complemento = cliente.Complemento,
                        Estado = cliente.Uf,
                        Logradouro = cliente.Logradouro,
                        Numero = cliente.Numero,
                        Pais = "BR",
                        UF = cliente.Uf,
                        IdUsuario = cliente.IdParticipante
                    };

                    Usuario usuario = new Usuario()
                    {
                        IdCliente = cliente.IdParticipante.ToString(),
                        BskPagID = cliente.ZoopID,
                        CPF = cliente.Documento,
                        DataAlteracao = DateTime.Now,
                        DataNascimento = DateTime.Parse("01/01/1990"),
                        Email = cliente.Email,
                        Nome = cliente.Nome,
                        Telefone = cliente.Telefone
                    };

                    usuario.Enderecos = new List<Endereco>();
                    usuario.Enderecos.Add(endereco);

                    cliente.ZoopID = bskPag.CadastrarComprador(usuario, fornecedor.SellerID);

                    var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(cliente.ZoopID);

                    cliente.ZoopID = ret["codigo"];

                    if (cliente.ZoopID != "" && cliente.ZoopID != "Erro")
                    {
                        _core.Participante_Update(cliente, "IdParticipante=" + cotacao.IdParticipante);

                        //bskPag.Transacao(cliente, DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString(), guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);



                        //var tran = bskPag.Transacao(cliente, DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString(), guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);
                        //var obj = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(tran);

                        //string status = "";
                        //string url = "";
                        //if (obj["status"] == "200")
                        //{
                        //    status = "2";
                        //    var msg = obj["mensagem"].ToString().Split(';');
                        //    url = msg[1];
                        //}
                        //else
                        //{
                        //    status = "3";
                        //}

                        TransacaoBE transacaoBE = new TransacaoBE()
                        {
                            Boleto = "",
                            DataEnvio = DateTime.Now.ToString("yyyy-MM-dd"),
                            DataVencimento = vencimento,
                            GuidTransacao = guidTransacao,
                            IdSolicitacao = cotacao.IdSolicitacao,
                            Observacao = $"Pagamento {cotacao.Titulo}",
                            ObservacaoStatus = "",
                            Parcelas = 1,
                            //Status = status,
                            TipoPagamento = "Boleto",
                            //Url = url,
                            IdExterno = ""
                        };

                        //if (status == "2")
                        //{ 
                        //    _core.Transacao_Insert(transacaoBE);
                        //    Response.Redirect("pagamento.aspx?Id=" + cotacao.IdCotacao);                           
                        //}
                        //else
                        //{
                        //    lbMsg.InnerText = obj["mensagem"].ToString().Split(';')[0];
                        //}

                    }
                    else
                    {
                        lbMsg.InnerText = "Dados inválidos, por favor confira seus dados cadastrais e tente novamente.";
                    }

                }
            }
        }

        protected void btnAlterar_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("perfil.aspx?Red=pagamento-boleto&Id="+Request.QueryString["Id"]);
        }
    }
}