<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cotacao.aspx.cs" Inherits="Bsk.Site.Fornecedor.cotacao" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
     <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h1>Cotação: <span id="nrCotacao" runat="server"></span></h1>
        <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Título</h3>
                <input type="text" class="form-control" id="titulo" runat="server" readonly>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Descreva sua necessidade</h3>
                <textarea class="form-control" cols="30" rows="10" id="descricao" runat="server" readonly></textarea>
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
                                <%if (item.Tipo == "Anexo"||item.Tipo == "Documento")
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
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                        <button class="btn btn-brikk pull-right" id="btnAdicionar" onserverclick="btnAdicionar_ServerClick" runat="server">Tenho interesse</button>
                    </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            
            </div>
        </div>

    </div>
    <script>

        function cadastrar() {
            if ($("#conteudo_titulo").val() != "" && $("#conteudo_descricao").val() != "") {

                Swal.fire({
                    title: 'Submeter?',
                    text: "Você tem certeza que gostaria de submeter esse serviço? Não será possível fazer mais nenhuma alteração.",
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
