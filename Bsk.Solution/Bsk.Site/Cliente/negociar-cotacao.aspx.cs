using Bsk.Site.Admin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
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

            if (!IsPostBack)
            {
                CarregaCotacaoFornecedor();
            }

        }

        public void CarregaCotacaoFornecedor()
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
            if (cotacaoFornecedor.Valor == 0 || cotacaoFornecedor.DataEntrega == "")
            {
                divAceitar.Visible = false;
            }

            if (cotacaoFornecedor != null)
            {
                var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
                if (cotacao != null)
                {
                    if (cotacao.Status == StatusCotacao.Finalizado)
                    {
                        btnEnviar.Visible = false;
                        divUpload.Visible = false;
                        msg.Visible = false;
                        descricaoHide.Visible = false;
                    }

                    titulo.Text = cotacao.Titulo;
                    descricao.Text = cotacao.Descricao;
                    vlr.InnerText = string.Format("{0:C}", cotacaoFornecedor.Valor);

                    try
                    {
                        dataEntrega.InnerText = DateTime.Parse(cotacaoFornecedor.DataEntrega).ToString("dd/MM/yyyy");
                    }
                    catch (Exception)
                    {
                        dataEntrega.InnerText = cotacaoFornecedor.DataEntrega;
                    }


                    if (cotacao.IdCotacaoFornecedor != 0)
                    {
                        divAceitar.Visible = false;
                    }

                    if (cotacao.FinalizaCliente == 0 && cotacao.FinalizaFornecedor == 1)
                    {
                        divTerminado.Visible = true;
                    }
                    else
                    {
                        divTerminado.Visible = false;
                    }
                }

                var fornecedor = _core.Fornecedor_Get(_FornecedorBE, $" IdFornecedor={cotacaoFornecedor.IdFornecedor.ToString()}").FirstOrDefault();
                if (fornecedor != null)
                {
                    parceiro.InnerText = fornecedor.RazaoSocial;
                }

            }
        }


        public ClienteBE RetornaUsuario()
        {
            HttpCookie login = Request.Cookies["login"];
            ClienteBE usuario = new ClienteBE();
            if (login != null)
            {
                usuario = Newtonsoft.Json.JsonConvert.DeserializeObject<ClienteBE>(login.Value.ToString());
                return usuario;
            }
            else
            {
                Response.Redirect("default.aspx");
                return usuario;
            }
        }
        protected void btnEnviar_ServerClick(object sender, EventArgs e)
        {
            var arquivo = GravarArquivo(flpArquivo);
            var video = GravarVideo(flpVideo);
            var _msg = msg.InnerHtml;

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            if (cotacaoFornecedor != null)
            {
                _CotacaoFornecedorChatBE.IdCotacaoFornecedor = Convert.ToInt32(Request.QueryString["Id"]);
                _CotacaoFornecedorChatBE.Mensagem = _msg;
                _CotacaoFornecedorChatBE.Video = video;
                _CotacaoFornecedorChatBE.Arquivo = arquivo;

                _CotacaoFornecedorChatBE.IdCliente = login.IdCliente; // RETIRAR DO CODE
                _CotacaoFornecedorChatBE.IdFornecedor = 0; //cotacaoFornecedor.IdFornecedor; SEMPRE 0 PARA O QUE VAI RECEBER a MSG

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
    }
}