<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="negociar-cotacao.aspx.cs" ValidateRequest="false" Inherits="Bsk.Site.Cliente.negociar_cotacao" MasterPageFile="~/Cliente/Master/Layout.Master" %>



<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao dados-cotacao cotacoes-cli">
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
        <div class="card card-cotacao-dados">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotações/ Cotação <span id="nrCotacao" runat="server"></span> Marcenaria Gomes</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Título </h2>
                <p id="tituloCot" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <p id="descricaoCot" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1"></h2>
                <p id="parceiro" runat="server"></p>
            </div>

            <div class="cli-infos-values">
                <div class="cli-infos-value">
                    <div class="item_content_card ">
                        <div class="subtitulo-com-icone">
                            <img src="../assets/imagens/calendario.svg" alt="ícone" style="width: 20px;">
                            <h2 class="subtitulo_card_1 subtitulo_1">Data de Entrega</h2>
                        </div>
                        <div class="expo-info-values">
                            <span class="dt" id="dataEntrega" runat="server"></span>
                        </div>
                    </div>
                </div>

                <div class="cli-infos-value">
                    <div class="item_content_card ">
                        <div class="subtitulo-com-icone">
                            <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                            <h2 class="subtitulo_card_1 subtitulo_1">Valor do Serviço</h2>
                        </div>
                        <div class="expo-info-values">
                            <span id="vlr" runat="server"></span>
                        </div>
                    </div>
                </div>

                <div class="cli-infos-value">
                    <div class="item_content_card ">
                        <div class="subtitulo-com-icone">
                            <img src="../assets/imagens/media-laranja.svg" alt="ícone" style="width: 20px;">
                            <h2 class="subtitulo_card_1 subtitulo_1">Média das cotações</h2>
                        </div>
                        <div class="expo-info-values">
                            <span id="valorMedioCotacoes" runat="server"></span>
                        </div>
                    </div>
                </div>
            </div>
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
        
            <div class="item_content_card ">
                <h2 class="subtitulo_card_1 subtitulo_1">Chat </h2>
                <div class="card-content-chat">
                    <div class="chat">
                        <div class="bp" id="divChat">
                            <%
                                var chat = CarregaChat();

                                var cliente = @"<!--CLIENTE-->
                                 <div class='enviado'>
                                    <h3 class=titulo-msg'>Você</h3>
                                      <div class='conteudo-msg'>
                                        <p>
                                          {{CLIENTEMSG}}
                                        </p>
                                      </div>
                                     </div>
                
                <!--FIM CLIENTE-->";

                                var fornecedor = @"<!--FORNECEDOR-->
                                            <div class='enviado'>
                                           <h3 class=titulo-msg'>Fornecedor</h3>
                                              <div class='conteudo-msg'>
                                                <p>
                                                  {{FORNECEDORMSG}}
                                                </p>
                                              </div>
                                            </div>
             
                                             <!--FIM FORNECEDOR-->";

                                var conteudo = "";
                                foreach (var item in chat)
                                {
                                    var arquivo = "";
                                    if (!String.IsNullOrEmpty(item.Arquivo))
                                        arquivo = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Documento/" + item.Arquivo + "' target='_blank'><img alt='' src='../assets/imagens/anexar.svg' style='width: 30px;' alt='anexar'></a>";

                                    var video = "";
                                    if (!String.IsNullOrEmpty(item.Video))
                                        video = "<a href='" + ConfigurationManager.AppSettings["host"] + "Anexos/Video/" + item.Video + "' target='_blank'><img alt='' src='../assets/imagens/gravar.svg' style='width: 30px;' alt='anexar'></a>";


                                    if (item.IdCliente != 0)
                                        conteudo = cliente.Replace("{{CLIENTEMSG}}", item.Mensagem  + video + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span><br>");
                                    else
                                        conteudo = fornecedor.Replace("{{FORNECEDORMSG}}", item.Mensagem  + video  + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span><br>");
                            %>

                            <!--CLIENTE-->
                            <%Response.Write(conteudo);%>
                            <!--FIM CLIENTE-->

                            <%
                                }
                            %>
                        </div>
                        <div id="descricaoHide" runat="server">
                            <textarea class="enviar-msg" name="enviar" id="msg" runat="server" cols="30" rows="10"></textarea>
                        </div>


                        <div class="bp-acoes">
                            <button class="btn" id="btnEnviar" runat="server" onserverclick="btnEnviar_ServerClick">Enviar</button>
                        </div>
                    </div>
                    <div>
                        <asp:FileUpload ID="flpArquivo" CssClass="flpArquivo" runat="server" />
                        <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" />
                        <div class="item_content_card" id="divUpload" runat="server">
                            <div class="subtitulo-com-icone">
                                <img src="../assets/imagens/file.svg" alt="ícone" style="width: 20px;">
                                <h2 class="subtitulo_card_1 subtitulo_1">Enviar imagem ou vídeo sobre o serviço </h2>
                            </div>
                            <div class="files-upload cotacao-dados-upload">
                                <div class="file" id="btnArquivo">
                                    <img src="../assets/imagens/anexar.svg" style="width: 30px;" alt="anexar">
                                    <label for="selecao-arquivo">Anexar arquivos</label>
                                    <input id="selecao-arquivo" type="file">
                                </div>
                                <div class="gravar-video" id="btnVideo">
                                    <img src="../assets/imagens/gravar.svg" style="width: 30px;" alt="anexar">
                                    <button class="btn-gravar">Gravar um vídeo explicativo</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

            <a class="arquivos-anexos" href="#" style="margin-top: 20px !important;">
                <img src="../assets/imagens/anexo.svg" style="width: 15px;" alt="anexo">
                <span>Arquivos anexos</span>
            </a>

            <div class="filtros_card cota-info" style="margin-top: 10px;">
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
                <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <th>Tipo de documento </th>
                            <th>Ação</th>
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
                <a class="voltar btn" href="cotacao-info.html"><< voltar </a>
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
            </div>

        </div>
    </div>


    <script type="text/javascript">
        setInterval(function () {
            var parametro = {
                tipo: "C",
                id: comum.queryString("Id")
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
                        if (data == "Ok") {
                            window.location.href = "pagamento.aspx?Id=" + comum.queryString("Id");
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: data
                            }).then((result) => {
                                window.location.href = "minhas-cotacoes.aspx";
                            });
                        }

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
                            window.location.href = "minhas-cotacoes.aspx";
                        } else {
                            if (data.Liberado == "4") {
                                window.location.href = "minhas-cotacoes.aspx";
                            } else {
                                window.location.href = "minhas-cotacoes.aspx";
                            }
                        }

                    });
                }
            });
        }

    </script>

</asp:Content>
