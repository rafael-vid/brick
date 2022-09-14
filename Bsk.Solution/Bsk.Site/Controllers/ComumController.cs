using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Bsk.BE;
using Bsk.Interface;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.IO;
using System.Drawing;
using System.Net.Mail;
using System.Configuration;
using System.Net;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Text;



namespace Bsk.Site.Controllers
{
    using Bsk.Util;
    using Bsk.Interface.Helpers;
    public class ComumController : Controller
    {

        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        ClienteBE ClienteBE = new ClienteBE();
        public ActionResult Index()
        {
            Response.Redirect("Geral/index.html");

            return View();
        }

        [HttpGet]
        public JsonResult PegaTeste()
        {
            return this.Json(new { Result = "Não foi possível inserir o usuário" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InserirCliente(string cpf, string email, string cnpj, string nome, string situacao, string abertura, string tipo, string telefone, string logradouro, string cep, string numero, string complemento, string bairro, string municipio, string uf, string nomeResponsavel, string whatsapp, string senha, string sobrenome, string fantasia, string CpfResponsavel)
        {
            string documento = "";
            if (String.IsNullOrEmpty(cpf))
            {
                documento = cnpj;
            }
            else
            {
                documento = cpf;
            }

            var clienteDoc = _core.Cliente_Get(ClienteBE, $"Cnpj='{cnpj}' or Cnpj='{cnpj.Replace(".", "").Replace("-", "").Replace("/", "")}'");
            if (clienteDoc.Count > 0)
            {
                return this.Json(new { Msg = "Esse cnpj/cpf já foi cadastrado" }, JsonRequestBehavior.AllowGet);
            }

            var clienteEmail = _core.Cliente_Get(ClienteBE, $"Email='{email}'");
            if (clienteEmail.Count > 0)
            {
                return this.Json(new { Msg = "Esse email já foi cadastrado" }, JsonRequestBehavior.AllowGet);
            }

            ClienteBE = new ClienteBE()
            {
                Bairro = bairro,
                Cep = cep,
                Complemento = complemento,
                Cnpj = documento,
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd"),
                Email = email,
                Logradouro = logradouro,
                Municipio = municipio,
                Nome = nome,
                Numero = numero,
                Senha = senha,
                Situacao = situacao,
                Status = "1",
                Telefone = telefone,
                Uf = uf,
                WhatsApp = whatsapp,
                Fantasia = fantasia,
                SobreNome = sobrenome,
                NomeResponsavel = nomeResponsavel,
                CpfResponsavel = CpfResponsavel

            };

            _core.Cliente_Insert(ClienteBE);
            return this.Json(new { Msg = "Ok" }, JsonRequestBehavior.AllowGet);
        }


        [HttpPost]
        public void DesistirCotacao(string id)
        {
            CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, "IdCotacaoFornecedor=" + id).FirstOrDefault();
            cf.Ativo = 0;
            _core.CotacaoFornecedor_Update(cf, "IdCotacaoFornecedor=" + id);
        }

        [HttpPost]
        public void NotaCotacao(string nota, string id)
        {
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + id).FirstOrDefault();
            cotacao.Nota = int.Parse(nota);
            cotacao.Status = StatusCotacao.Avaliado;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + id);
        }

        [HttpPost]
        public void NotaCotacaoFornecedor(string nota, string id)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + id).FirstOrDefault();
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            cotacao.NotaFornecedor = int.Parse(nota);
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);
        }

        [HttpPost]
        public string AceitarCotacao(string idCotacaoFornecedor)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + idCotacaoFornecedor).FirstOrDefault();

            if (cf.Ativo == 0)
            {
                return "O fornecedor desistiu da cotação";
            }
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            cotacao.IdCotacaoFornecedor = cf.IdCotacaoFornecedor;
            cotacao.Status = StatusCotacao.AguardandoPagamento;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);

            FornecedorBE fornecedorBE = new FornecedorBE();
            var fornecedor = _core.Fornecedor_Get(fornecedorBE, "IdFornecedor=" + cf.IdFornecedor).FirstOrDefault();
            ClienteBE clienteBE = new ClienteBE();
            var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();

            string titulo = $"O cliente {cliente.Nome} aceitou você para a cotação do serviço {cotacao.IdCotacao}";
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Cliente/negociar-cotacao.aspx?Id=" + cf.IdCotacao;
            string mensagem = $"Parabéns, você foi aceito para realizar o serviço {cotacao.Titulo}. Em breve você receberá um email informando que liberamos o início do serviço. Acesse a plataforma BRIKK para mais detalhes.:<br><a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
            string imagem = VariaveisGlobais.Logo;
            string email = "";
            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);

            if (String.IsNullOrEmpty(fornecedor.Email))
            {
                email = "harrymangiapelo@gmail.com";
            }
            else
            {
                email = fornecedor.Email;
            }
            emailTemplate.enviaEmail(html, titulo, email);
            return "Ok";
        }

        [HttpPost]
        public JsonResult AceitarTermino(string idCotacaoFornecedor, string status)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + idCotacaoFornecedor).FirstOrDefault();
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            cotacao.FinalizaCliente = int.Parse(status);
            cotacao.FinalizaFornecedor = int.Parse(status);
            ClienteBE clienteBE = new ClienteBE();
            var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();
            FornecedorBE fornecedorBE = new FornecedorBE();
            var fornecedor = _core.Fornecedor_Get(fornecedorBE, "IdFornecedor=" + cf.IdFornecedor).FirstOrDefault();

            string titulo = "";
            string mensagem = "";
            string imagem = VariaveisGlobais.Logo;
            string email = "";

            if (String.IsNullOrEmpty(fornecedor.Email))
            {
                email = "harrymangiapelo@gmail.com";
            }
            else
            {
                email = fornecedor.Email;
            }

            string link = ConfigurationManager.AppSettings["host"].ToString() + "Fornecedor/negociar-cotacao.aspx?Id=" + cf.IdCotacaoFornecedor;


            if (status == "0")
            {
                titulo = $"O cliente {cliente.Nome} não aceitou o término do serviço";
                mensagem = $"O término do serviço nº{cotacao.IdCotacao} não foi aceito. Para mais informações entre em contato com o cliente.. Acesse a plataforma BRIKK para mais detalhes.:<br><a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
            }
            else
            {
                titulo = $"O cliente {cliente.Nome} aceitou o término do serviço";
                mensagem = $"O término do serviço nº{cotacao.IdCotacao} foi aceito. Assim que o pagamento for realizado, você será notificado.:<br> <a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
                cotacao.Status = StatusCotacao.AguardandoPagamento;
            }

            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);
            emailTemplate.enviaEmail(html, titulo, email);

            bool liberado = false;
            if (status == "1")
            {
                liberado = liberarPagamento(cotacao, cf, fornecedor);
            }



            if (liberado)
            {
                cotacao.Status = StatusCotacao.Finalizado;
            }
            else
            {
                cotacao.Status = StatusCotacao.EmAndamento;
            }

            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);




            return this.Json(new { Result = status, Liberado = cotacao.Status }, JsonRequestBehavior.AllowGet);
        }

        private bool liberarPagamento(CotacaoBE cotacao, CotacaoFornecedorBE cf, FornecedorBE fornecedor)
        {
            //colocar liberação de pagamento

            string titulo = $"O pagamento da cotação Nº no valor de {cf.Valor} foi liberado pelo cliente!";
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Fornecedor/negociar-cotacao.aspx?Id=" + cf.IdCotacaoFornecedor;
            string mensagem = $"O pagamento da cotação Nº no valor de {cf.Valor} foi liberado pelo cliente! Acesse a plataforma BRIKK para mais detalhes.:<br><a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
            string imagem = VariaveisGlobais.Logo;
            string email = "";

            if (String.IsNullOrEmpty(fornecedor.Email))
            {
                email = "harrymangiapelo@gmail.com";
            }
            else
            {
                email = fornecedor.Email;
            }

            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);
            emailTemplate.enviaEmail(html, titulo, email);


            return true;
        }

        [HttpPost]
        public JsonResult FinalizarPagamento(string idCotacaoFornecedor)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + idCotacaoFornecedor).FirstOrDefault();
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            FornecedorBE fornecedorBE = new FornecedorBE();
            var fornecedor = _core.Fornecedor_Get(fornecedorBE, "IdFornecedor=" + cf.IdFornecedor).FirstOrDefault();
            if (liberarPagamento(cotacao, cf, fornecedor))
            {
                return this.Json(new { Result = StatusCotacao.Finalizado }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return this.Json(new { Result = StatusCotacao.EmAndamento }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public void TerminarServico(string idCotacaoFornecedor)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + idCotacaoFornecedor).FirstOrDefault();
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            ClienteBE clienteBE = new ClienteBE();
            var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();

            string titulo = $"O fornecedor {login.RazaoSocial} informou que terminou o serviço nº {cotacao.IdCotacao}";
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Cliente/negociar-cotacao.aspx?Id=" + cf.IdCotacao;
            string mensagem = $"Para confirmar o término do serviço ou entrar em contato com o fornecedor, acesse a plataforma BRIKK.:<br><a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}";
            string imagem = VariaveisGlobais.Logo;
            string email = "";

            EmailTemplate emailTemplate = new EmailTemplate();
            string html = emailTemplate.emailPadrao(titulo, mensagem, imagem);

            if (String.IsNullOrEmpty(cliente.Email))
            {
                email = "harrymangiapelo@gmail.com";
            }
            else
            {
                email = cliente.Email;
            }

            emailTemplate.enviaEmail(html, titulo, email);

            cotacao.FinalizaFornecedor = 1;
            cotacao.DataTermino = DateTime.Now.ToString("yyyy-MM-dd");
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);
        }

        [HttpPost]
        public void SubmeterCotacao(string id)
        {
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + id).FirstOrDefault();
            cotacao.Status = StatusCotacao.Aberto;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + id);
        }


        [HttpPost]
        public void MudaStatusTransacao(string status, string id)
        {
            TransacaoBE transacaoBE = new TransacaoBE();
            var trans = _core.Transacao_Get(transacaoBE, " IdTransacao=" + id).FirstOrDefault();
            trans.Status = status;
            _core.Transacao_Update(trans, " IdTransacao=" + id);
        }

        [HttpPost]
        public JsonResult RecuperaSenha(string tipo, string email)
        {
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Site/redefinir-senha.aspx?log=";
            string logo = VariaveisGlobais.Logo;
            if (tipo == "F")
            {
                var fornecedor = _core.Fornecedor_Get(_FornecedorBE, $" Email='{email}'").FirstOrDefault();
                if (fornecedor == null)
                {
                    return this.Json(new { Result = "O email informado não foi encontrado em nossa base." }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    RedefinirSenhaBE redefinirSenhaBE = new RedefinirSenhaBE()
                    {
                        Ativo = 1,
                        DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                        Guid = Guid.NewGuid().ToString(),
                        Id = fornecedor.IdFornecedor,
                        Tipo = tipo
                    };
                    _core.RedefinirSenha_Insert(redefinirSenhaBE);

                    EmailTemplate emailTemplate = new EmailTemplate();

                    string html = emailTemplate.emailPadrao("Redefinição de senha", $"Alguém, provavelmente você solicitou uma redefinição de senha na plataforma Brikk.<br>Para redefinir a senha acesse: {link + redefinirSenhaBE.Guid} Caso não seja você basta apenas ignorar essa mensagem.", logo);

                    var ret = emailTemplate.enviaEmail(html, "Redefinição de senha", email);
                    if (ret)
                    {
                        return this.Json(new { Result = "Ok" }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return this.Json(new { Result = "Aconteceu algum problema ao enviar o email, por favor confira os dados e tente novamente." }, JsonRequestBehavior.AllowGet);
                    }

                }
            }
            else
            {
                ClienteBE _ClienteBE = new ClienteBE();
                var cliente = _core.Cliente_Get(_ClienteBE, $" Email='{email}'").FirstOrDefault();
                if (cliente == null)
                {
                    return this.Json(new { Result = "O email informado não foi encontrado em nossa base." }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    RedefinirSenhaBE redefinirSenhaBE = new RedefinirSenhaBE()
                    {
                        Ativo = 1,
                        DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                        Guid = Guid.NewGuid().ToString(),
                        Id = cliente.IdCliente,
                        Tipo = tipo
                    };
                    _core.RedefinirSenha_Insert(redefinirSenhaBE);

                    EmailTemplate emailTemplate = new EmailTemplate();

                    string html = emailTemplate.emailPadrao("Redefinição de senha", $"Alguém, provavelmente você solicitou uma redefinição de senha na plataforma Brikk.<br>Para redefinir a senha acesse: {link + redefinirSenhaBE.Guid} <br> Caso não seja você basta apenas ignorar essa mensagem.", logo);

                    var ret = emailTemplate.enviaEmail( html,"Redefinição de senha", email);
                    if (ret)
                    {
                        return this.Json(new { Result = "Ok" }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        return this.Json(new { Result = "Aconteceu algum problema ao enviar o email, por favor confira os dados e tente novamente." }, JsonRequestBehavior.AllowGet);
                    }

                }
            }
        }


        [HttpPost]
        public void SalvarDadosCobrancaCotacao(string data, string valor, string id)
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={id}").FirstOrDefault();
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE()
            {
                Valor = cotacaoFornecedor.Valor,
                DataCriacao = cotacaoFornecedor.DataCriacao,
                DataEntrega = cotacaoFornecedor.DataEntrega,
                IdCotacao = cotacaoFornecedor.IdCotacao,
                IdCotacaoFornecedor = cotacaoFornecedor.IdCotacaoFornecedor,
                IdFornecedor = cotacaoFornecedor.IdFornecedor
            };

            cotacaoFornecedor.DataEntrega = data;

            try
            {
                cotacaoFornecedor.Valor = double.Parse(valor);
            }
            catch (Exception)
            {
                cotacaoFornecedor.Valor = 0;
            }
            _core.CotacaoFornecedor_Update(cotacaoFornecedor, "IdCotacaoFornecedor=" + cotacaoFornecedor.IdCotacaoFornecedor);

            if (!String.IsNullOrEmpty(cotacaoFornecedor.DataEntrega) && cotacaoFornecedor.Valor != 0)
            {
                if (cotacaoFornecedorBE.Valor != cotacaoFornecedor.Valor || cotacaoFornecedor.DataEntrega != cotacaoFornecedorBE.DataEntrega)
                {
                    CotacaoBE _CotacaoBE = new CotacaoBE();
                    ClienteBE _ClienteBE = new ClienteBE();
                    var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();
                    var cliente = _core.Cliente_Get(_ClienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();

                    string imagem = VariaveisGlobais.Logo;
                    Bsk.Interface.Helpers.EmailTemplate emailTemplate = new Interface.Helpers.EmailTemplate();
                    string link = ConfigurationManager.AppSettings["host"].ToString() + "Cliente/negociar-cotacao.aspx?Id=" + cotacaoFornecedor.IdCotacao;

                    var html = emailTemplate.emailPadrao($"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização", $"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização nos valores/prazo pelo fornecedor {login.NomeFantasia} para ver mais detalhes acesse a plataforma BRIKK.<br><a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}", imagem);
                    emailTemplate.enviaEmail(html, $"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização", cliente.Email);

                }

            }
        }

        [HttpPost]
        public void AtualizaEnviarProposta(int idCotacao)
        {
            _core.AtualizaEnviaPropostaCotacao(idCotacao);
        }

        [HttpGet]
        public string CarregaChat(string id, string tipo)
        {
            CotacaoFornecedorChatBE _CotacaoFornecedorChatBE = new CotacaoFornecedorChatBE();
            var lista = _core.CotacaoFornecedorChat_Get(_CotacaoFornecedorChatBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]} order by IdCotacaoFornecedorChat desc");
            var listaNlF = lista.Where(x => x.LidaFornecedor == 0).ToList();
            var listaNlC = lista.Where(x => x.LidaCliente == 0).ToList();

            if (tipo == "F")
            {
                foreach (var item in listaNlF)
                {
                    item.LidaFornecedor = 1;
                    _core.CotacaoFornecedorChat_Update(item, "IdCotacaoFornecedorChat=" + item.IdCotacaoFornecedorChat);
                }
            }
            else if (tipo == "C")
            {
                foreach (var item in listaNlC)
                {
                    item.LidaCliente = 1;
                    _core.CotacaoFornecedorChat_Update(item, "IdCotacaoFornecedorChat=" + item.IdCotacaoFornecedorChat);
                }
            }

            string html = "";
            if (tipo == "F")
            {
                var cliente = @"<!--CLIENTE-->
                                 <div class='enviado'>
                                    <h3 class=titulo-msg'>Você</h3>
                                      <div class='conteudo-msg'>
                                        <p>
                                          {{CLIENTEMSG}}
                                        </p>
                                      </div>
                                     </div>
                
                <!--FIM CLIENTE-->";

                var fornecedor = @"<!--FORNECEDOR-->
                                            <div class='enviado'>
                                           <h3 class=titulo-msg'>Fornecedor</h3>
                                              <div class='conteudo-msg'>
                                                <p>
                                                  {{FORNECEDORMSG}}
                                                </p>
                                              </div>
                                            </div>
             
                                             <!--FIM FORNECEDOR-->";

                var conteudo = "";
                foreach (var item in lista)
                {
                    var arquivo = "";
                    if (!String.IsNullOrEmpty(item.Arquivo))
                        arquivo = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Documento/" + item.Arquivo + "' target='_blank'><img alt='' src='../assets/imagens/anexar.svg' style='width: 30px;' alt='anexar'></a>";

                    var video = "";
                    if (!String.IsNullOrEmpty(item.Video))
                        video = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Video/" + item.Video + "' target='_blank'><img alt='' src='../assets/imagens/gravar.svg' style='width: 30px;' alt='anexar'></a>";


                    if (item.IdCliente != 0)
                        conteudo = cliente.Replace("{{CLIENTEMSG}}", item.Mensagem + "<BR>" + video + "&nbsp;&nbsp;&nbsp;" + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span>");
                    else
                        conteudo = fornecedor.Replace("{{FORNECEDORMSG}}", item.Mensagem + "<BR>" + video + "&nbsp;&nbsp;&nbsp;" + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span>");

                    html += conteudo;

                }
            }
            else
            {
                var cliente = @"<!--CLIENTE-->
                                 <div class='enviado'>
                                    <h3 class=titulo-msg'>Você</h3>
                                      <div class='conteudo-msg'>
                                        <p>
                                          {{CLIENTEMSG}}
                                        </p>
                                      </div>
                                     </div>
                
                <!--FIM CLIENTE-->";

                var fornecedor = @"<!--FORNECEDOR-->
                                            <div class='enviado'>
                                           <h3 class=titulo-msg'>Fornecedor</h3>
                                              <div class='conteudo-msg'>
                                                <p>
                                                  {{FORNECEDORMSG}}
                                                </p>
                                              </div>
                                            </div>
             
                                             <!--FIM FORNECEDOR-->";

                var conteudo = "";
                foreach (var item in lista)
                {
                    var arquivo = "";
                    if (!String.IsNullOrEmpty(item.Arquivo))
                        arquivo = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Documento/" + item.Arquivo + "' target='_blank'><img alt='' src='../assets/imagens/anexar.svg' style='width: 30px;' alt='anexar'></a>";

                    var video = "";
                    if (!String.IsNullOrEmpty(item.Video))
                        video = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Video/" + item.Video + "' target='_blank'><img alt='' src='../assets/imagens/gravar.svg' style='width: 30px;' alt='anexar'></a>";


                    if (item.IdCliente != 0)
                        conteudo = cliente.Replace("{{CLIENTEMSG}}", item.Mensagem + video + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span>");
                    else
                        conteudo = fornecedor.Replace("{{FORNECEDORMSG}}", item.Mensagem + video + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span>");

                    html += conteudo;

                }
            }
            return html;
        }
    }
}