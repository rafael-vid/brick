using Bsk.Site.Admin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    using Bsk.BE;
    using Bsk.Interface;
    using Bsk.Util;
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class negociar_cotacao : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
        CotacaoFornecedorChatBE _CotacaoFornecedorChatBE = new CotacaoFornecedorChatBE();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        ClienteBE _ClienteBE = new ClienteBE();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request.QueryString["Id"]))
            {
                //RetornaUsuario();
                Response.Redirect("negociar-cotacao.aspx?Id=5");
            }

            CarregaCotacaoFornecedor();

        }

        public void CarregaCotacaoFornecedor()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();

            if (cotacaoFornecedor != null)
            {
                var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
                if (cotacao != null)
                {
                    if (cotacao.Status==StatusCotacao.Finalizado)
                    {
                        btnEnviar.Visible = false;
                        divUpload.Visible = false;
                        msg.Visible = false;
                        comentarios.Visible = false;
                    }

                    if (!IsPostBack)
                    {
                        valorServico.Value = cotacaoFornecedor.Valor.ToString();
                        dataEntrega.Value = cotacaoFornecedor.DataEntrega;                        
                    }
                    titulo.Text = cotacao.Titulo;
                    descricao.Text = cotacao.Descricao;
                    valor.InnerText = string.Format("{0:C}", cotacaoFornecedor.Valor);

                    try
                    {
                        entrega.InnerText = DateTime.Parse(cotacaoFornecedor.DataEntrega).ToString("dd/MM/yyyy");
                    }
                    catch (Exception)
                    {
                        entrega.InnerText = cotacaoFornecedor.DataEntrega;
                    }
                    

                    if (cotacao.Status == StatusCotacao.Aberto)
                    {
                        divTerminar.Visible = false;
                        divValor.Visible = false;

                    }
                    else if (cotacao.IdCotacaoFornecedor != 0 && cotacaoFornecedor.IdFornecedor == login.IdFornecedor && cotacao.FinalizaFornecedor == 0)
                    {
                        divTerminar.Visible = true;
                        divDadosCobranca.Visible = false;
                        divValor.Visible = true;
                    }
                    else
                    {
                        divTerminar.Visible = false;
                        divDadosCobranca.Visible = false;
                    }
                }

                var cliente = _core.Cliente_Get(_ClienteBE, $" IdCliente={cotacao.IdCliente.ToString()}").FirstOrDefault();
                if (cliente != null)
                {
                    ClienteServ.InnerText = cliente.Nome;
                }
            }
        }

        public FornecedorBE RetornaUsuario()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);

            if (login != null)
            {
                return login;
            }
            else
            {
                Response.Redirect("default.aspx");
                return login;
            }
        }

        protected void btnEnviar_ServerClick(object sender, EventArgs e)
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);


            var arquivo = GravarArquivo(flpArquivo);
            var video = GravarVideo(flpVideo);
            var _msg = msg.InnerHtml;

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();

            if (cotacaoFornecedor != null)
            {
                _CotacaoFornecedorChatBE.IdCotacaoFornecedor = Convert.ToInt32(Request.QueryString["Id"]);
                _CotacaoFornecedorChatBE.Mensagem = _msg;
                _CotacaoFornecedorChatBE.Video = video;
                _CotacaoFornecedorChatBE.Arquivo = arquivo;

                _CotacaoFornecedorChatBE.IdCliente = 0; // RETIRAR DO CODE
                _CotacaoFornecedorChatBE.IdFornecedor = login.IdFornecedor; //cotacaoFornecedor.IdFornecedor; SEMPRE 0 PARA O QUE VAI RECEBER a MSG

                _core.CotacaoFornecedorChat_Insert(_CotacaoFornecedorChatBE);
                //DEPOIS COLOCAR MSG
                Response.Redirect($"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}");
            }
        }

        public List<CotacaoFornecedorChatBE> CarregaChat()
        {
            return _core.CotacaoFornecedorChat_Get(_CotacaoFornecedorChatBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]} order by IdCotacaoFornecedorChat desc");
        }

        public string GravarArquivo(FileUpload _flpImg)
        {
            var nome = "";
            var link = "<a href='" + ConfigurationManager.AppSettings["host"] + "/Anexos/Documento/{{ARQ}}'><img alt='' src='img/upload.png'></a>";
            if (!String.IsNullOrEmpty(_flpImg.FileName))
            {
                nome = Guid.NewGuid().ToString() + _flpImg.FileName;
                var path = Server.MapPath("~/Anexos/Documento") + "\\" + nome;
                _flpImg.SaveAs(path);
                link = link.Replace("{{ARQ}}", nome);
            }
            else
            {
                link = "";
            }

            return nome;
        }

        public string GravarVideo(FileUpload _flpImg)
        {
            var nome = "";
            var link = "<a href='" + ConfigurationManager.AppSettings["host"] + "/Anexos/Video/{{ARQ}}'><img alt='' src='img/arquivo.png'></a>";
            if (!String.IsNullOrEmpty(_flpImg.FileName))
            {
                nome = Guid.NewGuid().ToString() + _flpImg.FileName;
                var path = Server.MapPath("~/Anexos/Video") + "\\" + nome;
                _flpImg.SaveAs(path);
                link = link.Replace("{{ARQ}}", nome);
            }
            else
            {
                link = "";
            }

            return link;
        }

        protected void btnSalvarDados_ServerClick(object sender, EventArgs e)
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
            cotacaoFornecedor.DataEntrega = dataEntrega.Value;

            try
            {
                cotacaoFornecedor.Valor = double.Parse(valorServico.Value);
            }
            catch (Exception)
            {
                cotacaoFornecedor.Valor = 0;
            }
            _core.CotacaoFornecedor_Update(cotacaoFornecedor, "IdCotacaoFornecedor=" + cotacaoFornecedor.IdCotacaoFornecedor);

            var cotacao = _core.Cotacao_Get(_CotacaoBE, "").FirstOrDefault();
            var cliente = _core.Cliente_Get(_ClienteBE, "").FirstOrDefault();

            string imagem = "http://studiobrasuka.com.br/logoBrik.png";
            Bsk.Interface.Helpers.EmailTemplate emailTemplate = new Interface.Helpers.EmailTemplate();
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Cliente/negociar-cotacao.aspx?Id=" + cotacaoFornecedor.IdCotacao;
        
            var html = emailTemplate.emailPadrao($"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização", $"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização nos valores/prazo pelo fornecedor {login.NomeFantasia} para ver mais detalhes acesse a plataforma BRIKK.<br><a>href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}", imagem);
            emailTemplate.enviaEmail(html, $"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização", cliente.Email);
        }
    }
}