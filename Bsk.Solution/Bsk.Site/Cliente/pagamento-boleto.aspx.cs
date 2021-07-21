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
        BskPag bskPag = new BskPag();
        ClienteBE clienteBE = new ClienteBE();
        FornecedorBE fornecedorBE = new FornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();
            nrcotacao.InnerText = cotacao.IdCotacao.ToString();
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

        protected void btnGerar_ServerClick(object sender, EventArgs e)
        {
            lbMsg.InnerText = "";
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(CotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();

            if (valor.InnerText != String.Format("{0:R$#,##0.00;($#,##0.00);Zero}", cotacaoFornecedor.Valor))
            {
                lbMsg.InnerText = "Oops, parece que algém alterou algum dado da transação, confira os valores e tente novamente.";
            }
            else
            {
              
                var fornecedor = _core.Fornecedor_Get(fornecedorBE, "IdFornecedor=" + cotacaoFornecedor.IdFornecedor).FirstOrDefault();
                var cliente = _core.Cliente_Get(clienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();
                string guidTransacao = Guid.NewGuid().ToString();
                var vencimento = DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString("yyyy-MM-dd");
                if (!String.IsNullOrEmpty(cliente.ZoopID))
                {
                    var retTran = bskPag.Transacao(cliente, vencimento, guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);
                    var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(retTran);

                    string status = "";
                    string url = "";
                    if (ret["status"] == "200")
                    {
                        status = "2";
                        var msg = ret["mensagem"].ToString().Split(';');
                        url = msg[1];
                    }
                    else
                    {
                        status = "3";
                    }

                    TransacaoBE transacaoBE = new TransacaoBE()
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
                        IdExterno = ret["codigo"]
                    };

                    if (status == "2")
                    { 
                        _core.Transacao_Insert(transacaoBE);
                        Response.Redirect("pagamento.aspx?Id=" + cotacao.IdCotacaoFornecedor);                       
                    }
                    else
                    {
                        lbMsg.InnerText = ret["mensagem"].ToString().Split(';')[0];
                    }

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

                    cliente.ZoopID = bskPag.CadastrarComprador(usuario, fornecedor.SellerID);

                    var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(cliente.ZoopID);

                    cliente.ZoopID = ret["codigo"];

                    if (cliente.ZoopID != "" && cliente.ZoopID != "Erro")
                    {
                        _core.Cliente_Update(cliente, "IdCliente=" + cotacao.IdCliente);

                        bskPag.Transacao(cliente, DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString(), guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);



                        var tran = bskPag.Transacao(cliente, DateTime.Now.AddDays(VariaveisGlobais.DiasBoleto).ToString(), guidTransacao, "1", "B", $"Pagamento {cotacao.Titulo}", cotacaoFornecedor.Valor.ToString(), fornecedor);
                        var obj = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(tran);

                        string status = "";
                        string url = "";
                        if (obj["status"] == "200")
                        {
                            status = "2";
                            var msg = obj["mensagem"].ToString().Split(';');
                            url = msg[1];
                        }
                        else
                        {
                            status = "3";
                        }

                        TransacaoBE transacaoBE = new TransacaoBE()
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
                            IdExterno = ""
                        };

                        if (status == "2")
                        { 
                            _core.Transacao_Insert(transacaoBE);
                            Response.Redirect("pagamento.aspx?Id=" + cotacao.IdCotacaoFornecedor);                           
                        }
                        else
                        {
                            lbMsg.InnerText = obj["mensagem"].ToString().Split(';')[0];
                        }

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