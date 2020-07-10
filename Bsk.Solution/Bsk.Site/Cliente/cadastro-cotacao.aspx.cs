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

        }

        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            var arquivo = GravarArquivo(flpAnexo);
            CotacaoBE _CotacaoBE = new CotacaoBE();
            _CotacaoBE.IdCategoria = 14; // ################################################################################
            _CotacaoBE.IdCliente = 30; // #################################################################################
            _CotacaoBE.Titulo = titulo.Value;
            _CotacaoBE.Descricao = descricao.InnerHtml;
            var IdCotacao = _core.Cotacao_Insert(_CotacaoBE);

            _CotacaoAnexosBE.Anexo = arquivo;
            _CotacaoAnexosBE.IdCotacao = Convert.ToInt32(IdCotacao);
            _core.CotacaoAnexos_Insert(_CotacaoAnexosBE);

            // ####################################### ENVIAR PARA MSG ##########################################
            Response.Redirect("cadastro-cotacao?Id=" + IdCotacao);
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

    }
}