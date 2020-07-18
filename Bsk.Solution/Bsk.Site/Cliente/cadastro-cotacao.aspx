<%@ Page Language="C#" AutoEventWireup="true"  validateRequest="false" CodeBehind="cadastro-cotacao.aspx.cs" Inherits="Bsk.Site.Cliente.cadastro_cotacao" MasterPageFile="~/Cliente/Master/Layout.Master" %>



<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12" id="divUpload" runat="server">
                <button type="button" id="btnVideo" class="btn btn-upload">
                    <img src="img/video.png" alt="">&nbsp;&nbsp;Gravar um vídeo explicativo</button>

                <button type="button" id="btnAnexo" class="btn btn-upload">
                    <img src="img/upload.png" alt="">&nbsp;&nbsp;Anexar Arquivos</button>

                <asp:FileUpload ID="flpAnexo" CssClass="flpAnexo" runat="server" Style="display: none;" />
                <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" Style="display: none;" />

                <!-- <div class="btn record-audio" title='Enviar um áudio'> 🎤 </div>
                <div class="btn start-video" title='Câmera'>Câmera</div>
                <div class="btn stop-video" title='Stop'>Parar</div>
                <div class="btn take-picture" title='Tirar uma foto'> 📷 </div>
                <div class="btn record-video" title='Gravar vídeo'> ⏺ </div>

                <video src="" id="videoFeed" autoplay></video>
                <canvas id="picture-canvas"></canvas> -->

            </div>
            <button type="button" class="btn btn-brikk btn-lg pull-right" id="btnSubmeter" onclick="cadastrar();" runat="server">Submeter serviço</button>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Título</h3>
                <input type="text" class="form-control" id="titulo" runat="server">
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Descreva sua necessidade</h3>
                <textarea class="form-control" cols="30" rows="10" id="descricao" runat="server"></textarea>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Arquivos anexos</h3>
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
                                <a class="btn btn-brikk" href='<%Response.Write(ConfigurationManager.AppSettings["host"]);%>Anexos/Video/<%Response.Write(item.Anexo);%>' target='_blank'>
                                    <img alt='' src='img/upload.png'>&nbsp;Visualizar</a>
                                <% } %>
                            </td>
                        </tr>
                        <%}
                        %>
                        <!-- FIM LOOP DOCUMENTO-->
                    </tbody>
                </table>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <button class="btn btn-brikk btn-lg pull-right" id="btnSalvar" runat="server" onserverclick="btnSalvar_ServerClick">Salvar dados</button>&nbsp;
                    
                </div>
            </div>
        </div>

    </div>
    <script>

        function cadastrar() {
            if ($("#conteudo_titulo").val() != "" && $("#conteudo_descricao").val() != "") {

                Swal.fire({
                    title: 'Submeter?',
                    text: "Você tem certeza que gostaria de submeter esse serviço? Toda alteração, anexo ou video não salvos serão perdidos. Não será possível fazer mais nenhuma alteração.",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Aceitar!'
                }).then((result) => {
                    if (result.value) {
                        var parametro = {
                            id: comum.queryString("Cotacao"),
                            descricao: $("#conteudo_descricao").val(),
                            titulo: $("#conteudo_titulo").val()
                        };
                        comum.postAsync("Comum/SubmeterCotacao", parametro, function (data) {
                            window.location.href = "minhas-cotacoes.aspx";
                        });
                    }
                });
            } else {
                Swal.fire("Preencha todos os campos.");
            }
        }

        $(document).ready(function () {

            $("#btnAnexo").click(function () {
                $(".flpAnexo").click();
            });

            $("#btnVideo").click(function () {
                $(".flpVideo").click();
            });

        });
    </script>

</asp:Content>
