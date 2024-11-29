<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="negociar-cotacao.aspx.cs" ValidateRequest="false" Inherits="Bsk.Site.Cliente.negociar_cotacao" MasterPageFile="~/Cliente/Master/Layout.Master" %>



<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao dados-cotacao cotacoes-cli">
         <div class="acessos">
             <a class="btn_card" href="buscar-servico.aspx"><img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Nova Solicitações</a>
             <a class="btn_card" href="minhas-cotacoes.aspx">Minhas Solicitações</a>
             <a class="btn_card" href="aguardando-pagamento.aspx">Pagamentos</a>
         </div>
     <div class="acessos-small">
         <div class="row">
             <div class="dropdown">
                 <a class="btn_card" href="buscar-servico.aspx" style="margin-top: 10px;">
                     <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Nova Solicitações
                 </a>
                 <button type="button" class="btn_card dropdown-toggle" onclick="toggleDropdown()" style="margin-top: 10px; justify-content: right; background: white; filter: brightness(100%); box-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3); border: none; cursor: pointer; appearance: none; -webkit-appearance: none; -moz-appearance: none;">
                     <i class="fas fa-ellipsis-v" style="font-size: 16px;"></i>
                 </button>
                 <div class="dropdown-menu" id="dropdownMenu" style="display: none;">
                     <a class="dropdown-item" href="minhas-cotacoes.aspx">Minhas Solicitações</a>
                     <a class="dropdown-item" href="aguardando-pagamento.aspx">Pagamentos</a>
                 </div>

                 <script>
                     function toggleDropdown() {
                         var menu = document.getElementById("dropdownMenu");
                         // Toggle between showing and hiding the dropdown
                         menu.style.display = (menu.style.display === "none" || menu.style.display === "") ? "block" : "none";
                     }

                     // Close the dropdown if the user clicks outside of it
                     window.onclick = function (event) {
                         if (!event.target.matches('.dropdown-toggle')) {
                             var dropdowns = document.getElementsByClassName("dropdown-menu");
                             for (var i = 0; i < dropdowns.length; i++) {
                                 var openDropdown = dropdowns[i];
                                 if (openDropdown.style.display === 'block') {
                                     openDropdown.style.display = 'none';
                                 }
                             }
                         }
                     }
                 </script>
             </div>
         </div>
     <div class="row">
 
     </div>
 </div>
        <div class="card card-cotacao-dados">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotações/ Cotação / <span id="nrCotacao" runat="server"></span> <asp:Label ID="lblnome" runat="server"></asp:Label> </h2>
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
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert" id="divTerminado" runat="server" style="width: 100%;margin-top:15px">
                <span class="tableTitle"><small>Mensagem do sistema:</small><br />
                    O fornecedor alegou ter terminado o serviço.</span><br />
                <br />
                <input type="button" class="btn btn-brikk btn-lg pull-left" onclick="terminar('0');" value="Não aceitar">&nbsp; &nbsp;
                 <input type="button" class="btn btn-lg pull-right" onclick="terminar('1');" value="Aceitar">
            </div>
            

            <div id="divAceitar" runat="server" class="container" style="display: flex; justify-content: center; align-items: center; height: 20vh;">
    <div style="margin-right: 50px;">
        <input type="button" class="btn btn-brikk btn-lg" id="btnAceitar" onclick="aceitar();" value="Aceitar" style="line-height:normal;">
    </div>
    <div style="margin-left: 50px;">
        <input type="button" class="btn btn-brikk btn-lg" id="btnRecusar" onclick="recusar();" value="Recusar" style="line-height:normal; background-color: #770e18; color:white;">
    </div>
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
                                         <h2 class='titulo-msg'>Cliente</h2>
                                           <div class='conteudo-msg'>
                                             <p>
                                               {{CLIENTEMSG}}
                                             </p>
                                           </div>
                                          </div>
                                         <!--FIM CLIENTE-->";

                                var fornecedor = @"<!--FORNECEDOR-->
                                            <div class='enviado'>
                                           <h2 class='titulo-msg'>Fornecedor</h2>
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


                                    if (item.IdParticipante != 0)
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
                                </div>
                                <div class="gravar-video" id="btnVideo">
                                    <img src="../assets/imagens/gravar.svg" style="width: 30px;" alt="anexar">
                                    <button class="btn-gravar">Gravar um vídeo explicativo</button>
                                </div>
                            </div>
                        </div>

                        <div class="bp-acoes">
                            <button class="btn" id="btnEnviar" runat="server" onserverclick="btnEnviar_ServerClick">Enviar</button>
                        </div>
                    </div>




                    <div>
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
                        <% /*var anexos = PegaAnexo();
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
                        <%}*/
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
                    </div>

                </div>

            </div>

               <div id="divAceitar2" runat="server" class="container" style="display: flex; justify-content: center; align-items: center; height: 20vh;">
                    <div style="margin-right: 50px;">
                        <input type="button" class="btn btn-brikk btn-lg" id="btnAceitar" onclick="aceitar();" value="Aceitar" style="line-height:normal;">
                    </div>
                    <div style="margin-left: 50px;">
                        <input type="button" class="btn btn-brikk btn-lg" id="btnRecusar" onclick="recusar();" value="Recusar" style="line-height:normal; background-color: #770e18; color:white;">
                    </div>
                </div>

            <div class="footer_card">
                <a class="voltar btn" href="cotacao-info.html"><< voltar </a>
                <!--
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                -->
            </div>

        </div>
    </div>

     <style>
         a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }

        .card-content-chat {
            display: grid;
            grid-template-columns: 1fr 1fr;
            grid-gap: 10%;
        }
        .chat {
            display: flex !important;
            flex-direction: column !important;
        }
        .bp {
            height: 450px;
            overflow-y: scroll;
            margin-top: 40px;
            padding: 0 25px 25px 0;
        }
        .enviado, .recebido {
            display: grid;
            grid-template-columns: 35px 1fr;
            grid-gap: 20px;
            align-items: center;
            background: #fff;
            padding: 7px 25px;
            margin-top: 15px;
            border-radius: 15px 0;
            box-shadow: 10px 6px rgb(0 0 0 / 11%);
            position: relative;
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
        .h2 {
            font-family: Rajdhani-semi !important;
            font-size: 14px !important;
            color: #770e18 !important;
            margin-bottom: 10px;
        }
        .titulo-msg {
            font-family: Rajdhani-semi !important;
            font-size: 14px !important;
            color: #770e18 !important;
            margin-bottom: 10px;
        }
        .conteudo-msg p, .recebido p {
            color: #706f6f;
            width: 90%;
        }
        .recebido {
            display: block;
            margin-top: 25px;
            overflow-x: hidden;
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
            font-size: 14px !important;
            font-family: Rajdhani-semi !important;
            color: #706f6f !important;
        }
        ::-webkit-scrollbar {
            width: 10px;
        }
        ::-webkit-scrollbar-thumb {
            background: #b8272c;
        }
        ::-webkit-scrollbar-track {
            background: #d8d8d8;
        }
        .enviado, .recebido {
            display: block !important;
            /*grid-template-columns: 35px 1fr;
            grid-gap: 20px;*/
            align-items: center;
            max-width:500px;
            width:100%;
            height:auto;
            background: #fff;
            padding: 7px 25px;
            border-radius: 15px 0;
            box-shadow: 10px 6px rgb(0 0 0 / 11%);
            position: relative;
            overflow-x: hidden !important;
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

/*sweet alert style*/

div:where(.swal2-container).swal2-center > .swal2-popup {
    border-radius: 40px !important;
    font-size: 14px !important;
}

div:where(.swal2-container) button:where(.swal2-styled).swal2-cancel {
    border-radius: 20px !important;
    background-color: #770e18 !important;
}

div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
    border-radius: 20px !important;
    background-color: #f08f00 !important;
}

div:where(.swal2-container) button:where(.swal2-styled).swal2-deny {
    border-radius: 20px !important;
    background-color: #f08f00 !important;
}

div:where(.swal2-icon).swal2-info {
    border-color: #770e18 !important;
    color: #770e18 !important;
}

.swal2-icon.swal2-error {
    border-color: #770e18 !important;
    color: #770e18 !important;
}

/*sweet alert style*/
    @media (max-width: 768px) {
        .conteudo-dash{
            padding: 0px 0px 0px 0px !important;
        }
        .conteudo-dash{
            min-height: 0px !important;
        }
        .card-cotacao-dados {
            width: 400px !important;
        }
        .cotacoes-cli .acessos {
            flex-wrap: unset;
        }
        .acessos-small {
            display: flex; /* Exibe para telas pequenas */
            padding: 5px 15px 15px 15px;
            flex-direction: column;
        }
        .btn_card {
            font-size: 14px;
            width: 44% !important;
            min-width: 0px !important;
        }
        .card {
            padding: 15px!important;
        }
        .card-cotacao-dados {
            width: 100% !important;
            max-width: 388px; /* Mantenha esse limite, se necessário */
        }
        .dataTables_length label select{
            left: 15px !important;
        }
        .total_a_receber p {
            font-size: 25px;
        }
        .grid {
            flex-direction: column;
            margin-left: 15px;
        }    
        .media-cotacoes {
            min-width: 80% !important;
         
        }
    }
    acessos-small{
        display: flex;
        flex-direction: column; /* Empilha verticalmente */
    }
    .dropdown-menu {
        position: absolute; /* Permite o posicionamento em relação ao botão */
        background-color: white;
        border: 1px solid #ccc;
        z-index: 1;
        min-width: 150px; /* Largura do dropdown */
        top: calc(100% + 5px); /* O menu aparece logo abaixo do botão */
        right: 25px; /* Alinha o menu com a borda esquerda do botão */
    }
    .dropdown-toggle::after {
        content: none; /* Remove a setinha */
    }

    .dropdown {
        position: relative; /* Necessário para a posição do dropdown */
        display: inline-flex;
        justify-content: space-around;
    }

    .dropdown-item {
        display: block;
        padding: 10px;
        text-decoration: none;
        color: black;
        margin-right: 0px;
    }

    .dropdown-item:hover {
        background-color: #f1f1f1; /* Muda a cor ao passar o mouse */
    }

    </style>

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
                toast: true,
                title: 'Aceitar?',
                text: "Você tem certeza que gostaria de aceitar essa cotação? Todas as outras cotações serão ignoradas e você será redirecionado para uma página de pagamento.",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Aceitar',
                cancelButtonText: 'Cancelar'
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
                                toast: true,
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
                toast: true,
                title: titulo,
                text: texto,
                icon: "info",
                showCancelButton: true,
                cconfirmButtonColor: '#f08f00',
                cancelButtonColor: "#770e18", 
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
     <script>
     function updateVisibility() {
         if (window.innerWidth < 768) {
             document.querySelector('.acessos').style.display = 'none';
             document.querySelector('.acessos-small').style.display = 'flex';
         } else {
             document.querySelector('.acessos').style.display = 'flex';
             document.querySelector('.acessos-small').style.display = 'none';
         }
     }

     // Chama a função ao carregar a página
     updateVisibility();

     // Adiciona evento para redimensionamento da janela
     window.addEventListener('resize', updateVisibility);
     function toggleDropdown() {
         var menu = document.getElementById("dropdownMenu");
         if (menu.style.display === "none") {
             menu.style.display = "block";
         } else {
             menu.style.display = "none";
         }
     }

     // Fecha o dropdown se o usuário clicar fora dele
     window.onclick = function (event) {
         if (!event.target.matches('.dropdown-toggle')) {
             var dropdowns = document.getElementsByClassName("dropdown-menu");
             for (var i = 0; i < dropdowns.length; i++) {
                 var openDropdown = dropdowns[i];
                 if (openDropdown.style.display === 'block') {
                     openDropdown.style.display = 'none';
                 }
             }
         }
     }
     </script>

</asp:Content>
