<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-cotacoes.aspx.cs" Inherits="Bsk.Site.Cliente.minhas_cotacoes" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao cotacoes-cli">
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
                <img src="../assets/imagens/dados-icon.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotação</h2>
            </div>
            <div class="filtros_card">

                <div class="select-card">
                    <select onchange="filtraTabela(); filtraImitationTable();" id="slcStatus">
                        <option value="0">Selecione um status</option>
                        <% 
                            var itens = GetDashboardCliente();

                            foreach(var i in itens)
                            {
                                %>
                                    <option value="<% Response.Write(i.id); %>" <% if (Request.QueryString["status"] != null && Request.QueryString["status"] == i.id.ToString()) { Response.Write("selected"); }  %> ><% Response.Write(i.nome); %></option>
                                <%
                            }

                            %>


                    </select>
                </div>

                <%--<div class="pesquisar">
                    <img src="../assets/imagens/lupa-cinza.svg" class="dash-lupa" alt="lupa" style="width: 15px;">
                    <input type="text" placeholder="Pesquisar" class="pesquisar_input">
                </div>--%>
            </div>

           <%-- <div class="resultado">
                <span class="numero_card">10</span>

                <p class="texto-resultado">
                    Resultado por página
                </p>
            </div>--%>

            <div class="card-tabela " style="overflow-x: auto;">
                
                <table id="tabela" data-order='[[ 4, "asc" ]]' class="table table-condensed table-responsive table-striped table-hover tabela-mobile">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <th>Nº Cotação </th>
                            <th>Data de Criação</th>
                            <th>Título</th>
                            <th>Data Atualizada</th>
                            <th style="text-align: center;">Status</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%var cotacoes = PegaCotacoes();
                            string link = "";
                            foreach (var item in cotacoes)
                            {

                                if (item.Status == "Criação")
                                {
                                    link = "cadastro-solicitacao.aspx?Cotacao=" + item.IdCotacao;
                                }
                                else if (item.Status == "Aberto")
                                {
                                    link = "cotacao-lista.aspx?Id=" + item.IdCotacao;
                                }
                                else if (item.Status == "Em andamento")
                                {
                                    link = "negociar-cotacao.aspx?Id=" + item.IdCotacaoFornecedor;
                                }
                                else if (item.Status == "Aguardando pagamento")
                                {
                                    link = "pagamento.aspx?Id=" + item.IdCotacaoFornecedor;
                                }
                                else if (item.Status == "Finalizado")
                                {
                                    link = "avaliar.aspx?Id=" + item.IdCotacao;
                                }
                                else if (item.Status == "Aguardando aceite")
                                {
                                    link = "negociar-cotacao.aspx?Id=" + item.IdCotacaoFornecedor;
                                }
                                else if (item.Status == "Aguardando liberação do pagamento")
                                {
                                    link = "finalizar-pagamento.aspx?Id=" + item.IdCotacao;
                                }
                                else if (item.Status == "Aguardando Avaliação")
                                {
                                    link = "avaliar.aspx?Id=" + item.IdCotacao;
                                }
                        %>

                        <tr class="cursor" onclick="redirecionar('<%Response.Write(link);%>');">
                            <td><%Response.Write(item.IdCotacao); %></td>
                            <td><%Response.Write(item.DataCriacao); %></td>
                            <td><%Response.Write(item.Titulo); %></td>
                            <td><%Response.Write(item.DataAlteracao.ToString().Replace("01/01/0001 00:00:00", "")); %></td>

                           

                            <td class="status"><%Response.Write(item.nome); %>
                            </td>
                           
                        </tr>
                        <%  }
                            
                        %>
                    </tbody>
                </table>

                 <div class="imitation-table" id="imitationTable">
                    <% foreach (var item in cotacoes) { %>
                        <div class="table-row" onclick="redirecionar('<%Response.Write(link);%>');" data-status="<%Response.Write(item.nome); %>">
                            <div class="table-cell"><strong>Nº Cotação:</strong> <%Response.Write(item.IdCotacao); %></div>
                            <div class="table-cell"><strong>Data de Criação:</strong> <%Response.Write(item.DataCriacao); %></div>
                            <div class="table-cell"><strong>Título:</strong> <%Response.Write(item.Titulo); %></div>
                            <div class="table-cell"><strong>Data Atualizada:</strong> <%Response.Write(item.DataAlteracao.ToString().Replace("01/01/0001 00:00:00", "")); %></div>
                            <div class="table-cell"><strong>Status:</strong> <%Response.Write(item.nome); %></div>
                        </div>
                    <% } %>
                </div>

            </div>
            <div class="footer_card">
                <a href="cliente-dashboard.aspx" class="voltar btn"><< voltar </a>
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
        div#tabela_filter::before {
            left: 5px;
        }
        .dropdown-toggle::after {
             content: none; /* Remove a setinha */
        }
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }
        div#tabela_paginate > span {
            display: flex
        }
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
             }
             .table-row {
                font-family: Rajdhani-semi;
                border: 1px solid #ccc;
                margin-bottom: 10px;
                padding: 10px;
                background-color: #f9f9f9;
                cursor: pointer;
             }
             .div#tabela_paginate {
                margin-bottom: 5px !important;
             }
             .dataTables_paginate{
                 margin-bottom: 5px !important;
             }
         }
         .acessos-small{
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
        .acessos {
            justify-content: space-evenly !important;
            padding: 0% !important;
        }
        div#tabela_filter input[type="search"] {
            height: 55px;
            width: 100%;
        }

    </style>

    <script>

        function redirecionar(valor) {
            window.location.href = valor;
        }

        function filtraTabela() {

            var table = $('#tabela').DataTable();

            if ($("#slcStatus").val() == "0") {
                table.search("").draw();
            } else if ($("#slcStatus").val() == "1") {
                table.search("Aguardando Cotação").draw();
            } else if ($("#slcStatus").val() == "2") {
                table.search("Em Cotação").draw();
            } else if ($("#slcStatus").val() == "3") {
                table.search("Aguardando pagamento").draw();
            } else if ($("#slcStatus").val() == "4") {
                table.search("Em cotação").draw();
            } else if ($("#slcStatus").val() == "5") {
                table.search("Aguardando liberação do pagamento").draw();
            } else if ($("#slcStatus").val() == "6") {
                table.search("Aguardando aceite").draw();
            } else if ($("#slcStatus").val() == "7") {
                table.search("Finalizado").draw();
            } else if ($("#slcStatus").val() == "8") {
                table.search("Rascunho").draw();
            }
        }
        
        setTimeout(function () { filtraTabela() }, 10)




    </script>
    <script>
        function updateVisibility1() {
            if (window.innerWidth < 768) {
                document.querySelector('.tabela-mobile').style.display = 'none';

            } else {
                document.querySelector('.tabela-mobile').style.display = 'revert-layer';
            }
        }

        // Chama a função ao carregar a página
        updateVisibility1();

        // Adiciona evento para redimensionamento da janela
        window.addEventListener('resize', updateVisibility1);

        function updateVisibility2() {
            if (window.innerWidth < 768) {
                document.querySelector('.filtros_card').style.display = '';
            } else {
                document.querySelector('.imitation-table').style.display = 'none';
            }
        }

        // Chama a função ao carregar a página
        updateVisibility2();

        // Adiciona evento para redimensionamento da janela
        window.addEventListener('resize', updateVisibility2);

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
    </script>
    <script>
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
    <script>
        const statusMap = {
            0: " ",
            1: "Status: Aguardando Cotação",
            2: "Status: Em cotação",
            3: "Status: Aguardando pagamento",
            4: "Status: Finalizado", 
            8: "Status: Rascunho"
            // Adicione outros mapeamentos, conforme necessário
        }; 
        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById("slcStatus").addEventListener('change', filtraImitationTable);
        });

        function filtraImitationTable() {
            // Obtém o valor numérico selecionado
            var selectedValue = document.getElementById("slcStatus").value;
            // Mapeia para o texto correspondente
            var searchText = statusMap[selectedValue];

            console.log('Valor selecionado:', selectedValue, 'Texto de busca:', searchText);

            var items = document.querySelectorAll('.imitation-table .table-row');

            items.forEach(function (item) {
                var itemStatus = item.querySelector("div.table-cell:nth-child(5)").textContent.trim();
                console.log('Status do item:', itemStatus);

                if (selectedValue === "0") {
                    item.style.display = ''; // Mostra todos
                } else if (itemStatus === searchText) {
                    item.style.display = ''; // Mostra o item se corresponder
                } else {
                    item.style.display = 'none'; // Oculta o item se não corresponder
                }
            });
        }
    </script>
</asp:Content>
