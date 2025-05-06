using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    using Bsk.BE;
    using Bsk.Interface;
    using Bsk.Util;
    using System.Configuration;
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class cadastro_cotacao : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        CotacaoFornecedorChatBE _CotacaoFornecedorChatBE = new CotacaoFornecedorChatBE();
        SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
        ClienteBE _ClienteBE = new ClienteBE();
        CotacaoAnexosBE _CotacaoAnexosBE = new CotacaoAnexosBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            SolicitacaoBE cotacao = new SolicitacaoBE();
            if (!String.IsNullOrEmpty(Request.QueryString["Cotacao"]))
            {
                cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();

                if (cotacao.Status != StatusCotacao.Criacao)
                {
                    btnSalvar.Visible = false;
                    btnSubmeter.Visible = false;
                    divUpload.Visible = true;
                    // alerts.Visible = false;
                    // alerts2.Visible = false;
                }
            }

            if (Request.QueryString["Del"] != null && cotacao.Status == StatusCotacao.Criacao)
            {
                var anexo = _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdCotacaoAnexos=" + Request.QueryString["Del"]).FirstOrDefault();
                _core.CotacaoAnexos_Delete(anexo);
                Response.Redirect("cadastro-solicitacao.aspx?Cotacao=" + Request.QueryString["Cotacao"]);
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["Cotacao"] != null)
                {

                    titulo.Value = cotacao.Titulo;
                    descricao.Text = cotacao.Descricao;
                }
                else
                {
                    btnEnviarAnexo.Visible=false;
                    divUpload.Visible = true;
                    btnSubmeter.Visible = false;
                }
            }
        }

        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            
            // ####################################### ENVIAR PARA MSG ##########################################
             var redi = salvarCotacao();

            if (!String.IsNullOrEmpty(hdLink.Value))
            {
                Response.Redirect(hdLink.Value);
            }
            else
            {
                Response.Redirect("cadastro-solicitacao.aspx?Cotacao=" + redi);
            }
        }

        private string salvarCotacao()
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            string cot = "";

            if (Request.QueryString["Cotacao"] != null)
            {
                cot = Request.QueryString["Cotacao"];

                if (flpAnexo.PostedFile.FileName != "")
                {
                    GravarArquivo(flpAnexo, "Anexo");
                }

                if (flpVideo.PostedFile.FileName != "")
                {
                    GravarArquivo(flpVideo, "Video");
                }

                SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
                var cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();

                cotacao.Titulo = titulo.Value;
                cotacao.Descricao = descricao.Text;
                _core.Cotacao_Update(cotacao, "IdSolicitacao=" + cotacao.IdSolicitacao);
            }
            else
            {
                SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE()
                {
                    IdCategoria = int.Parse(Request.QueryString["Id"]),
                    DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    DataTermino = "",
                    Depoimento = "",
                    Descricao = descricao.Text,
                    FinalizaCliente = 0,
                    FinalizaFornecedor = 0,
                    IdParticipante = login.IdParticipante,
                    IdCotacao = 0,
                    Nota = 0,
                    Observacao = "",
                    Status = "1",
                    Titulo = titulo.Value
                };

                cot = _core.Cotacao_Insert(_SolicitacaoBE);
            }
            return cot;
        }

        public List<CotacaoAnexosBE> PegaAnexo()
        {
            return _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdSolicitacao=" + Request.QueryString["Cotacao"]);
        }

        public string GravarArquivo(FileUpload _flpImg, string tipo)
        {
            var nome = "";
            var link = "<a href='" + ConfigurationManager.AppSettings["host"] + "/Anexos/Documento/{{ARQ}}'><img alt='' src='img/upload.png'></a>";
            if (!String.IsNullOrEmpty(_flpImg.FileName))
            {
                nome = Guid.NewGuid().ToString() + _flpImg.FileName;
                var path = "";

                if (tipo == "Anexo")
                {
                    path = Server.MapPath("~/Anexos/Documento") + "\\" + nome;
                }
                else
                {
                    path = Server.MapPath("~/Anexos/Video") + "\\" + nome;
                }

                _flpImg.SaveAs(path);
                link = link.Replace("{{ARQ}}", nome);
            }
            else
            {
                link = "";
            }

            _CotacaoAnexosBE = new CotacaoAnexosBE()
            {
                Anexo = nome,
                IdSolicitacao = int.Parse(Request.QueryString["Cotacao"]),
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd"),
                Tipo = tipo
            };

            _core.CotacaoAnexos_Insert(_CotacaoAnexosBE);

            return link;
        }

        protected void btnSalvarMaisTarde_ServerClick(object sender, EventArgs e)
        {
            salvarCotacao();
            // ####################################### ENVIAR PARA MSG ##########################################
            Response.Redirect("minhas-cotacoes.aspx");
        }
    }
}