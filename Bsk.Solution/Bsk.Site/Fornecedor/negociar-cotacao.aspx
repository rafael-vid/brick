<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="negociar-cotacao.aspx.cs" ValidateRequest="false" Inherits="Bsk.Site.Fornecedor.negociar_cotacao" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <input type="hidden" id="hdLink" clientidmode="static" runat="server" value="" />

    <div class="conteudo-dash cotacao">
        <div class="acessos">
            <a href="minhas-cotacoes.aspx" class="btn_card">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Buscar nova cotação
            </a>
            <a href="em-andamento.aspx" class="btn_card">Cotações em negociação
            </a>
            <a href="minhas-areas.aspx" class="btn_card">Minhas áreas de atuação
            </a>
        </div>

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotação / Cod. <span id="nrCotacao" runat="server"></span></h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Cliente </h2>
                <p id="ClienteServ" runat="server"></p>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <p>
                    <input type="text" placeholder="Digite aqui uma descrição para o serviço a ser realizado" class="card-input-add" id="titulofornecedor" runat="server">
                </p>
            </div>

            <div class="item_content_card descricao">
                <h2 class="subtitulo_card_1 subtitulo_1">Detalhamento </h2>
                <p>
                    <asp:Label ID="descricao" runat="server" Text=""></asp:Label>
                </p>
            </div>
            <div id="divValor" runat="server">
                <div id="divDataEntrega" runat="server" class="valorServico">
                    <h2>
                        <strong>
                            <p>Data entrega: <strong id="entrega" runat="server"></strong></p>
                        </strong>
                    </h2>
                </div>
                <div id="divValorServico" runat="server" class="valorServico">
                    <h2>
                        <strong>
                            <p>Valor do serviço: <strong id="valor" runat="server"></strong></p>
                        </strong>
                    </h2>
                </div>

            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert" id="divTerminar" runat="server" style="width: 100%;">
                <span class="tableTitle"><small>Mensagem do sistema:</small><br />
                    <strong>Legal!!</strong> Agora falta pouco para concluirem. Informe seu cliente que o serviço já foi finalizado.<br />
                    Uma dica, se possível envie uma foto para ele. Assim fica mais fácil para todos.</span><br />
                <br />
                <input type="button" class="btn btn-lg pull-right" id="btnTerminar" onclick="terminar();" value="Informar Término" style="width: 100%;">
            </div>

            <div style="clear:both"></div>
            <div class="item_content_card ">
                 <div class="card-content-chat">
                    <div class="chat">
                        <h2 class="subtitulo_card_1 subtitulo_1">Chat </h2>
                        <asp:ScriptManager ID="scr" runat="server"></asp:ScriptManager>
                            <ContentTemplate>

                            
                        <div class="bp" id="divChat">
                            <%
                                var chat = CarregaChat();

                                var cliente = @"<!--CLIENTE-->
                                                <div class='enviado'>
                                                    <h3 class='titulo-msg'>Cliente</h3>
                                                        <div class='conteudo-msg'>
                                                            <p>
                                                                {{CLIENTEMSG}}
                                                            </p>
                                                        </div>
                                                </div>
                                                <!--FIM CLIENTE-->";

                                var fornecedor = @"<!--FORNECEDOR-->
                                                   <div class='enviado'>
                                                       <h3 class='titulo-msg'>Fornecedor</h3>
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
                                        conteudo = cliente.Replace("{{CLIENTEMSG}}", item.Mensagem + video + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span><br>");
                                    else
                                        conteudo = fornecedor.Replace("{{FORNECEDORMSG}}", item.Mensagem + video + arquivo + "<span class='pull-right'>" + item.DataCriacao + "</span><br>");
                            %>

                            <!--CLIENTE-->
                            <%Response.Write(conteudo);%>
                            <!--FIM CLIENTE-->

                            <%
                                }
                            %>
                        </div>
                      
                        
                        
                        <%--  <div id="descricaoHide" runat="server">
                            <textarea class="enviar-msg" name="enviar" id="Textarea1" runat="server" cols="30" rows="10"></textarea>
                        </div>


                        <div class="bp-acoes">
                            <button class="btn" id="Button1" runat="server" onserverclick="btnEnviar_ServerClick">Enviar</button>
                        </div>--%>

                        <div id="comentarios" runat="server">
                            <textarea class="enviar-msg" name="enviar" id="msg" runat="server" cols="30" rows="10"></textarea>
                        </div>
                        <asp:FileUpload ID="flpArquivo" CssClass="flpArquivo" runat="server" />
                        <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" />
                       
                        <div class="bp-acoes">
                            <button class="btn bp-cotacao" id="btnDesistir" onclick="desistirCotacao();">Desistir da cotação</button>
                            <button class="btn" id="btnEnviar" runat="server" onserverclick="btnEnviar_ServerClick" style="width:max-content!important">Enviar Mensagem ao Cliente</button>
                        </div>

                                </ContentTemplate>
                    </div>
                   
                    <div>
                            <asp:FileUpload ID="flpAnexo" CssClass="flpAnexo" runat="server" Style="display: none;" onchange="$('#btnEnviarAnexoFornecedor').click()"  />
                            <asp:FileUpload ID="FileUpload1" CssClass="flpVideo" runat="server" Style="display: none;" onchange="$('#btnEnviarAnexoFornecedor').click()" />
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
<%--                                    <div class="gravar-video">
                                        <img src="../assets/imagens/gravar.svg" style="width: 30px;" alt="anexar">
                                        <a id="btnVideo" class="btn-gravar">Gravar um vídeo explicativo</a>
                                    </div>--%>
                                </div>
                            </div>
                        <button type="button" class="btn enviar-cotacao" id="btnEnviarAnexoFornecedor" ClientIDMode="Static" onserverclick="btnEnviarAnexoFornecedor_ServerClick" runat="server" style="display:none">
                            Enviar anexo
                       
                        </button>
                        <div class="item_content_card " id="divDadosCobranca" runat="server">
                            <div class="subtitulo-com-icone">
                                <img src="../assets/imagens/calendario.svg" alt="ícone" style="width: 20px;">
                                <h2 class="subtitulo_card_1 subtitulo_1">Informe uma data para terminar o serviço </h2>
                            </div>
                            <div class="select-card ">
                                <input type="date" class="form-control" clientidmode="static" id="dataEntrega" runat="server"/>
                            </div>
                        </div>

                        <div class="item_content_card ">
                            <div class="subtitulo-com-icone">
                                <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                                <h2 class="subtitulo_card_1 subtitulo_1">Informe o valor que você cobrará pelo serviço </h2>
                            </div>
                            <input type="text" class="input-cinza" id="valorServico" clientidmode="static" runat="server"/>
                        </div>
                   
                                    <hr />
                                <div class="gravar-video" id="finalizarCotacao">
                                    <button type="button" class="btn btn-brikk" id="enviarProposta" onclick="if (verificarValores()) salvaDados();"> Confirmar Proposta </button>
                                </div>
                        <img src="img/loading.gif" width="20" id="loadGif" style="display: none; width:55px;" />

                            <div id="labelConfirmacao" style="display: none; margin-top: 10px; color:#3c3c3b">
                            <text>Proposta confirmada!</text>
                            </div>
                    

                        <div class="filtros_card cota-info" style="margin-top: 40px;">
                    <div class="dataTables_length" id="tabela_length">
                        <label>
                            <select name="tabela_length" aria-controls="tabela" class="">
                                <option value="10">10</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select> resultados por página

                        </label>
                    </div>
            </div>

            <div class="card-tabela " style="overflow-x: auto;">
                <table  class="table table-condensed table-responsive table-striped table-hover">
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
                            <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>&Del=<%Response.Write(item.IdCotacaoAnexos); %>">Deletar</a>&nbsp;&nbsp;
                                <%if (item.Tipo == "Anexo")
                                    {%>
                            <a class="btn btn-brikk" href='<%Response.Write(ConfigurationManager.AppSettings["host"]);%>Anexos/Documento/<%Response.Write(item.Anexo);%>' target='_blank'>
                                <img alt='' src='img/upload.png' class="ver-imagem">&nbsp;Visualizar</a>
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
                        << anterior</button>
                    <span class="numero_card">10</span>
                    <button class="proximo">próximo >></button>
                </div>
            </div>





                    </div>
                       </div>


            </div>



            
            <div id="divAvaliar" runat="server" class="footer_card">
                <a class="voltar btn" href="em-andamento.aspx"><< voltar</a>
                <a class="btn btn-brikk" id="avaliarLink">Avaliar</a>
            </div>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function () {
        var avaliarLink = document.getElementById('avaliarLink');

        // Assuming you have a function that returns the URL
        var url = '<%= Avaliar() %>';

        avaliarLink.setAttribute('href', url);
    });
</script>


        </div>
    </div>

    <style>

        @media (max-width:767px) {
            .lado-direito{
                width:100%;
                color:red
            }
        }

        .ver-imagem{
            width:1.5rem;
            height:auto;
            filter: invert(100%) sepia(100%) saturate(0%) hue-rotate(288deg) brightness(102%) contrast(102%) !important;
        }

.card-tabela tr td a.btn {
    color: #fff !important;
}

.pesquisar, .resultado {
    position: relative;
    width: max-content;
}

        .card-content-chat {
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-gap: 10%;
        }

        @media (max-width: 950px) {
            .card-content-chat{
                grid-template-columns: 1fr 
            }
        }

        .chat {
            display: flex !important;
            flex-direction: column !important;
        }
        .bp {
            height: 350px;
            overflow-y: scroll;
            margin-top: 40px;
            padding: 0 25px 25px 0;
        }
        .enviado, .recebido {
            display: block !important;
            grid-template-columns: 35px 1fr;
            grid-gap: 20px;
            align-items: center;
            background: #fff;
            padding: 7px 25px;
            margin-top: 15px;
            border-radius: 15px 0;
            box-shadow: 10px 6px rgb(0 0 0 / 11%);
            position: relative;
            max-width:500px;
            width:100%;
            height:auto;
        }
        .simbol {
            position: absolute;
            font-weight: bold;
            color: #f08f00;
            right: 15px;
            top: 7px;
        }
        .avatar-msg {
            font-size: 25px;
            font-family: Rajdhani-Bold, sans-serif;
            color: #770e18;
        }
        .titulo-msg {
            font-family: Rajdhani-semi;
            font-size: 16px;
            color: #770e18;
            margin-bottom: 10px;
        }
        .conteudo-msg p, .recebido p {
            color: #706f6f;
            width: 90%;
        }
        .recebido {
            display: block;
            margin-top: 25px;
            border-radius: 15px 50px 50px 0;
        }
        .enviar-msg {
            width: 100%;
            height: 120px;
            border-radius: 10px;
            margin-top: 25px;
            outline: none;
            border: none;
            resize: none;
            padding: 7px 25px;
            font-size: 16px;
            font-family: Rajdhani-semi;
            color: #706f6f;
        }
        .enviado, .recebido {
            display: grid;
            grid-template-columns: 35px 1fr;
            grid-gap: 20px;
            align-items: center;
            background: #fff;
            padding: 7px 25px;
            border-radius: 15px 0;
            box-shadow: 10px 6px rgb(0 0 0 / 11%);
            position: relative;
        }
        .bp-acoes {
            display: flex;
            justify-content: flex-end;
        }
        button.btn.bp-cotacao {
            width: 150px !important;
        }
        .chat .btn {
            margin-right: 30px;
            align-self: flex-end;
            width: 100px !important;
            border: none;
            outline: none;
            font-size: 12px;
            cursor: pointer;
            margin-top: 25px;
            font-weight: normal;
        }
        select-card, .input-cinza, .pesquisar_input {
    border: 0;
    color: #3c3c3b;
    background: #d7d7d7;
    font-size: 16px;
    font-family: Rajdhani-semi, sans-serif;
    width: 50%;
    padding: 15px 25px;
    outline: none;
    -webkit-appearance: none;
    border-radius: 30px;
    box-sizing: border-box;
    position: relative;
    border: 1px solid transparent;
    transition: 0.3s ease;
    box-shadow: 4px 4px 6px rgb(0 0 0 / 30%);
}
        .select-card select {
    width: 100%;
    background: transparent;
    height: 100%;
    border: none;
    outline: none;
    color: #3c3c3b;
    font-family: Rajdhani-semi, sans-serif;
    font-size: 15px;
}
        .select-card::after {
    content: "";
    width: 1px;
    height: 100%;
    position: absolute;
    background-color: #9a9a99;
    display: inline-block;
    right: 60px;
    top: 0;
}
        input#dataEntrega {
    background: #d7d7d7;
    border: none;
    outline: none;
    box-shadow: none;
}
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }

        div:where(.swal2-container).swal2-center > .swal2-popup {
            border-radius: 40px !important;
        }
        div:where(.swal2-container) button:where(.swal2-styled).swal2-cancel {
            border-radius: 20px !important;
        }
        div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
            border-radius: 20px !important;
        }

    </style>


    <script type="text/javascript">

        function verificarValores() {
            var dataEntrega = document.getElementById("dataEntrega").value.trim();
            var valorServico = document.getElementById("valorServico").value.trim();

            // Verifica se os valores estão preenchidos
            if (dataEntrega === "" || valorServico === "R$0,00") {
                // Se não estiverem preenchidos, exibe uma mensagem de alerta
                Swal.fire({
                    toast: true,
                    title: "Por favor, preencha a data e o valor antes de prosseguir.",
                    confirmButtonColor: '#f08f00',
                    confirmButtonText: 'Ok'

                });
                return false; // Retorna false para interromper a execução
            }
            return true; // Retorna true se os valores estiverem preenchidos
        }

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
        
        document.addEventListener('DOMContentLoaded', function () {
            const valorServicoInput = document.getElementById('valorServico');
        
            valorServicoInput.addEventListener('input', function (e) {
                let value = e.target.value.replace(/\D/g, ''); // Remove all non-digits
                value = (value / 100).toFixed(2) + ''; // Convert to string with 2 decimal places
                value = value.replace('.', ',');
                value = value.replace(/\B(?=(\d{3})+(?!\d))/g, '.');
                e.target.value = value;
            });
        });
        

        //$(function () {
        //    $('#valorServico').maskMoney({
        //        allowNegative: false, 
        //        thousands: '.',       
        //        decimal: ',',         
        //        affixesStay: true     
        //   }).trigger('mask.maskMoney');
        //
        //});

        setInterval(function () {
            var parametro = {
                tipo: "F",
                id: comum.queryString("Id")
            };
            comum.getAsync("Comum/CarregaChat", parametro, function (data) {
                $("#divChat").empty();
                $("#divChat").append(data);
            });
        }, 10000);

        $(document).ready(function () {

            $("#btnAnexo").click(function () {
                $(".flpAnexo").click();
            });

            $("#btnVideo").click(function () {
                $(".flpVideo").click();
            });

        });

        function terminar() {
            Swal.fire({
                toast: true,
                title: 'Terminar?',
                text: "Você tem certeza que gostaria de informar que completou o serviço? Essa ação é irreversível.",
                icon: "info",
                showCancelButton: true,
                confirmButtonColor: '#f08f00',
                cancelButtonColor: "#770e18",
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


        function salvaDados() {
            $("#loadGif").show();
            $("#labelConfirmacao").hide();
            var parametro = {
                valor: $("#valorServico").val(),
                data: $("#dataEntrega").val(),
                id: comum.queryString("Id")
            };

            comum.postAsync("Comum/SalvarDadosCobrancaCotacao", parametro, function (data) {
                $("#loadGif").hide();
                $("#labelConfirmacao").show();
            });


        }

        function AtualizaEnviarProposta(e) {

            var parametro = {
                id: comum.queryString("Id")
            };

            comum.post("Comum/AtualizaEnviarProposta?idCotacao=" + comum.queryString("Id"), null, function (data) {
                $("#loadGif").hide();

            });

        }

        function desistirCotacao() {
            Swal.fire({
                toast: true,
                title: 'Você tem certeza que gostaria de desistir dessa cotação?',
                text: "Ela não vai mais ficar visível para você e não será possível retomá-la. Essa ação é irreversível.",
                icon: "info",
                showCancelButton: true,
                confirmButtonColor: '#f08f00',
                cancelButtonColor: "#770e18",
                iconColor: "#770e18",
                confirmButtonText: 'Sim, quero desistir',
                cancelButtonText: 'Cancelar',
            }).then((result) => {
                if (result.value) {
                    var parametro = {
                        id: comum.queryString("Id")
                    };
                    comum.post("Comum/DesistirCotacao", parametro, function (data) {
                        Swal.fire({
                            toast: true,
                            icon: 'success',
                            iconColor: "#770e18",
                            title: 'Sucesso',
                            confirmButtonColor:"#770e18",
                            text: 'Essa cotação não vai mais aparecer para você.'
                        }).then((result) => {
                            window.location.href = "minhas-cotacoes.aspx";
                        });
                    });
                }
            });
        }
        document.addEventListener('DOMContentLoaded', function () {
            var valorServicoInput = document.getElementById('valorServico');

            valorServicoInput.addEventListener('input', function (e) {
                var cursorPosition = valorServicoInput.selectionStart - (valorServicoInput.value.match(/R\$\s?/g) || []).length;
                var cleanNumber = this.value.replace(/\D/g, '');
                var formattedNumber = new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(cleanNumber / 100);

                valorServicoInput.value = formattedNumber;
            });
        });

    </script>
</asp:Content>
