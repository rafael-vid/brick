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
            Response.Redirect("Fornecedor/cadastro.aspx");

            return View();
        }

        [HttpGet]
        public JsonResult PegaTeste()
        {
            return this.Json(new { Result = "Não foi possível inserir o usuário" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult InserirCliente(string cpf, string email, string cnpj, string nome, string situacao, string abertura, string tipo, string telefone, string logradouro, string cep, string numero, string complemento, string bairro, string municipio, string uf, string nomeResponsavel, string whatsapp, string senha)
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
                WhatsApp = whatsapp

            };

            _core.Cliente_Insert(ClienteBE);
            return this.Json(new { Result = "Registro inserido com sucesso!" }, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void NotaCotacao(string nota, string id)
        {
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + id).FirstOrDefault();
            cotacao.Nota = int.Parse(nota);
            _core.Cotacao_Update(cotacao, "IdCotacao=" + id);
        }

        [HttpPost]
        public void NotaCotacaoFornecedor(string nota, string id)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor="+id).FirstOrDefault();
            CotacaoBE cotacaoBE = new CotacaoBE();
            var cotacao = _core.Cotacao_Get(cotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            cotacao.NotaFornecedor = int.Parse(nota);
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);
        }

        [HttpPost]
        public void AceitarCotacao(string idCotacaoFornecedor)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + idCotacaoFornecedor).FirstOrDefault();
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
            string mensagem = $"Parabéns, você foi aceito para realizar o serviço {cotacao.Titulo}. Em breve você receberá um email informando que liberamos o início do serviço. Acesse a plataforma BRIKK para mais detalhes.";
            string imagem = "http://studiobrasuka.com.br/logoBrik.png";
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
            string imagem = "http://studiobrasuka.com.br/logoBrik.png";
            string email = "";

            if (String.IsNullOrEmpty(fornecedor.Email))
            {
                email = "harrymangiapelo@gmail.com";
            }
            else
            {
                email = fornecedor.Email;
            }

            if (status == "0")
            {
                titulo = $"O cliente {cliente.Nome} não aceitou o término do serviço";
                mensagem = $"O término do serviço nº{cotacao.IdCotacao} não foi aceito. Para mais informações entre em contato com o cliente.";
            }
            else
            {
                titulo = $"O cliente {cliente.Nome} aceitou o término do serviço";
                mensagem = $"O término do serviço nº{cotacao.IdCotacao} foi aceito. Assim que o pagamento for realizado, você será notificado.";
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

            string titulo = $"O seu pagamento foi liberado!";
            string mensagem = $"pagamento da cotação Nº no valor de {cf.Valor} foi liberado pelo cliente! Acesse a plataforma BRIKK para mais detalhes";
            string imagem = "http://studiobrasuka.com.br/logoBrik.png";
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
            string mensagem = $"Para confirmar o término do serviço ou entrar em contato com o fornecedor, acesse a plataforma BRIKK.";
            string imagem = "http://studiobrasuka.com.br/logoBrik.png";
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
        public void SalvarDadosCobrancaCotacao(string data, string valor)
        {
            CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
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
        }

    }
}