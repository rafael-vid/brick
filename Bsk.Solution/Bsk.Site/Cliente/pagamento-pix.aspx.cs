using System;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Runtime.ConstrainedExecution;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;
using Bsk.BE;
using Bsk.BE.Model;
using Bsk.Interface;
using Bsk.Site.Fornecedor;
using Bsk.Site.Service;
using Bsk.Util;
using Newtonsoft.Json;

namespace Bsk.Site.Cliente
{
    public partial class pagamento_pix : System.Web.UI.Page
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
                nomePix.InnerText = login.Nome;
                email.InnerText = login.Email;
                cpf.InnerText = login.Cnpj;
                telefone.InnerText = login.Telefone;
                //cep.InnerText = login.Cep;
                //rua.InnerText = login.Logradouro;
                //numero.InnerText = login.Numero;
                //complemento.InnerText = login.Complemento;
                //bairro.InnerText = login.Bairro;
                //cidade.InnerText = login.Municipio;
                //uf.InnerText = login.Uf;
                valor.InnerText = String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor);
            }
        }

        protected void btnAlterar_ServerClick(object sender, EventArgs e)
        {
            Response.Redirect("perfil.aspx?Red=pagamento-boleto&Id=" + Request.QueryString["Id"]);
        }

        protected void btnGerarPix_ServerClick(object sender, EventArgs e)
        {
            // Registra a chamada assíncrona no ponto async da página (Async="true").
            // Sem isso, o handler async void pode renderizar a resposta antes das
            // atualizações pós-await (QR Code), gerando a transação sem exibir nada.
            RegisterAsyncTask(new PageAsyncTask(GerarPixAsync));
        }

        private async Task GerarPixAsync()
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
            var cliente = _core.Participante_Get(participanteBE, "IdParticipante=" + cotacao.IdParticipante).FirstOrDefault();

            // Telefone somente com dígitos para evitar erros de Substring no postback.
            var telDigits = new string((cliente.Telefone ?? "").Where(char.IsDigit).ToArray());
            string areaCode = telDigits.Length >= 2 ? telDigits.Substring(0, 2) : "";
            string phoneNumber = telDigits.Length > 2 ? telDigits.Substring(2) : "";

            // Exemplo de payload Pix
            var payload = new
            {
                items = new[]
                {
                    new { amount = 2990, description = "Serviço", quantity = 1 }
                },
                customer = new
                {
                    name = cliente.Nome,
                    email = cliente.Email,
                    type = "individual",
                    document = new string(cliente.Documento.Where(char.IsDigit).ToArray()),
                    phones = new
                    {
                        home_phone = new
                        {
                            country_code = "55",
                            number = phoneNumber,
                            area_code = areaCode
                        }
                    }
                },
                payments = new[]
                {
                    new
                    {
                        payment_method = "pix",
                        pix = new
                        {
                            expires_in = 3600,
                            additional_information = new[]
                            {
                                new { name = "Quantidade", value = "1" }
                            }
                        }
                    }
                }
            };
            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;

            using (var client = new HttpClient())
            {
                var apiKey = "sk_test_80e7e479b25d4918a190862ac303e002";
                client.BaseAddress = new Uri("https://api.pagar.me/core/v5/orders");
                client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", Convert.ToBase64String(Encoding.UTF8.GetBytes(apiKey + ":")));
                var json = JsonConvert.SerializeObject(payload);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                var response = await client.PostAsync("", content);
                var responseString = await response.Content.ReadAsStringAsync();

                if (response.IsSuccessStatusCode)
                {
                    // Parse response para obter o QR Code e copiar/colar
                    dynamic resp = JsonConvert.DeserializeObject(responseString);
                    pixQrCodeContainer.Visible = true;

                    // C#
                    string message = responseString;
                    string safeMessage = message.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\r", "").Replace("\n", "");

                    string message2 = (string)resp.charges[0].last_transaction.qr_code;
                    string script = $"console.log('{safeMessage}'); console.log('{message2}');";
                    ClientScript.RegisterStartupScript(this.GetType(), "consoleLog", script, true);

                    imgPixQrCode.Src = resp.charges[0].last_transaction.qr_code_url;
                    pixCopyPaste.InnerText = resp.charges[0].last_transaction.qr_code;
                    lblApiResponse.Text = "Pix gerado com sucesso!";
                }
                else
                {
                    lbMsg.InnerText = "Erro ao gerar Pix: " + responseString;
                }
            }
        }
    }
}
