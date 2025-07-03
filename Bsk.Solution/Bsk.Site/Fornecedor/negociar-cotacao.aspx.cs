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
    using AjaxControlToolkit;
    using Bsk.BE;
    using Bsk.BE.Model;
    using Bsk.Interface;
    using Bsk.Util;
    using Org.BouncyCastle.Asn1.Ocsp;
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class negociar_cotacao : System.Web.UI.Page
    {
        core _core = new core();
        FornecedorBE _FornecedorBE = new FornecedorBE();
        ParticipanteBE _ParticipanteBE = new ParticipanteBE();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        CotacaoFornecedorChatBE _CotacaoFornecedorChatBE = new CotacaoFornecedorChatBE();
        SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
        ClienteBE _ClienteBE = new ClienteBE();
        CotacaoAnexosBE _CotacaoAnexosBE = new CotacaoAnexosBE();

        protected void Page_Load(object sender, EventArgs e)
        {
            string cotURL = Request.QueryString["Cotacao"];
            if (String.IsNullOrEmpty(Request.QueryString["Id"]))
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }

            try
            {
                CarregaCotacaoFornecedor();

            }
            catch (Exception ex)
            {
                Response.Redirect("../Geral/login.aspx");
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

                SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
                var cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + Request.QueryString["Cotacao"]).FirstOrDefault();

                cotacao.Titulo = titulofornecedor.Value;
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
                    Status = "0",
                    Titulo = titulofornecedor.Value
                };

                cot = _core.Cotacao_Insert(_SolicitacaoBE);
            }
            return cot;
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
                IdSolicitacao = int.Parse(Request.QueryString["Cotacao"]),
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd"),
                Tipo = tipo
            };

            _core.CotacaoAnexos_Insert(_CotacaoAnexosBE);
        }

        public void CarregaCotacaoFornecedor()
        {
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, $" IdCotacao={Request.QueryString["Id"]}").FirstOrDefault();
            /*if (cotacaoFornecedor.Ativo == 0)
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }*/

            if (cotacaoFornecedor != null)
            {
                var cotacao = _core.Cotacao_Get(_SolicitacaoBE, $" IdSolicitacao={cotacaoFornecedor.IdSolicitacao}").FirstOrDefault();
                nrCotacao.InnerText = cotacao.IdSolicitacao.ToString();
                if (cotacao != null)
                {
                    if (cotacao.Status == StatusCotacao.Finalizado)
                    {
                        btnEnviar.Visible = false;
                        divUpload.Visible = false;
                        msg.Visible = false;
                        comentarios.Visible = false;
                    }
                    divDataEntrega.Visible = !string.IsNullOrEmpty(cotacaoFornecedor.DataEntrega);
                    divValorServico.Visible = cotacaoFornecedor.Valor > 0;
                    if (!IsPostBack)
                    {
                        if (divValorServico.Visible)
                        {
                            valorServico.Value = "R$ " + FormatWithPeriod(cotacaoFornecedor.Valor.ToString()) + ",00";
                        }
                        if (divDataEntrega.Visible)
                        {
                            dataEntrega.Value = cotacaoFornecedor.DataEntrega;
                        }
                    }

                    titulofornecedor.Value = cotacao.Titulo;
                    descricao.Text = cotacao.Descricao;
                    valor.InnerText = string.Format("{0:C}", cotacaoFornecedor.Valor);

                    if (cotacao.Status != StatusCotacao.AguardandoAvaliacao)
                    {
                        divAvaliar.Visible = false;
                    }
                    if (cotacao.Status == StatusCotacao.Aberto)
                    {
                        divTerminar.Visible = false;
                        divValor.Visible = false;


                    }
                    else if (cotacao.IdCotacao != 0 && cotacaoFornecedor.IdParticipante == login.IdParticipante && cotacao.FinalizaFornecedor == 0)
                    {
                        divTerminar.Visible = true;
                        divDadosCobranca.Visible = false;
                        divValor.Visible = true;
                    }
                    else
                    {
                        divTerminar.Visible = false;
                        divDadosCobranca.Visible = true;
                    }
                }

                var cliente = _core.Participante_Get(_ParticipanteBE, $" IdParticipante={cotacao.IdParticipante.ToString()}").FirstOrDefault();
                if (cliente != null)
                {
                    ClienteServ.InnerText = cliente.Nome;
                }
            }
        }
        private string FormatWithPeriod(string value)
        {
            int length = value.Length;
            int initialChunkLength = length % 3;
            if (initialChunkLength == 0) initialChunkLength = 3; // Handle case where length is a multiple of 3

            // Start with the initial chunk which could be 1, 2, or 3 characters long
            string formattedValue = value.Substring(0, initialChunkLength);

            // Process the rest of the string in chunks of 3 characters
            for (int i = initialChunkLength; i < length; i += 3)
            {
                formattedValue += "." + value.Substring(i, 3);
            }

            return formattedValue;
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
        protected string Avaliar()
        {
            // Your logic here to determine the URL
            string url = "avaliar.aspx?Id=" + Request.QueryString["Id"];
            return url;
        }

        protected void btnEnviar_ServerClick(object sender, EventArgs e)
        {
            string message = msg.Value.Trim(); // Assuming 'msg' is the server ID of your textarea
            if (string.IsNullOrEmpty(message))
            {
                return; // Exit the function if the message is empty
            }
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);


            var arquivo = GravarArquivo(flpArquivo);
            var video = GravarVideo(flpVideo);
            var _msg = msg.InnerHtml;

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, $" IdCotacao={Request.QueryString["Id"]}").FirstOrDefault();

            if (cotacaoFornecedor != null)
            {
                var cotacao = _core.Cotacao_Get(_SolicitacaoBE, $" IdSolicitacao={cotacaoFornecedor.IdSolicitacao}").FirstOrDefault();
                _CotacaoFornecedorChatBE.IdCotacao = Convert.ToInt32(Request.QueryString["Id"]);
                _CotacaoFornecedorChatBE.Mensagem = _msg;
                _CotacaoFornecedorChatBE.Video = video;
                _CotacaoFornecedorChatBE.Arquivo = arquivo;

                _CotacaoFornecedorChatBE.IdParticipante = login.IdParticipante; //cotacaoFornecedor.IdFornecedor; SEMPRE 0 PARA O QUE VAI RECEBER a MSG
                _CotacaoFornecedorChatBE.LidaFornecedor = 0;

                _core.CotacaoFornecedorChat_Insert(_CotacaoFornecedorChatBE);

                //Atualiza data alteracao da cotação

                if (cotacao != null)
                    _core.Cotacao_Update(cotacao, $" IdSolicitacao={cotacao.IdSolicitacao}");



                NotificacaoBE notif = new NotificacaoBE();

                notif.titulo = "Nova mensagem no chat";
                notif.mensagem = _msg;
                notif.data = DateTime.Now;
                notif.link = $"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}";
                notif.visualizado = "0";
                notif.idcliente = cotacao.IdParticipante;

                _core.NotificacaoInsert(notif);


                //DEPOIS COLOCAR MSG
                //Response.Redirect($"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}");
            }
        }

        public List<CotacaoFornecedorChatBE> CarregaChat()
        {
            var msg = _core.CotacaoFornecedorChat_Get(_CotacaoFornecedorChatBE, $" IdCotacao={Request.QueryString["Id"]} order by IdCotacaoFornecedorChat desc");
            var msgNl = msg.Where(x => x.LidaFornecedor == 0).ToList();
            foreach (var item in msgNl)
            {
                item.LidaFornecedor = 0;
                _core.CotacaoFornecedorChat_Update(item, "IdCotacaoFornecedorChat=" + item.IdCotacaoFornecedorChat);
            }

            return msg;
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
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, $" IdCotacao={Request.QueryString["Id"]}").FirstOrDefault();
            cotacaoFornecedor.DataEntrega = dataEntrega.Value;

            try
            {
                cotacaoFornecedor.Valor = Convert.ToDecimal(valorServico.Value);
            }
            catch (Exception)
            {
                cotacaoFornecedor.Valor = 0;
            }
            _core.CotacaoFornecedor_Update(cotacaoFornecedor, "IdCotacao=" + cotacaoFornecedor.IdCotacao);

            var cotacao = _core.Cotacao_Get(_SolicitacaoBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao).FirstOrDefault();
            var cliente = _core.Participante_Get(_ParticipanteBE, "IdParticipante=" + cotacao.IdParticipante).FirstOrDefault();

            string imagem = VariaveisGlobais.Logo;
            Bsk.Interface.Helpers.EmailTemplate emailTemplate = new Interface.Helpers.EmailTemplate();
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Cliente/negociar-cotacao.aspx?Id=" + cotacaoFornecedor.IdSolicitacao;

            var html = emailTemplate.emailPadrao($"A cotação Nº{cotacao.IdSolicitacao}: {cotacao.Titulo} recebeu uma atualização", $"A cotação Nº{cotacao.IdSolicitacao}: {cotacao.Titulo} recebeu uma atualização nos valores/prazo pelo fornecedor {login.NomeFantasia} para ver mais detalhes acesse a plataforma BRIKK. <br> <a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}", imagem);
            emailTemplate.enviaEmail(html, $"A cotação Nº{cotacao.IdSolicitacao}: {cotacao.Titulo} recebeu uma atualização", cliente.Email);
        }

        public List<CotacaoAnexosBE> PegaAnexo()
        {
            try
            {
               var tata = Request.QueryString["Cotacao"];
               var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, $" IdCotacao={Request.QueryString["Id"]}").FirstOrDefault();
               return _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdSolicitacao=" + cotacaoFornecedor.IdSolicitacao);
            }
            catch (Exception)
            {
                List<CotacaoAnexosBE> cotacaoAnexosBEs = new List<CotacaoAnexosBE>();
                return cotacaoAnexosBEs;
            }

        }



        protected void btnEnviarAnexoFornecedor_ServerClick(object sender, EventArgs e)
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);


            var arquivo = GravarArquivo(flpArquivo);
            var video = GravarVideo(flpVideo);
            var _msg = msg.InnerHtml;

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoBE, $" IdCotacao={Request.QueryString["Id"]}").FirstOrDefault();

            if (cotacaoFornecedor != null)
            {
                _CotacaoFornecedorChatBE.IdCotacao = Convert.ToInt32(Request.QueryString["Id"]);
                _CotacaoFornecedorChatBE.Mensagem = _msg;
                _CotacaoFornecedorChatBE.Video = video;
                _CotacaoFornecedorChatBE.Arquivo = arquivo;

                _CotacaoFornecedorChatBE.IdParticipante = login.IdFornecedor; //cotacaoFornecedor.IdFornecedor; SEMPRE 0 PARA O QUE VAI RECEBER a MSG
                _CotacaoFornecedorChatBE.LidaFornecedor = 0;

                _core.CotacaoFornecedorChat_Insert(_CotacaoFornecedorChatBE);

                //Atualiza data alteracao da cotação
                var cotacao = _core.Cotacao_Get(_SolicitacaoBE, $" IdSolicitacao={cotacaoFornecedor.IdSolicitacao}").FirstOrDefault();
                if (cotacao != null)
                    _core.Cotacao_Update(cotacao, $" IdSolicitacao={cotacao.IdSolicitacao}");



                NotificacaoBE notif = new NotificacaoBE();

                notif.titulo = "Nova mensagem no chat";
                notif.mensagem = _msg;
                notif.data = DateTime.Now;
                notif.link = $"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}";
                notif.visualizado = "0";
                notif.idcliente = cotacao.IdParticipante;

                _core.NotificacaoInsert(notif);


                //DEPOIS COLOCAR MSG
                Response.Redirect($"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}");
            }
        }


        public List<CotacaoFornecedorListaModel> PegaCotacoes()
        {
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cotacoes = _core.CotacaoFornecedorListaStatusGet(login.IdParticipante, StatusCotacao.EmAndamento);
            List<CotacaoFornecedorListaModel> lista = new List<CotacaoFornecedorListaModel>();
            foreach (var item in cotacoes)
            {
                bool adciona = true;
                if (item.Status == StatusCotacao.Aberto)
                {
                    item.Status = "Aberto";
                }
                else if (item.Status == StatusCotacao.EmAndamento)
                {
                    if (item.CFId != item.IdFornecedorDB)
                    {
                        adciona = false;
                    }
                    item.Status = "Em andamento";

                    if (item.FinalizaCliente == 0 && item.FinalizaFornecedor == 1)
                    {
                        item.Status = "Pendente de finalização do cliente";
                    }
                }
                else if (item.Status == StatusCotacao.AguardandoPagamento)
                {
                    if (item.CFId != item.IdFornecedorDB)
                    {
                        adciona = false;
                    }
                    item.Status = "Aguardando pagamento";
                }
                else if (item.Status == StatusCotacao.Finalizado)
                {
                    if (item.CFId != item.IdFornecedorDB)
                    {
                        adciona = false;
                    }
                    item.Status = "Finalizado";
                }
                if (adciona)
                {
                    lista.Add(item);
                }
            }
            return lista;
        }

    }
}