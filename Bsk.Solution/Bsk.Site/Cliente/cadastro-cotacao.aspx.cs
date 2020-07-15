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
            if (Request.QueryString["Del"]!=null)
            {
                var anexo = _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdCotacaoAnexos=" + Request.QueryString["Del"]).FirstOrDefault();
                _core.CotacaoAnexos_Delete(anexo);
                Response.Redirect("cadastro-cotacao.aspx?Cotacao=" + Request.QueryString["Cotacao"]);
            }

            if (!IsPostBack)
            {
                if (Request.QueryString["Cotacao"] == null)
                {
                    var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
                    _CotacaoBE = new CotacaoBE()
                    {
                        IdCategoria = int.Parse(Request.QueryString["Id"]),
                        DataCriacao = DateTime.Now.ToString("yyyy-MM-dd"),
                        DataTermino = "",
                        Depoimento = "",
                        Descricao = "",
                        FinalizaCliente = 0,
                        FinalizaFornecedor = 0,
                        IdCliente = login.IdCliente,
                        IdCotacaoFornecedor = 0,
                        Nota = 0,
                        Observacao = "",
                        Status = "1",
                        Titulo = ""
                    };

                    var id = _core.Cotacao_Insert(_CotacaoBE);

                    Response.Redirect("cadastro-cotacao.aspx?Cotacao=" + id);
                }
                else
                {
                    var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();
                    titulo.Value = cotacao.Titulo;
                    descricao.Value = cotacao.Descricao;
                }
            }
        }

        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);

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
            cotacao.Descricao = descricao.InnerHtml;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cotacao.IdCotacao);

            // ####################################### ENVIAR PARA MSG ##########################################
            Response.Redirect("cadastro-cotacao.aspx?Cotacao=" + cotacao.IdCotacao);
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
                var path = Server.MapPath("~/Anexos/Documento") + "\\" + nome;
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

    }
}