<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="negociar-cotacao.aspx.cs" Inherits="Bsk.Site.Fornecedor.negociar_cotacao" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>



<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <h2 class="tableTitle">
                <p>Prestador de Serviço:</p>
                <br>
                <asp:Label ID="prestador" runat="server" Text=""></asp:Label>
            </h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <h3>
                    <asp:Label ID="titulo" runat="server" Text=""></asp:Label>
                </h3>
            </div>

            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 boxDesc">
                <asp:Label ID="descricao" runat="server" Text=""></asp:Label>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <asp:FileUpload ID="flpArquivo" CssClass="flpArquivo" runat="server" />
                <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" />
                <button type="button" class="btn btn-upload" id="btnArquivo">
                    <img src="img/upload.png" alt="">&nbsp;&nbsp;Anexar Arquivos</button>&nbsp;&nbsp;
                <button type="button" class="btn btn-upload" id="btnVideo">
                    <img src="img/video.png" alt="">&nbsp;&nbsp;Gravar um vídeo explicativo</button>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0">
                <textarea name="" id="msg" runat="server" class="form-control" cols="30" rows="10"></textarea><br>
                <button class="btn btn-brikk btn-lg pull-right" id="btnEnviar" runat="server" onserverclick="btnEnviar_ServerClick">Enviar</button>
            </div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 valorServico">
                <h2>
                    <strong>
                        <p>Valor do serviço:</p>
                        <br>
                        <asp:Label ID="valor" runat="server" Text=""></asp:Label>
                    </strong>
                </h2>
            </div>
            <br />
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12" id="divTerminar" runat="server">
                <input type="button" class="btn btn-brikk btn-lg pull-right" id="btnTerminar" onclick="terminar();" value="Informar Término">
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Últimas Perguntas</h3>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">

                <%
                    var chat = CarregaChat();

                    var cliente = @"<!--CLIENTE-->
                <div class='col col-lg-12 col-md-12 col-sm-12 col-xs-12'>&nbsp;</div>
                <div class='mensagem boxDesc pull-left'>
                    {{CLIENTEMSG}}
                </div>
                <!--FIM CLIENTE-->";

                    var fornecedor = @"<!--FORNECEDOR-->
                <div class='col col-lg-12 col-md-12 col-sm-12 col-xs-12'>&nbsp;</div>
                <div class='mensagem boxDesc pull-right'>
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
                            conteudo = cliente.Replace("{{CLIENTEMSG}}", item.Mensagem + "<BR>" + video + "&nbsp;&nbsp;&nbsp;" + arquivo);
                        else
                            conteudo = fornecedor.Replace("{{FORNECEDORMSG}}", item.Mensagem + "<BR>" + video + "&nbsp;&nbsp;&nbsp;" + arquivo);
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
                        window.location.href = "aguardando-aceite.aspx";
                    });
                }
            });
        }

   
    </script>

</asp:Content>
