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
        CotacaoFornecedorBE _CotacaoFornecedorBE = new CotacaoFornecedorBE();
        CotacaoFornecedorChatBE _CotacaoFornecedorChatBE = new CotacaoFornecedorChatBE();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        ClienteBE _ClienteBE = new ClienteBE();
        CotacaoAnexosBE _CotacaoAnexosBE = new CotacaoAnexosBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            CotacaoBE cotacao = new CotacaoBE();
            if (!String.IsNullOrEmpty(Request.QueryString["Cotacao"]))
            {
                cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();

                if (cotacao.Status != StatusCotacao.Criacao)
                {
                    btnSalvar.Visible = false;
                    btnSubmeter.Visible = false;
                    divUpload.Visible = false;
                    // alerts.Visible = false;
                    // alerts2.Visible = false;
                }

                if(cotacao.Status == "8")
                {
                    btnSalvar.Visible = true;
                    btnSubmeter.Visible = true;
                    divUpload.Visible = false;
                }
            }

            if (Request.QueryString["Del"] != null && cotacao.Status == StatusCotacao.Criacao)
            {
                var anexo = _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdCotacaoAnexos=" + Request.QueryString["Del"]).FirstOrDefault();
                _core.CotacaoAnexos_Delete(anexo);
                Response.Redirect("cadastro-cotacao.aspx?Cotacao=" + Request.QueryString["Cotacao"]);
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
                    divUpload.Visible = false;
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
                Response.Redirect("cadastro-cotacao.aspx?Cotacao=" + redi);
            }
        }

        private string salvarCotacao()
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
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

                CotacaoBE _CotacaoBE = new CotacaoBE();
                var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();

                cotacao.Titulo = titulo.Value;
                cotacao.Descricao = descricao.Text;
                _core.Cotacao_Update(cotacao, "IdCotacao=" + cotacao.IdCotacao);
            }
            else
            {
                CotacaoBE _CotacaoBE = new CotacaoBE()
                {
                    IdCategoria = int.Parse(Request.QueryString["Id"]),
                    DataCriacao = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                    DataTermino = "",
                    Depoimento = "",
                    Descricao = descricao.Text,
                    FinalizaCliente = 0,
                    FinalizaFornecedor = 0,
                    IdCliente = login.IdCliente,
                    IdCotacaoFornecedor = 0,
                    Nota = 0,
                    Observacao = "",
                    Status = "8", //Rascunho
                    Titulo = titulo.Value
                };

                cot = _core.Cotacao_Insert(_CotacaoBE);
            }
            return cot;
        }

        public List<CotacaoAnexosBE> PegaAnexo()
        {
            return _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdCotacao=" + Request.QueryString["Cotacao"]);
        }

        public void GravarArquivo(FileUpload _flpImg, string tipo)
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
                IdCotacao = int.Parse(Request.QueryString["Cotacao"]),
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd"),
                Tipo = tipo
            };

            _core.CotacaoAnexos_Insert(_CotacaoAnexosBE);
        }

        protected void btnSalvarMaisTarde_ServerClick(object sender, EventArgs e)
        {
            salvarCotacao();
            // ####################################### ENVIAR PARA MSG ##########################################
            Response.Redirect("minhas-cotacoes.aspx");
        }
    }
}