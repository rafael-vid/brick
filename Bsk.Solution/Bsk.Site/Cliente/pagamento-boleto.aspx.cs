using Bsk.BE;
using Bsk.BE.Pag;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class pagamento_boleto : System.Web.UI.Page
    {
        Bsk.Interface.core _core = new Interface.core();
        Bsk.BE.CotacaoBE CotacaoBE = new BE.CotacaoBE();
        Bsk.BE.CotacaoFornecedorBE CotacaoFornecedorBE = new BE.CotacaoFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacao = _core.Cotacao_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            if (cotacao.Status != Bsk.Util.StatusCotacao.AguardandoPagamento)
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }

            if (!IsPostBack)
            {
                var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, "IdCotacaoFornecedor=" + cotacao.IdCotacaoFornecedor).FirstOrDefault();
                var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
                nome.Value = login.Nome;
                email.Value = login.Email;
                cpf.Value = login.Cnpj;
                telefone.Value = login.Telefone;
                cep.Value = login.Cep;
                rua.Value = login.Logradouro;
                numero.Value = login.Numero;
                complemento.Value = login.Complemento;
                bairro.Value = login.Bairro;
                cidade.Value = login.Municipio;
                uf.Value = login.Uf;
                valor.InnerText = String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor);
            }
        }

        protected void btnGerar_ServerClick(object sender, EventArgs e)
        {
            lbMsg.InnerText = "";
            var cotacao = _core.Cotacao_Get(CotacaoBE, "IdCotacao=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, "IdCotacaoFornecedor=" + cotacao.IdCotacaoFornecedor).FirstOrDefault();

            if (valor.InnerText != String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor))
            {
                lbMsg.InnerText = "Oops, parece que algém alterou algum dado da transação, confira os valores e tente novamente.";
            }
            else
            {
                BskPag bskPag = new BskPag();
                ClienteBE clienteBE = new ClienteBE();
                FornecedorBE fornecedorBE = new FornecedorBE();
                var fornecedor = _core.Fornecedor_Get(fornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdFornecedor).FirstOrDefault();
                var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();
                string guidTransacao = Guid.NewGuid().ToString();
                if (String.IsNullOrEmpty(cliente.ZoopID))
                {
                    bskPag.Transacao(cliente, DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString(), guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);
                }
                else
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

                    cliente.ZoopID = bskPag.CadastrarComprador(usuario);

                    bskPag.Transacao(cliente, DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString(), guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);

                    _core.Cliente_Update(cliente, "IdFornecedor=" + fornecedor.IdFornecedor);

                    var tran = bskPag.Transacao(cliente, DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString(), guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);
                    var obj = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(tran);

                    
                }
            }
        }
    }
}