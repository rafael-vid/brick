<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="avaliar.aspx.cs" Inherits="Bsk.Site.Cliente.avaliar" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <style>
        #form1 {
            z-index: 1;
        }
        .card {
            margin: 0px 30px 30px 30px;
        }
        .conteudo-dash {
            min-height: 0vh !important;
        }
        div.chart {
            position: relative;
            width: 150px;
            height: 150px;
        }

        canvas {
            position: absolute;
            top: 0;
            left: 0;
            border-radius: 50%;
        }

        span.marcacao {
            color: #770e18;
            display: block;
            line-height: 150px;
            text-align: center;
            width: 150px;
            font-family: sans-serif;
            font-size: 40px;
            font-weight: 100;
            margin-left: 5px;
        }

        .estrelas {
            margin-top: 10px;
        }

        .estrelas input[type=radio] {
            display: none;
        }

        .estrelas label i.fa {
            font-size: 2.5em;
            cursor: pointer;
        }

        .estrelas label i.fa:before {
            content: '\f005';
            color: #FC0;
        }

        .estrelas input[type=radio]:checked ~ label i.fa:before {
            color: #CCC;
        }
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }
        .acessos{
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .area_comentario {
                grid-gap: 15px !important;
            }
            .card {
                z-index: -2 !important;
                margin: 0px 0px 0px 0px !important;
            }
            .conteudo-dash{
                padding: 0px 0px 0px 0px !important;
            }
            .btn_nova_solicitacao{
                margin-top: 5px;
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
                padding: 2px 15px 15px 15px;
                flex-direction: column;
            }
            .btn_card {
                font-size: 14px;
                width: 44% !important;
                margin-bottom: 15px;
                min-width: 170px;
            }
            btn_alterar_dados{
                margin-left:80px !important;
            }
            .card {
                z-index: 1;
                padding: 15px !important;
            }
            .card-cotacao-dados {
                width: 100% !important;
                max-width: 388px; /* Mantenha esse limite, se necessário */
            }
            .card-cl2 {
                display: flex;
                flex-direction: column;
            }
            .grupo-pg-boleto{
                 display: flex;
                flex-direction: column;
            }

            .dataTables_length label select{
                left: 15px !important;
            }
            .total_a_receber p {
                font-size: 25px;
            }
            .grid {
                flex-direction: column;
                margin-left: 15px !important;
            }    
            .media-cotacoes {
                min-width: 80% !important;
         
            }
            .divAceitar2{
                bottom: 0px; 
                right: 0px; 
                position: absolute; 
                z-index: 1000; 
                border: 0px;
            }
        }
   

/* Estilos para dispositivos móveis */
        @media (max-width: 768px) {

            acessos-small {
                display: flex;
                flex-direction: column; /* Empilha verticalmente */
            }

            .dropdown-menu {
                position: absolute; /* Permite o posicionamento em relação ao botão */
                background-color: white;
                border: 1px solid #ccc;
                z-index: 10;
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
        }
    </style>
        <div class="conteudo-dash avaliacao">
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
        </div>
        <%var cot = PegaCotacao(); %>
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/estrela.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Avaliação</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Prestador de Serviço </h2>
                <p><%Response.Write(cot.NomeFornecedor); %></p>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <p><%Response.Write(cot.Titulo); %></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Detalhamento do serviço </h2>
                <p><%Response.Write(cot.Descricao); %></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Avalie o Prestador de Serviço </h2>
                <div class="avaliacao-estrelas">
                      <%if (cot.Nota == 0)
                        {%>
                    <div class="estrelas">
                        <input type="radio" id="cm_star-empty" name="fb" onchange="atribuirNota('0');" value="" checked />
                        <label for="cm_star-1"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-1" name="fb" onchange="atribuirNota('1');" value="1" />
                        <label for="cm_star-2"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-2" name="fb" onchange="atribuirNota('2');" value="2" />
                        <label for="cm_star-3"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-3" name="fb" onchange="atribuirNota('3');" value="3" />
                        <label for="cm_star-4"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-4" name="fb" onchange="atribuirNota('4');" value="4" />
                        <label for="cm_star-5"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-5" name="fb" onchange="atribuirNota('5');" value="5" />
                    </div>
                    <%}
                        else
                        {
                            string check1 = "";
                            string check2 = "";
                            string check3 = "";
                            string check4 = "";
                            string check5 = "";

                            if (cot.Nota==1)
                            {
                                check1 = "checked";
                            }
                            else if (cot.Nota==2)
                            {
                                check2 = "checked";
                            }else if (cot.Nota==3)
                            {
                                check3 = "checked";
                            }else if (cot.Nota==4)
                            {
                                check4 = "checked";
                            }else if (cot.Nota==5)
                            {
                                check5 = "checked";
                            }
                            %>
                    
                   <div class="estrelas">
                        <input type="radio" id="cm_star-empty" name="fb" disabled value="" />
                        <label for="cm_star-1"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-1" name="fb" value="1" disabled <%Response.Write(check1); %>/>
                        <label for="cm_star-2"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-2" name="fb" value="2" disabled <%Response.Write(check2); %>/>
                        <label for="cm_star-3"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-3" name="fb" value="3" disabled <%Response.Write(check3); %>/>
                        <label for="cm_star-4"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-4" name="fb"  value="4" disabled <%Response.Write(check4); %>/>
                        <label for="cm_star-5"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-5" name="fb" value="5" disabled <%Response.Write(check5); %>/>
                    </div>
                    <%} %>
                    
                </div>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Depoimento </h2>
                <div class="area_comentario">
                    <div class="comentarios_area">
                        <textarea name="comentario" id="depoimentoCliente" runat="server" placeholder="Digite aqui seu depoimento" cols="30"
                            rows="10"></textarea>
                    </div>
                    <div class="percent">
                        <div class="porcentagem">
                            <%--<div class="chart" id="graph" data-percent="100"></div>--%>
                            <div>
                                    <div class="item_content_card">
                                        <h2 class="subtitulo_card_1 subtitulo_1">Data da Avaliação</h2>
                                        <p id="DataAvaliacao"><%= DateTime.Now.ToString("dd/MM/yyyy") %></p>
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div class="footer_card">
                <a class="voltar btn" href="em-andamento.aspx"><< voltar </a>
                <button class="btn" runat="server" id="btnDepoimento" onserverclick="btnDepoimento_ServerClick">Enviar</button>
                <!--
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                -->
            </div>

        </div>
    </div>

   
    <script>

        function atribuirNota(valor) {
            var parametros = {
                nota: valor,
                id: comum.queryString("Id")
            };

            comum.postAsync("Comum/NotaCotacao", parametros, function (data) {
            });
        } 
        
        $('.liberarPagamento').click(function () {
            swal({
                toast: true,
                title: "Tem certeza que podemos liberar o pagamento?",
                text: "Após o aceite a quantia acordada será liberada para o prestador de serviço!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
                .then((willDelete) => {
                    if (willDelete) {
                        swal("Pagamento liberado com sucesso!", {
                            icon: "success",
                            toast: true
                        });
                    } else {
                        swal("Ok, vamos aguardar mais um pouco para liberar o pagamento", {
                            icon: "info",
                            toast: true
                        });
                    }
                });
        });
        var el = document.getElementById('graph'); // get canvas

        var options = {
            percent: el.getAttribute('data-percent') || 25,
            size: el.getAttribute('data-size') || 150,
            lineWidth: el.getAttribute('data-line') || 15,
            rotate: el.getAttribute('data-rotate') || 0
        }

        var canvas = document.createElement('canvas');
        var span = document.createElement('span');
        span.classList.add('marcacao')
        span.textContent = options.percent + '% ';

        if (typeof (G_vmlCanvasManager) !== 'undefined') {
            G_vmlCanvasManager.initElement(canvas);
        }

        var ctx = canvas.getContext('2d');
        canvas.width = canvas.height = options.size;

        el.appendChild(span);
        el.appendChild(canvas);

        ctx.translate(options.size / 2, options.size / 2); // change center
        ctx.rotate((-1 / 2 + options.rotate / 180) * Math.PI); // rotate -90 deg

        //imd = ctx.getImageData(0, 0, 240, 24a0);
        var radius = (options.size - options.lineWidth) / 2;

        var drawCircle = function (color, lineWidth, percent) {
            percent = Math.min(Math.max(0, percent || 1), 1);
            ctx.beginPath();
            ctx.arc(0, 0, radius, 0, Math.PI * 2 * percent, false);
            ctx.strokeStyle = color;
            ctx.lineCap = 'round'; // butt, round or square
            ctx.lineWidth = lineWidth
            ctx.stroke();
        };

        drawCircle('#efefef', options.lineWidth, 100 / 100);
        drawCircle('#770e18', options.lineWidth, options.percent / 100);
    </script>
    <script async src="../assets/js/script.js"></script>
    <style>

        .select-card{
            width: 100% !important;
        }

    </style>
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


