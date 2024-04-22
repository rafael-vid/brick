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
        CotacaoAnexosBE _CotacaoAnexosBE = new CotacaoAnexosBE();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(Request.QueryString["Id"]))
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }

            try
            {
                CarregaCotacaoFornecedor();

                // After loading cotacao fornecedor, format the delivery date
                if (!IsPostBack && dataEntrega.Value != null)
                {
                    DateTime deliveryDate;
                    if (DateTime.TryParse(dataEntrega.Value, out deliveryDate))
                    {
                        dataEntrega.Value = deliveryDate.ToString("dd/MM/yyyy");
                    }
                }
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

                cotacao.Titulo = titulofornecedor.Value;
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
                    Status = "0",
                    Titulo = titulofornecedor.Value
                };

                cot = _core.Cotacao_Insert(_CotacaoBE);
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
                IdCotacao = int.Parse(Request.QueryString["Cotacao"]),
                DataCriacao = DateTime.Now.ToString("yyyy-MM-dd"),
                Tipo = tipo
            };

            _core.CotacaoAnexos_Insert(_CotacaoAnexosBE);
        }

        public void CarregaCotacaoFornecedor()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
            /*if (cotacaoFornecedor.Ativo == 0)
            {
                Response.Redirect("minhas-cotacoes.aspx");
            }*/

            if (cotacaoFornecedor != null)
            {
                var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
                nrCotacao.InnerText = cotacao.IdCotacao.ToString();
                if (cotacao != null)
                {
                    if (cotacao.Status == StatusCotacao.Finalizado)
                    {
                        btnEnviar.Visible = false;
                        divUpload.Visible = false;
                        msg.Visible = false;
                        comentarios.Visible = false;
                    }

                    if (!IsPostBack)
                    {
                        valorServico.Value = "R$" + FormatWithPeriod(cotacaoFornecedor.Valor.ToString()) + ",00";
                        dataEntrega.Value = cotacaoFornecedor.DataEntrega;
                    }

                    titulofornecedor.Value = cotacao.Titulo;
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
                        divDadosCobranca.Visible = true;
                    }
                }

                var cliente = _core.Cliente_Get(_ClienteBE, $" IdCliente={cotacao.IdCliente.ToString()}").FirstOrDefault();
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

        protected void btnEnviar_ServerClick(object sender, EventArgs e)
        {
            string message = msg.Value.Trim(); // Assuming 'msg' is the server ID of your textarea
            if (string.IsNullOrEmpty(message))
            {
                return; // Exit the function if the message is empty
            }
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);


            var arquivo = GravarArquivo(flpArquivo);
            var video = GravarVideo(flpVideo);
            var _msg = msg.InnerHtml;

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();

            if (cotacaoFornecedor != null)
            {
                var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
                _CotacaoFornecedorChatBE.IdCotacaoFornecedor = Convert.ToInt32(Request.QueryString["Id"]);
                _CotacaoFornecedorChatBE.Mensagem = _msg;
                _CotacaoFornecedorChatBE.Video = video;
                _CotacaoFornecedorChatBE.Arquivo = arquivo;

                _CotacaoFornecedorChatBE.IdCliente = cotacao.IdCliente; // RETIRAR DO CODE
                _CotacaoFornecedorChatBE.IdFornecedor = login.IdFornecedor; //cotacaoFornecedor.IdFornecedor; SEMPRE 0 PARA O QUE VAI RECEBER a MSG
                _CotacaoFornecedorChatBE.LidaFornecedor = 1;

                _core.CotacaoFornecedorChat_Insert(_CotacaoFornecedorChatBE);

                //Atualiza data alteracao da cotação
                
                if (cotacao != null)
                    _core.Cotacao_Update(cotacao, $" IdCotacao={cotacao.IdCotacao}");



                NotificacaoBE notif = new NotificacaoBE();

                notif.titulo = "Nova mensagem no chat";
                notif.mensagem = _msg;
                notif.data = DateTime.Now;
                notif.link = $"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}";
                notif.visualizado = "0";
                notif.idcliente = cotacao.IdCliente;

                _core.NotificacaoInsert(notif); 


                //DEPOIS COLOCAR MSG
                //Response.Redirect($"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}");
            }
        }

        public List<CotacaoFornecedorChatBE> CarregaChat()
        {
            var msg = _core.CotacaoFornecedorChat_Get(_CotacaoFornecedorChatBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]} order by IdCotacaoFornecedorChat desc");
            var msgNl = msg.Where(x => x.LidaFornecedor == 0).ToList();
            foreach (var item in msgNl)
            {
                item.LidaFornecedor = 1;
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

            var cotacao = _core.Cotacao_Get(_CotacaoBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao).FirstOrDefault();
            var cliente = _core.Cliente_Get(_ClienteBE, "IdCliente=" + cotacao.IdCliente).FirstOrDefault();

            string imagem = VariaveisGlobais.Logo;
            Bsk.Interface.Helpers.EmailTemplate emailTemplate = new Interface.Helpers.EmailTemplate();
            string link = ConfigurationManager.AppSettings["host"].ToString() + "Cliente/negociar-cotacao.aspx?Id=" + cotacaoFornecedor.IdCotacao;

            var html = emailTemplate.emailPadrao($"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização", $"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização nos valores/prazo pelo fornecedor {login.NomeFantasia} para ver mais detalhes acesse a plataforma BRIKK. <br> <a href='{link}'>Acesse</a><br>Caso o link acima não funcione, basta colar essa url no seu navegador:<br>{link}", imagem);
            emailTemplate.enviaEmail(html, $"A cotação Nº{cotacao.IdCotacao}: {cotacao.Titulo} recebeu uma atualização", cliente.Email);
        }

        public List<CotacaoAnexosBE> PegaAnexo()
        {
            try
            {
                var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();
                return _core.CotacaoAnexos_Get(_CotacaoAnexosBE, "IdCotacao=" + cotacaoFornecedor.IdCotacao);
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

            var cotacaoFornecedor = _core.CotacaoFornecedor_Get(_CotacaoFornecedorBE, $" IdCotacaoFornecedor={Request.QueryString["Id"]}").FirstOrDefault();

            if (cotacaoFornecedor != null)
            {
                _CotacaoFornecedorChatBE.IdCotacaoFornecedor = Convert.ToInt32(Request.QueryString["Id"]);
                _CotacaoFornecedorChatBE.Mensagem = _msg;
                _CotacaoFornecedorChatBE.Video = video;
                _CotacaoFornecedorChatBE.Arquivo = arquivo;

                _CotacaoFornecedorChatBE.IdCliente = 0; // RETIRAR DO CODE
                _CotacaoFornecedorChatBE.IdFornecedor = login.IdFornecedor; //cotacaoFornecedor.IdFornecedor; SEMPRE 0 PARA O QUE VAI RECEBER a MSG
                _CotacaoFornecedorChatBE.LidaFornecedor = 1;

                _core.CotacaoFornecedorChat_Insert(_CotacaoFornecedorChatBE);

                //Atualiza data alteracao da cotação
                var cotacao = _core.Cotacao_Get(_CotacaoBE, $" IdCotacao={cotacaoFornecedor.IdCotacao}").FirstOrDefault();
                if (cotacao != null)
                    _core.Cotacao_Update(cotacao, $" IdCotacao={cotacao.IdCotacao}");



                NotificacaoBE notif = new NotificacaoBE();

                notif.titulo = "Nova mensagem no chat";
                notif.mensagem = _msg;
                notif.data = DateTime.Now;
                notif.link = $"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}";
                notif.visualizado = "0";
                notif.idcliente = cotacao.IdCliente;

                _core.NotificacaoInsert(notif);


                //DEPOIS COLOCAR MSG
                Response.Redirect($"negociar-cotacao.aspx?Id={Request.QueryString["Id"]}");
            }
        }
    }
}