using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using Bsk.BE;
using Bsk.BE.Pag;

namespace Bsk.Util
{
    public class BskPag
    {

        public string autenticar(string sellerLogin, string sellerSenha, string sellerId)
        {
            //sellerLogin = "brikk@email.com";
            //sellerSenha = "9b38cb15-3675-4aea-89eb-bae1c17bbe62";
            //sellerId = "586de6c5-f696-49d6-8b0c-592d3a038524";
            //var api = ConfigurationManager.AppSettings["Api"];
            //var login = sellerLogin;
            //var senha = sellerSenha;
            //var tk = ApiGet($"{api}Seller/autenticacao?BskPagLogin={login}&BskPagSenha={senha}", "");
            //var obj = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(tk);
            //var token = Base64Encode(sellerId + ":" + obj["codigo"].ToString());
            //return token.ToString();
            return string.Empty;
        }

        public string Transacao(ClienteBE item, string data, string guid, string parcelas, string pagamento, string obs, string valorTransacao, FornecedorBE seller)
        {
            var api = ConfigurationManager.AppSettings["Api"];
            //var token = autenticar(seller.Email, seller.Senha); Autenticar com valores reais depois
            var token = autenticar("", "", "");
            string tp = "";

            if (pagamento == "B")
            {
                tp = "1";
            }
            else
            {
                tp = "2";
            }

            var json = @"{
                          'DataVencimento': '" + DateTime.Parse(data).ToString("yyyy-MM-dd") + @"',
                          'ValorTransacao': '" + valorTransacao.Replace(".", "#").Replace(",", ".").Replace("#", "") + @"',
                          'IdSeller': '" + seller.SellerID + @"',
                          'Empresa': '" + seller.RazaoSocial + @"',
                          'TipoPagamento': '" + tp + @"',
                          'IdBuyer': '" + item.IdCliente + @"',
                          'Email': '" + item.Email + @"',
                          'IdTransacao': 0,
                          'NomeBuyer': '" + item.Nome + @"',
                          'CodigoProduto': '" + ConfigurationManager.AppSettings["ProdutoID"] + @"',
                          'MeioPagamento': '" + item.MeioPagamento + @"',
                          'Token': '" + item.ZoopID + @"',
                          'InformacoesPagamento': '" + obs + @"',
                          'IdReferencia': '" + guid + @"',
                          'Recorrencia': 1,
                          'Assinatura': false,
                          'Parcelas':" + parcelas + "}";

            var ret = ApiPost(json, $"{api}Transacao/ProcessarTransacao?autenticacao={token}", token);
            var retApi = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(ret);
            if (retApi["status"] != "200")
            {
                return ret;
            }
            else
            {
                return ret;
            }

        }

        public string ConsultaMeioPagamento(ParticipanteBE participante)
        {
            var api = ConfigurationManager.AppSettings["Api"];
            var token = autenticar("", "", "");
            var ret = ApiGet($"{api}MeioPagamento/ConsultaMeioPagamento?autenticacao={token}&meioPagamento={participante.MeioPagamento}", token);
            return ret;
        }

        public string SobreporZoop(ClienteBE cli, string seller)
        {
            var api = ConfigurationManager.AppSettings["Api"];
            var token = autenticar("", "", "");

            Usuario usuario = new Usuario();
            Endereco endereco = new Endereco();

            usuario.Nome = cli.Nome;
            usuario.Sobrenome = "";
            usuario.Telefone = cli.Telefone;
            usuario.Email = cli.Email;
            usuario.DataNascimento = Convert.ToDateTime("01/01/1900");
            usuario.IdCliente = cli.IdCliente.ToString();
            usuario.CPF = cli.Cnpj;

            endereco.Pais = "br";
            endereco.Estado = cli.Uf;
            endereco.Cidade = cli.Municipio;
            endereco.Logradouro = cli.Logradouro;
            endereco.Bairro = cli.Bairro;
            endereco.Numero = cli.Numero;
            endereco.Complemento = cli.Complemento;
            endereco.Cep = cli.Cep;

            usuario.Enderecos = new List<Endereco>();
            usuario.Enderecos.Add(endereco);

            string codigo = "";
            string mensagem = "";

            var ret = CadastrarComprador(usuario, seller);
            if (ret.Contains("Falha na autenticação"))
            {
                ret = CadastrarComprador(usuario, seller);
            }

            return ret;
        }

        public string CadastrarComprador(Usuario usuario, string seller)
        {
            try
            {
                return Guid.NewGuid().ToString();
                string autentica = autenticar("", "", "");
                var retApi = CadastrarBuyer(usuario, autentica, seller);
                var requestBuyer = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(retApi);
                if (!String.IsNullOrEmpty(requestBuyer["BuyerID"].ToString()))
                {
                    var BuyerId = requestBuyer["BuyerID"].ToString();
                    var RequestEndereco = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(CadastrarEnderecoCobrancaBuyer(usuario.Enderecos[0], BuyerId, autentica));

                    return IntegrarBuyer(BuyerId, usuario.IdUsuario.ToString(), autentica, seller);
                }
                else
                {
                    return "Erro";
                }
            }
            catch (Exception)
            {

                return "Erro";
            }
        }

        public string IntegrarBuyer(string BuyerID, string SellerKey, string autentica, string seller)
        {
            var api = ConfigurationManager.AppSettings["Api"];

            //#### MAP ###############################################
            return ApiPost("", $"{api}Buyer/IntegrarBuyerSobrepor?autenticacao={autentica}&BuyerID={BuyerID}&SellerID={seller}&SellerKey={SellerKey}", autentica);
        }

        public string CadastrarEnderecoCobrancaBuyer(Endereco endereco, string BuiyerID, string autentica)
        {
            var api = ConfigurationManager.AppSettings["Api"];

            //#### MAP ###############################################
            var par = @"{
                      'BuyerID': '" + BuiyerID + @"',
                      'Pais': '" + endereco.Pais + @"',
                      'Estado': '" + endereco.Estado + @"',
                      'Cidade': '" + endereco.Cidade + @"',
                      'Logradouro': '" + endereco.Logradouro + @"',
                      'Bairro': '" + endereco.Bairro + @"',
                      'Numero': '" + endereco.Numero + @"',
                      'Complemento': '" + endereco.Complemento + @"',
                      'Cep': '" + endereco.Cep + @"'
                    }";

            return ApiPost(par, $"{api}EnderecoCobranca/InserirEnderecoCobranca?autenticacao={autentica}&SellerKey={endereco.IdUsuario}", autentica);
        }

        public string CadastrarBuyer(Usuario usuario, string autentica, string seller)
        {

            var api = ConfigurationManager.AppSettings["Api"];

            //#### MAP ###############################################
            var par = @"{
                        'SellerID': '" + seller + @"',
                        'Nome': '" + usuario.Nome + @"',
                        'Sobrenome': '" + usuario.Sobrenome + @"',
                        'Telefone': '" + usuario.Telefone + @"',
                        'Email': '" + usuario.Email + @"',
                        'DataNascimento': '" + usuario.DataNascimento + @"',
                        'SellerKey': '" + usuario.IdCliente + @"',
                        'Cpf': '" + usuario.CPF + @"'
                    }";

            return ApiPost(par, $"{api}Buyer/InserirBuyer?autenticacao={autentica}", autentica);
        }

        public string EnviarEmailBoleto(string id)
        {
            var api = ConfigurationManager.AppSettings["Api"];
            var token = autenticar("", "", "");
            var ret = ApiPost("", $"{api}Transacao/EnviarCobranca?autenticacao={token}&id={id}", token);
            var retApi = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(ret);
            if (retApi["status"] != "200")
            {
                return retApi["mensagem"];
            }
            else
            {
                return "Boleto enviado por email com sucesso!";
            }
        }

        public string cadastraCartao(string nomeCompleto, string numeroCartao, string numSeg, string mes, string ano, string buyerId, string seller)
        {
            //var api = ConfigurationManager.AppSettings["Api"];
            //var token = autenticar("", "", "");
            //var ret = ApiPost("", $"{api}MeioPagamento/InserirMeioPagamentoCartao?autenticacao={token}&buyerId={buyerId}&sellerId={seller}&tipo=1&nome={nomeCompleto}&mesExpira={mes}&anoExpira={ano}&numeroCartao={numeroCartao}&codigoSeguranca={numSeg}", token);
            //var retApi = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(ret);
            //if (retApi["status"] != "200")
            //{
            //    return retApi["mensagem"];
            //}
            //else
            //{
            //    return retApi["codigo"];
            //}
            return Guid.NewGuid().ToString();

        }

        private string ApiGet(string url, string token)
        {
            try
            {
                //adiciona um protocolo de segurança à requisição
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11;
                HttpClient _client = new HttpClient();

                //Tranforma a zpk em base 64
                var base64 = Base64Encode(token);

                //adiciona os cabeçalhos
                _client.DefaultRequestHeaders.Add("authorization", "Basic " + base64);
                _client.DefaultRequestHeaders.Add("accept", "application/json");

                //Passa a url
                HttpResponseMessage resp = _client.GetAsync(url).GetAwaiter().GetResult();
                //Pega a resposta
                var responseContent = resp.Content;
                string lista = responseContent.ReadAsStringAsync().GetAwaiter().GetResult();
                return lista;
            }
            catch (Exception)
            {

                return string.Empty;
            }
            

        }




        private string ApiPost(string json, string url, string token)
        {
            //adiciona um protocolo de segurança à requisição
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls11;
            HttpClient _client = new HttpClient();

            //Tranforma a zpk em base 64
            var base64 = Base64Encode(token);

            //adiciona os cabeçalhos
            _client.DefaultRequestHeaders.Add("authorization", "Basic " + base64);
            _client.DefaultRequestHeaders.Add("accept", "application/json");
            // _client.DefaultRequestHeaders.Add("content-type", "application/json");
            _client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            var contentString = new StringContent(json, Encoding.UTF8, "application/json");
            contentString.Headers.ContentType = new MediaTypeHeaderValue("application/json");
            //Passa a url
            HttpResponseMessage resp = _client.PostAsync(url, contentString).GetAwaiter().GetResult();

            //Pega a resposta
            var responseContent = resp.Content;
            string lista = responseContent.ReadAsStringAsync().GetAwaiter().GetResult();
            return lista;
        }


        private static string Base64Encode(string plainText)
        {

            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        public string RenderizaRecibo(string idPag)
        {
            return "";
            var api = ConfigurationManager.AppSettings["Api"];
            var token = autenticar("", "", "");
            var ret = ApiGet($"{api}MeioPagamento/RenderizarRecibo?autenticacao={token}&transacao={idPag}", token);
            var retApi = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(ret);
            return retApi["mensagem"];
        }
    }
}
