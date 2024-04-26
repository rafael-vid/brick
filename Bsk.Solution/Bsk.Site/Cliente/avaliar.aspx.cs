using Bsk.BE;
using Bsk.BE.Model;
using Bsk.Interface;
using Bsk.Site.Admin;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class avaliar : System.Web.UI.Page
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

            if (!IsPostBack)
            {
                try
                {
                    CarregaCotacaoFornecedor();
                }
                catch (Exception)
                {
                    Response.Redirect("minhas-cotacoes.aspx");
                }

            }


        }
        public List<CotacaoListaFronecedorModel> PegaCotacaoLista()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            AreaFornecedorBE areaFornecedorBE = new AreaFornecedorBE();
            List<CotacaoListaFronecedorModel> lista = new List<CotacaoListaFronecedorModel>();
            var categorias = _core.AreaFornecedor_Get(areaFornecedorBE, "IdFornecedor=" + login.IdFornecedor);
            string cats = "";
            foreach (var item in categorias)
            {
                cats += item.IdCategoria + ",";
            }
            lista = _core.CotacaoListaFronecedorGet(cats + "0", login.IdFornecedor.ToString());

            return lista;
        }

        public void CarregaCotacaoFornecedor()
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();

            if (cotacaoFornecedor != null)
            {
                if (cotacaoFornecedor.Novo == 1)
                {
                    cotacaoFornecedor.Novo = 0;
                    _core.CotacaoFornecedor_Update(cotacaoFornecedor, $" IdCotacaoFornecedor={Request.QueryString["Id"]}");
                }

                if (cotacaoFornecedor.Ativo == 0)
                {
                    Response.Redirect("minhas-cotacoes.aspx");
                }

               
                if (cotacaoFornecedor != null)
                {
                    var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
                    if (cotacao != null)
                    {

                        tituloCot.InnerText = cotacao.Titulo;
                        descricaoCot.InnerText = cotacao.Descricao;

                
                    }

                    var fornecedor = _core.Fornecedor_Get(_FornecedorBE, $" IdFornecedor={cotacaoFornecedor.IdFornecedor.ToString()}").FirstOrDefault();
                    if (fornecedor != null)
                    {
                        parceiro.InnerText = fornecedor.RazaoSocial;
                    }

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

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            if (cotacaoFornecedor != null)
            {
                _CotacaoFornecedorChatBE.IdCotacaoFornecedor = Convert.ToInt32(Request.QueryString["Id"]);

                _CotacaoFornecedorChatBE.IdCliente = login.IdCliente; // RETIRAR DO CODE
                _CotacaoFornecedorChatBE.IdFornecedor = 0; //cotacaoFornecedor.IdFornecedor; SEMPRE 0 PARA O QUE VAI RECEBER a MSG
                _CotacaoFornecedorChatBE.LidaCliente = 1;
                //Atualiza data alteracao da cotação
                var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
                if (cotacao != null)
                    _core.Cotacao_Update(cotacao, $" IdCotacao={cotacao.IdCotacao}");

                NotificacaoBE notif = new NotificacaoBE();

                notif.titulo = "Nova mensagem no chat";

                notif.data = DateTime.Now;
                notif.link = $"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}";
                notif.visualizado = "0";
                notif.idfornecedor = cotacaoFornecedor.IdFornecedor;

                _core.NotificacaoInsert(notif);

                _core.CotacaoFornecedorChat_Insert(_CotacaoFornecedorChatBE);
                //DEPOIS COLOCAR MSG
                Response.Redirect($"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}");
            }
        }

        protected void btnDepoimento_ServerClick(object sender, EventArgs e)
        {
            CotacaoFornecedorBE cotacaoFornecedorBE = new CotacaoFornecedorBE();
            var cf = _core.CotacaoFornecedor_Get(cotacaoFornecedorBE, "IdCotacaoFornecedor=" + Request.QueryString["Id"]).FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cf.IdCotacao).FirstOrDefault();
            cotacao.Observacao = depoimentoCliente.InnerText;
            _core.Cotacao_Update(cotacao, "IdCotacao=" + cf.IdCotacao);
            Response.Redirect("minhas-cotacoes.aspx");
        }

        public List<CotacaoFornecedorChatBE> CarregaChat()
        {
            var msg = _core.CotacaoFornecedorChat_Get(_CotacaoFornecedorChatBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]} order by IdCotacaoFornecedorChat desc");
            var msgNl = msg.Where(x => x.LidaCliente == 0).ToList();
            foreach (var item in msgNl)
            {
                item.LidaCliente = 1;
                _core.CotacaoFornecedorChat_Update(item, "IdCotacaoFornecedorChat=" + item.IdCotacaoFornecedorChat);
            }
            return msg;

        }

        public CotacaoAvaliacaoFornecedorModel PegaCotacao()
        {
            CotacaoAvaliacaoFornecedorModel cotacao = _core.Cotacao_Avaliacao_Fornecedor_Get(Request.QueryString["Id"]);
            depoimentoCliente.InnerText = cotacao.Observacao;

            if (!String.IsNullOrEmpty(cotacao.Observacao))
            {
                btnDepoimento.Visible = false;
            }
            return cotacao;
        }

        public string pegaStatus()
        {
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
            var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
            if (cotacao.Status == "1")
            {
                return "cotacao-lista.aspx?Id=" + cotacao.IdCotacao;
            }
            else
            {
                return "minhas-cotacoes.aspx";
            }
        }
    }
}
