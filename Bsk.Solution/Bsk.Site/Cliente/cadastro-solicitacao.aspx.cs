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
    using Bsk.Site.Admin;
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
            SolicitacaoBE cotacao = null;
            if (!String.IsNullOrEmpty(Request.QueryString["Cotacao"]))
            {
                cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();
            }

            if (cotacao != null)
            {
                BindCategoria(cotacao.IdCategoria);
                BindServicos(cotacao.IdServico);

                if (cotacao.Status != StatusCotacao.Criacao)
                {
                    divUpload.Visible = true;
                }
            }
            else
            {
                BindCategoriaFromQuery();
                BindServicosFromQuery();
            }

            if (Request.QueryString["Del"] != null && cotacao != null && cotacao.Status == StatusCotacao.Criacao)
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
                    //btnSubmeter.Visible = false;
                }
            }
        }

        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            if (!ValidarCamposObrigatorios())
            {
                return; // Interrompe o processo se a validação falhar
            }
            // ####################################### ENVIAR PARA MSG ##########################################
            var redi = salvarCotacao();

            if (string.IsNullOrEmpty(redi))
            {
                return;
            }

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
                var normalizedServices = NormalizeServiceIds(Request.QueryString["Servicos"]);

                if (string.IsNullOrEmpty(normalizedServices))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "serviceSelectionAlert", "Swal.fire({ toast: true, icon: 'info', title: 'Atenção', text: 'Selecione pelo menos um serviço na etapa anterior.' });", true);
                    return string.Empty;
                }

                SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE()
                {
                    IdCategoria = int.Parse(Request.QueryString["Id"]),
                    IdServico = normalizedServices,
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
        private void BindCategoria(int categoriaId)
        {
            var categorias = _core.Categoria_Get(new CategoriaBE(), $" IdCategoria = {categoriaId}");
            if (categorias != null && categorias.Count > 0)
            {
                litCategoria.Text = HttpUtility.HtmlEncode(categorias[0].Nome);
            }
            else
            {
                litCategoria.Text = string.Empty;
            }
        }

        private void BindCategoriaFromQuery()
        {
            int categoriaId;
            if (int.TryParse(Request.QueryString["Id"], out categoriaId))
            {
                BindCategoria(categoriaId);
            }
            else
            {
                litCategoria.Text = string.Empty;
            }
        }

        private void BindServicos(string rawServices)
        {
            var serviceIds = ParseServiceIds(rawServices).ToList();
            if (!serviceIds.Any())
            {
                servicosSelecionadosContainer.Visible = false;
                litServicos.Text = string.Empty;
                return;
            }

            var filtro = $" IdServico in ({string.Join(",", serviceIds)})";
            var servicos = _core.Servico_Get(new ServicoBE(), filtro);

            if (servicos != null && servicos.Count > 0)
            {
                var servicosOrdenados = serviceIds
                    .Select(id => servicos.FirstOrDefault(s => s.IdServico == id))
                    .Where(s => s != null);

                litServicos.Text = string.Join(string.Empty, servicosOrdenados.Select(s => $"<li>{HttpUtility.HtmlEncode(s.Nome)}</li>"));
                servicosSelecionadosContainer.Visible = true;
            }
            else
            {
                servicosSelecionadosContainer.Visible = false;
                litServicos.Text = string.Empty;
            }
        }

        private void BindServicosFromQuery()
        {
            BindServicos(Request.QueryString["Servicos"]);
        }

        private IEnumerable<int> ParseServiceIds(string rawServices)
        {
            if (string.IsNullOrWhiteSpace(rawServices))
            {
                return Enumerable.Empty<int>();
            }

            var ids = new List<int>();
            var parts = rawServices.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (var part in parts)
            {
                var trimmed = part.Trim();
                int parsed;
                if (int.TryParse(trimmed, out parsed) && !ids.Contains(parsed))
                {
                    ids.Add(parsed);
                }
            }

            return ids;
        }

        private string NormalizeServiceIds(string rawServices)
        {
            var ids = ParseServiceIds(rawServices);
            return string.Join(",", ids);
        }
        protected bool ValidarCamposObrigatorios()
        {
            if (string.IsNullOrWhiteSpace(titulo.Value))
            {
                // Exibe mensagem de erro usando SweetAlert
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "Swal.fire({ toast: true, icon: 'info', title: 'Atenção', text: 'O campo Descrição é obrigatório!' });", true);
                return false;
            }

            if (string.IsNullOrWhiteSpace(descricao.Text)) // Corrected from descricao.Value to descricao.Text
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "Swal.fire({ toast: true, icon: 'info', title: 'Atenção', text: 'O campo Detalhamento é obrigatório!' });", true);
                return false;
            }

            return true;
        }
        protected void btnSalvarMaisTarde_ServerClick(object sender, EventArgs e)
        {
            salvarCotacao();
            // ####################################### ENVIAR PARA MSG ##########################################
            Response.Redirect("minhas-cotacoes.aspx");
        }
        [System.Web.Services.WebMethod]
        public static void AutoSave(string cotacao, string titulo, string descricao)
        {
            var core = new core();
            var solicitacaoBE = new SolicitacaoBE();
            if (!string.IsNullOrEmpty(cotacao))
            {
                var cotacaoObj = core.Cotacao_Get(solicitacaoBE, "IdSolicitacao=" + cotacao).FirstOrDefault();
                if (cotacaoObj != null)
                {
                    cotacaoObj.Titulo = titulo;
                    cotacaoObj.Descricao = descricao;
                    core.Cotacao_Update(cotacaoObj, "IdSolicitacao=" + cotacaoObj.IdSolicitacao);
                }
            }
        }

    }
}