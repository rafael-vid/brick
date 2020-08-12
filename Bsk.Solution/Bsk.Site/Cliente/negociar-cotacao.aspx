<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="negociar-cotacao.aspx.cs" ValidateRequest="false" Inherits="Bsk.Site.Cliente.negociar_cotacao" MasterPageFile="~/Cliente/Master/Layout.Master" %>



<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Negociação<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <button class="btn btn-brikk pull-right"><i class="glyphicon glyphicon-circle-arrow-left" title="VOLTAR" style="padding: 10px;"></i>&nbsp;Voltar</button>
            <h2 class="tableTitle">
                <p>Prestador de Serviço:</p>
                <div id="parceiro" runat="server" text=""></div>
            </h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <h3>
                    Título Serviço: <asp:Label ID="titulo" runat="server" Text=""></asp:Label>
                </h3>
            </div>

            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12" style="font-size: 18px; line-height: 30px;">
                Descrição Serviço: <asp:Label ID="descricao" runat="server" Text=""></asp:Label>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 valorServico">
                    <h2>
                        <strong>
                            <p>Data entrega: <strong id="dataEntrega" runat="server" text=""></strong></p>
                        </strong>
                    </h2>
                </div>
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 valorServico">
                    <h2>
                        <strong>
                            <p>Valor do serviço: <strong id="vlr" runat="server" text=""></strong></p>
                        </strong>
                    </h2>
                </div>
                <br />
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

            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0" id="descricaoHide" runat="server">
                <textarea name="" id="msg" runat="server" class="form-control" cols="30" rows="10"></textarea><br>
                <button class="btn btn-brikk btn-lg pull-right" id="btnEnviar" runat="server" onserverclick="btnEnviar_ServerClick" style="width: 100%;">Enviar</button>
            </div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12" style="height: 379px; overflow-y: scroll;">
                <h3 style="margin-top: 0; border-bottom: 1px solid #b8272c;">Mensagens</h3>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert alert-success bg-success" id="divTerminado" runat="server" style="width: 100%;">
                    <span class="tableTitle"><small>Mensagem do sistema:</small><br />
                        O fornecedor alegou ter terminado o serviço.</span><br />
                    <br />
                    <input type="button" class="btn btn-brikk btn-lg pull-left" onclick="terminar('0');" value="Não aceitar">&nbsp; &nbsp;
                 <input type="button" class="btn btn-success btn-lg pull-right" onclick="terminar('1');" value="Aceitar">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert alert-warning bg-warning" id="divAceitar" runat="server" style="width: 100%;">
                    <span class="tableTitle"><small>Mensagem do sistema:</small><br />
                        Gostaria de aceitar a oferta deste Parceiro?.</span><br />
                    <br />
                    <input type="button" class="btn btn-brikk btn-lg pull-right" id="btnAceitar" onclick="aceitar();" value="Aceitar" style="width: 100%;">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">

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

            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>

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
                        <%--<%var anexos = PegaAnexo();
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
                        %>--%>
                        <!-- FIM LOOP DOCUMENTO-->
                    </tbody>
                </table>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        </div>


        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

    <script type="text/javascript">
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

        function aceitar() {
            Swal.fire({
                title: 'Aceitar?',
                text: "Você tem certeza que gostaria de aceitar essa cotação? Todas as outras cotações serão ignoradas e você será redirecionado para uma página de pagamento.",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Aceitar!'
            }).then((result) => {
                if (result.value) {
                    var parametro = {
                        idCotacaoFornecedor: comum.queryString("Id")
                    };
                    comum.postAsync("Comum/AceitarCotacao", parametro, function (data) {
                        window.location.href = "pagamento.aspx?Id=" + comum.queryString("Id");
                    });
                }
            });
        }

        function terminar(valor) {
            var titulo = "";
            var texto = "";
            var botao = "";
            if (valor == "0") {
                titulo = "Negar término?";
                texto = "Ao não aceitar o término do serviço é aconselhável deixar ao menos uma mensagem para o fornecedor dos motivos que levaram ao não aceite.";
                botao = "Negar!";
            } else {
                titulo = "Aceitar término?";
                texto = "Você tem certeza que gostaria de aceitar o término do serviço? O pagamento será liberado ao prestador. Esse processo é irreversível.";
                botao = "Aceitar!";
            }

            Swal.fire({
                title: titulo,
                text: texto,
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: botao
            }).then((result) => {
                if (result.value) {
                    var parametro = {
                        idCotacaoFornecedor: comum.queryString("Id"),
                        status: valor
                    };
                    comum.postAsync("Comum/AceitarTermino", parametro, function (data) {
                        if (data.Result == "0") {
                            window.location.href = "em-andamento.aspx";
                        } else {
                            if (data.Liberado == "4") {
                                window.location.href = "finalizado.aspx";
                            } else {
                                window.location.href = "liberar-pagamento.aspx";
                            }
                        }

                    });
                }
            });
        }

    </script>

</asp:Content>
