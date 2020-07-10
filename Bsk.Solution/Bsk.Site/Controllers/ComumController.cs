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


    }
}