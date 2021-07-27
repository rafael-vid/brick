<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="cadastro-cotacao.aspx.cs" Inherits="Bsk.Site.Cliente.cadastro_cotacao" MasterPageFile="~/Cliente/Master/Layout.Master" %>
<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash  cli-cotacao">
        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Nova Cotação
            </a>
            <a href="minhas-cotacoes.aspx" class="btn_card">Minhas Cotações
            </a>
            <a href="aguardando-pagamento.aspx" class="btn_card">Pagamentos
            </a>
        </div>
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotações/Nova Cotação</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Título </h2>
                <input type="text" placeholder="Digite aqui um título para o serviço que você procura" class="card-input-add" id="titulo" runat="server">
            </div>

            <input type="hidden" id="hdLink" clientidmode="static" runat="server" value="" />

            <div class="item_content_card card-line">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <div class="area_comentario">
                    <div class="comentarios_area">
                        <textarea name="comentario" placeholder="Digite aqui seu depoimento" cols="30"
                            rows="10" id="descricao" runat="server"></textarea>
                        <button type="button" class="btn enviar-cotacao" id="btnSalvar" onserverclick="btnSalvar_ServerClick" runat="server">
                    Salvar dados da cotação
                </button>
                    </div>
                    <div>
                        <asp:FileUpload ID="flpAnexo" CssClass="flpAnexo" runat="server" Style="display: none;" />
                        <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" Style="display: none;" />
                        <div class="item_content_card card-content-desc" style="margin-top: 0 !important;" id="divUpload" runat="server">
                            <div class="subtitulo-com-icone">
                                <img src="../assets/imagens/file.svg" alt="ícone" style="width: 20px;">
                                <h2 class="subtitulo_card_1 subtitulo_1">Enviar imagem ou vídeo sobre o serviço </h2>
                            </div>
                            <div class="files-upload">
                                <div class="file">
                                    <img src="../assets/imagens/anexar.svg" style="width: 30px;" alt="anexar">
                                    <a id="btnAnexo" class="btn-gravar">Anexar arquivos</a>
                                </div>
                                <div class="gravar-video">
                                    <img src="../assets/imagens/gravar.svg" style="width: 30px;" alt="anexar">
                                    <a id="btnVideo" class="btn-gravar">Gravar um vídeo explicativo</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <a class="btn enviar-cotacao" id="btnSubmeter" runat="server" onclick="cadastrar();">Enviar Cotação</a>
            </div>

            <a class="arquivos-anexos" href="#" style="margin-top: 20px !important;">
                <img src="../assets/imagens/anexo.svg" style="width: 15px;" alt="anexo">
                <span>Arquivos anexos</span>
            </a>

            <div class="filtros_card cota-info" style="margin-top: 40px;">
                <div class="resultado">
                    <span class="numero_card">04</span>

                    <p class="texto-resultado">
                        Resultado por página
                    </p>
                </div>

                <div class="pesquisar">
                    <img src="../assets/imagens/lupa-cinza.svg" alt="lipa" style="width: 15px;">
                    <input type="text" placeholder="Pesquisar" class="pesquisar_input">
                </div>
            </div>

            <div class="card-tabela " style="overflow-x: auto;">
                <table>
                    <thead id="cabecalho-tabela">
                        <tr>
                            <th>Tipo de documento </th>
                            <th>Ação</th>
                        </tr>
                    </thead>

                    <tbody>
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
                                    Visualizar</a>
                                <% }
                                    else
                                    {%>
                                <a class="btn btn-brikk" href='<%Response.Write(ConfigurationManager.AppSettings["host"]);%>Anexos/Video/<%Response.Write(item.Anexo);%>' target='_blank'>Visualizar</a>
                                <% } %>
                            </td>
                        </tr>
                        <%}
                        %>
                    </tbody>
                </table>
            </div>

            <div class="paginas_card">
                <p>
                    Mostrando de <span>01</span> até <span>04</span> de <span>04</span> registros
                </p>

                <div class="paginas">
                    <button class="anterior">
                        &lt;&lt; anterior</button>
                    <span class="numero_card">10</span>
                    <button class="proximo">próximo &gt;&gt;</button>
                </div>
            </div>

            <div class="footer_card">
                <a class="voltar btn" href="minhas-cotacoes.aspx"><< voltar </a>
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
            </div>

        </div>
    </div>

    <style>
        .btn.enviar-cotacao{
            border-radius: 30px;
            margin-bottom:30px;
            justify-content: flex-end
        }
        .btn.enviar-cotacao:hover{
            color:#fff;
        }
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }
    </style>

    <script>

        function cadastrar() {
            if ($("#conteudo_titulo").val() != "" && $("#conteudo_descricao").val() != "") {

                Swal.fire({
                    title: 'Enviar?',
                    text: "Você tem certeza que gostaria de enviar solicitação de cotação para este serviço? Toda alteração, anexo ou video não salvos serão perdidos. Não será possível fazer mais nenhuma alteração.",
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

            if (comum.queryString("Cotacao") != undefined && comum.queryString("Cotacao") != "") {
                $('.alert').slideToggle('slow');
            }
        });
    </script>

</asp:Content>
