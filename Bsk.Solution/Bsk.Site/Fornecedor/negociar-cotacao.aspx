<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="negociar-cotacao.aspx.cs" ValidateRequest="false" Inherits="Bsk.Site.Fornecedor.negociar_cotacao" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Negociação<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <a class="btn btn-brikk pull-right" href="minhas-cotacoes.aspx"><i class="glyphicon glyphicon-circle-arrow-left" title="VOLTAR" style="padding: 10px;"></i>&nbsp;Voltar</a>
            <h2 class="tableTitle">
                <p>Cliente:</p>
                <div id="ClienteServ" runat="server" text=""></div>
            </h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <h3>Título Serviço:
                    <asp:Label ID="titulo" runat="server" Text=""></asp:Label>
                </h3>
            </div>

            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0" style="font-size: 18px; line-height: 30px;">
                Descrição Serviço:
                <asp:Label ID="descricao" runat="server" Text=""></asp:Label>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0" id="divValor" runat="server">
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 valorServico">
                    <h2>
                        <strong>
                            <p>Data entrega: <strong id="entrega" runat="server" text=""></strong></p>
                        </strong>
                    </h2>
                </div>
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 valorServico">
                    <h2>
                        <strong>
                            <p>Valor do serviço: <strong id="valor" runat="server" text=""></strong></p>
                        </strong>
                    </h2>
                </div>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0" id="divUpload" runat="server">
                <asp:FileUpload ID="flpArquivo" CssClass="flpArquivo" runat="server" />
                <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" />
                <button type="button" class="btn btn-upload" id="btnArquivo">
                    <img src="img/upload.png" alt="">&nbsp;&nbsp;Anexar Arquivos</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-upload" id="btnVideo">
                    <img src="img/video.png" alt="">&nbsp;&nbsp;Gravar um vídeo explicativo</button>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0" id="comentarios" runat="server">
                <textarea name="" id="msg" runat="server" class="form-control" cols="30" rows="10"></textarea><br>
                <button class="btn btn-brikk btn-lg pull-right" id="btnEnviar" runat="server" onserverclick="btnEnviar_ServerClick" style="width: 100%;">Enviar</button>
            </div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12" style="height: 379px; overflow-y: scroll;">
                <h3 style="margin-top: 0; border-bottom: 1px solid #b8272c;">Mensagens:</h3>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert alert-success bg-success" id="divTerminar" runat="server" style="width: 100%;">
                        <span class="tableTitle"><small>Mensagem do sistema:</small><br />
                            <strong>Legal!!</strong> Agora falta pouco para concluirem. Informe seu cliente que o serviço já foi finalizado.<br />
                            Uma dica, se possível envie uma foto para ele. Assim fica mais fácil para todos.</span><br />
                        <br />
                        <input type="button" class="btn btn-success btn-lg pull-right" id="btnTerminar" onclick="terminar();" value="Informar Término" style="width: 100%;">
                    </div>
                    <div id="divChat">
                        <%
                            var chat = CarregaChat();

                            var cliente = @"<!--CLIENTE-->
                <div class='mensagem alert alert-info bg-warning pull-left' style='border-radius: 200px 200px 200px 0px;'>
                    {{CLIENTEMSG}}
                </div>
                <!--FIM CLIENTE-->";

                            var fornecedor = @"<!--FORNECEDOR-->
                <div class='mensagem alert alert-danger bg-danger pull-right' style='border-radius: 200px 200px 0px 200px;'>
                    {{FORNECEDORMSG}}
                </div>
                <!--FIM FORNECEDOR-->";

                            var conteudo = "";
                            foreach (var item in chat)
                            {
                                var arquivo = "";
                                if (!String.IsNullOrEmpty(item.Arquivo))
                                    arquivo = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Documento/" + item.Arquivo + "' target='_blank'><img alt='' src='img/upload.png'></a>";

                                var video = "";
                                if (!String.IsNullOrEmpty(item.Video))
                                    video = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Video/" + item.Video + "' target='_blank'><img alt='' src='img/video.png'></a>";


                                if (item.IdCliente == 0)
                                    conteudo = cliente.Replace("{{CLIENTEMSG}}", item.Mensagem + "<BR>" + video + "&nbsp;&nbsp;&nbsp;" + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span>");
                                else
                                    conteudo = fornecedor.Replace("{{FORNECEDORMSG}}", item.Mensagem + "<BR>" + video + "&nbsp;&nbsp;&nbsp;" + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span>");
                        %>

                        <!--CLIENTE-->
                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>

                        <%Response.Write(conteudo);%>

                        <!--FIM CLIENTE-->

                        <%
                            }

                        %>
                    </div>
                </div>
            </div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 dadosServico" runat="server" id="divDadosCobranca">
                <label>Informe uma data para terminar o serviço</label>
                <input type="date" class="from-control" id="dataEntrega" runat="server" />
                <label>Informe o valor que você vai cobrar pelo serviço</label>
                <input type="text" class="from-control dinheiro" id="valorServico" runat="server" /><br />
                <br />

                <button class="btn btn-brikk btn-lg pull-right" id="btnSalvarDados" onserverclick="btnSalvarDados_ServerClick" runat="server">Salvar dados do serviço</button>
            </div>

            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <h3>Arquivos anexos</h3>

            <hr style="width: 100%;" />
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Tipo de documento</td>
                        <td>Ações</td>
                    </tr>
                </thead>
                <tbody>
                    <!--LOOP DOCUMENTO-->
                    <%var anexos = PegaAnexo();
                        foreach (var item in anexos)
                        {%>
                    <tr>
                        <td><%Response.Write(item.Anexo); %></td>
                        <td>
                            <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>&Del=<%Response.Write(item.IdCotacaoAnexos); %>">Deletar</a>&nbsp;&nbsp;
                                <%if (item.Tipo == "Anexo")
                                    {%>
                            <a class="btn btn-brikk" href='<%Response.Write(ConfigurationManager.AppSettings["host"]);%>Anexos/Documento/<%Response.Write(item.Anexo);%>' target='_blank'>
                                <img alt='' src='img/upload.png'>&nbsp;Visualizar</a>
                            <% }
                                else
                                {%>
                            <a class="btn btn-brikk" href='<%Response.Write(ConfigurationManager.AppSettings["host"]);%>Anexos/Video/<%Response.Write(item.Anexo);%>' target='_blank'>Visualizar</a>
                            <% } %>
                        </td>
                    </tr>
                    <%}
                    %>
                    <!-- FIM LOOP DOCUMENTO-->
                </tbody>
            </table>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        </div>


        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

    <script type="text/javascript">

        setInterval(function () {
            var parametro = {
                tipo:"F",
                id:comum.queryString("Id")
            };
            comum.getAsync("Comum/CarregaChat", parametro, function (data) {
                $("#divChat").empty();
                $("#divChat").append(data);
            });
        }, 10000);

        $(document).ready(function () {
            $(".flpArquivo").css("display", "none");
            $(".flpVideo").css("display", "none");

            $("#btnArquivo").click(function () {
                $(".flpArquivo").click();
            });

            $("#btnVideo").click(function () {
                $(".flpVideo").click();
            });

        });

        function terminar() {
            Swal.fire({
                title: 'Terminar?',
                text: "Você tem certeza que gostaria de informar que completou o serviço? Essa ação é irreversível.",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Terminei!'
            }).then((result) => {
                if (result.value) {
                    var parametro = {
                        idCotacaoFornecedor: comum.queryString("Id")
                    };
                    comum.postAsync("Comum/TerminarServico", parametro, function (data) {
                        window.location.href = "minhas-cotacoes.aspx";
                    });
                }
            });
        }


    </script>

</asp:Content>
