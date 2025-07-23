<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="em-andamento.aspx.cs" Inherits="Bsk.Site.Cliente.em_andamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="conteudo-dash agendamento">
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


        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Em Andamento</h2>
            </div>
            
                <div class="select-card">
                    <select onchange="filtraTabela();" id="slcStatus">
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

           <div class="card-tabela">
            <table id="tabela" data-order='[[ 2, "asc" ]]' class="table table-condensed table-responsive table-striped table-hover">
                <thead id="cabecalho-tabela">
                    <tr>
                        <th>Cotação</th>
                        <th>Detalhamento </th>
                        <th>Status</th>
                        <th class="centered">Ação</th>

                    </tr>
                </thead>

                <tbody>
                    <% var cotacoes = PegaCotacaoAndamento();
                    foreach (var item in cotacoes)
                    { %>
                    <tr>
                        <td><% Response.Write(item.IdSolicitacao); %></td>
                        <td><% Response.Write(item.Titulo); %></td>
                        <td><% Response.Write(item.Status); %></td>
                        <%  
                            if (item.Status == "Criação")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<% Response.Write(item.IdSolicitacao); %>">Serviço</a>
                        </td>
                        <%}
                            else if (item.Status == "Aberto")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<% Response.Write(item.IdSolicitacao); %>">Serviço</a>
                            <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<% Response.Write(item.IdSolicitacao); %>">Cotações</a>
                        </td>
                        <% }
                            else if (item.Status == "Em andamento" || item.Status == "Aguardando aceite" )
                            {%>
                        <td style="text-align:right">
                            <!--<a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<% Response.Write(item.IdSolicitacao); %>" style="width: 30%">Serviço</a>
                            <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<% Response.Write(item.IdSolicitacao); %>" style="width: 30%">Cotações</a>-->
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<% Response.Write(item.IdCotacao); %>" style="margin-right:15px">Visualizar Cotação</a>
                        </td>
                        <%}
                        else if (item.Status == "Aguardando avaliação" )
                        {%>
                            <td style="text-align:right">
                                <a class="btn btn-brikk" href="avaliar.aspx?Id=<% Response.Write(item.IdSolicitacao); %>" style="margin-right:15px">Avaliar</a>
                            </td>
                        <%}
                            else if (item.Status == "Aguardando pagamento")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<% Response.Write(item.IdSolicitacao); %>">Serviço</a>
                            <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<% Response.Write(item.IdSolicitacao); %>">Cotações</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<% Response.Write(item.IdCotacao); %>">Mensagens</a>
                        </td>
                        <%}
                            else if (item.Status == "Finalizado")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<% Response.Write(item.IdSolicitacao); %>">Serviço</a>
                            <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<% Response.Write(item.IdSolicitacao); %>">Cotações</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<% Response.Write(item.IdCotacao); %>">Mensagens</a>
                            <a class="btn btn-brikk" href="avaliar.aspx?Id=<% Response.Write(item.IdSolicitacao); %>">Avaliação</a>
                        </td>
                        <% }%>
                    </tr>
                    <%  }
                    %>
                </tbody>

            </table>
    <div class="imitation-table" id="imitationTable" style="display:none;">
        <% var cotacoes2 = PegaCotacaoAndamento();
           foreach (var item in cotacoes2) {
               string link = ""; 
               if (item.Status == "Criação")
                    link = "cadastro-solicitacao.aspx?Cotacao=" + item.IdSolicitacao;
               else if (item.Status == "Aberto")
                    link = "cotacao-lista.aspx?Id=" + item.IdSolicitacao;
               else if (item.Status == "Em andamento" || item.Status == "Aguardando aceite")
                    link = "negociar-cotacao.aspx?Id=" + item.IdCotacao;
               else if (item.Status == "Aguardando avaliação")
                    link = "avaliar.aspx?Id=" + item.IdSolicitacao;
               else if (item.Status == "Aguardando pagamento")
                    link = "cotacao-lista.aspx?Id=" + item.IdSolicitacao;
               else if (item.Status == "Finalizado")
                    link = "avaliar.aspx?Id=" + item.IdSolicitacao;
        %>
        <div class="table-row cursor" onclick="redirecionar('<%= link %>')" data-status="<%= item.Status %>">
            <div class="table-cell"><strong>Cotação:</strong> <%= item.IdSolicitacao %></div>
            <div class="table-cell"><strong>Detalhamento:</strong> <%= item.Titulo %></div>
            <div class="table-cell"><strong>Status:</strong> <%= item.Status %></div>
            <div class="table-cell"><strong>Ação:</strong>
                <% if (item.Status == "Criação") { %>
                    <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<%= item.IdSolicitacao %>">Serviço</a>
                <% } else if (item.Status == "Aberto") { %>
                    <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<%= item.IdSolicitacao %>">Serviço</a>
                    <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%= item.IdSolicitacao %>">Cotações</a>
                <% } else if (item.Status == "Em andamento" || item.Status == "Aguardando aceite") { %>
                    <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%= item.IdCotacao %>">Visualizar Cotação</a>
                <% } else if (item.Status == "Aguardando avaliação") { %>
                    <a class="btn btn-brikk" href="avaliar.aspx?Id=<%= item.IdSolicitacao %>">Avaliar</a>
                <% } else if (item.Status == "Aguardando pagamento") { %>
                    <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<%= item.IdSolicitacao %>">Serviço</a>
                    <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%= item.IdSolicitacao %>">Cotações</a>
                    <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%= item.IdCotacao %>">Mensagens</a>
                <% } else if (item.Status == "Finalizado") { %>
                    <a class="btn btn-brikk" href="cadastro-solicitacao.aspx?Cotacao=<%= item.IdSolicitacao %>">Serviço</a>
                    <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%= item.IdSolicitacao %>">Cotações</a>
                    <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%= item.IdCotacao %>">Mensagens</a>
                    <a class="btn btn-brikk" href="avaliar.aspx?Id=<%= item.IdSolicitacao %>">Avaliação</a>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>     
            <div class="footer_card">
                <a class="voltar btn" href="cliente-dashboard.aspx"><< voltar </a>
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
        .dropdown-toggle::after {
            content: none; /* Remove a setinha */
        }
        a.andamento{
            background: #f4f3f2;
            color: #770e18 !important;
        }
        div#tabela_paginate > span {
            display: flex
        }
        div#tabela_paginate {
            margin-top: 0px !important;
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
                max-width: 388px; /* Mantenha esse limite, se necessário */
            }
            .dataTables_length label select{
                left: 15px !important;
            }
             .acessos-small{
                 display: flex;
                 flex-direction: column; /* Empilha verticalmente */
             }
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
        .imitation-table {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .table-row {
            font-family: Rajdhani-semi;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            cursor: pointer;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .table-cell {
            flex: 1 1 100%;
            display: flex;
            justify-content: space-between;
        }

        @media(min-width: 768px) {
            .imitation-table {
                display: none !important;
            }
        }

    </style>
    <script>

        function atualizarInfoTabela() {
            // Obtém o número total de registros na tabela
            var Registros = $('#tabela tbody tr:visible').length;
            var totalRegistros = $('#tabela tbody tr').length;

            // Atualiza o elemento de informação dos registros
            $('#info-registros').text(Registros);
            $('#info-total-registros').text(totalRegistros);
        }

        // Chamada da função ao carregar a página
        $(document).ready(function () {
            atualizarInfoTabela();
        });

        function filtraTabela() {

            var table = $('#tabela').DataTable();

            if ($("#slcStatus").val() == "0") {
                $('#search').val("");
            } else if ($("#slcStatus").val() == "1") {
                table.search("Solicitação Feita").draw();
            } else if ($("#slcStatus").val() == "2") {
                table.search("Em Cotação").draw();
            } else if ($("#slcStatus").val() == "3") {
                table.search("Aguardando pagamento").draw();
            } else if ($("#slcStatus").val() == "4") {
                $('#search').val("Em andamento");
            } else if ($("#slcStatus").val() == "5") {
                $('#search').val("Aguardando aceite");
            } else if ($("#slcStatus").val() == "6") {
                $('#search').val("Aguardando avaliação");
            } else if ($("#slcStatus").val() == "7") {
                table.search("Finalizado").draw();
            }
            $('#search').keyup()
            atualizarInfoTabela();
        }

        setTimeout(function () { filtraTabela() }, 10)

        $(document).ready(function () {
            $('#search').keyup(function () {
                search_table($(this).val());
            });
            function search_table(value) {
                $('#tabela tbody tr').each(function () {
                    var found = 'false';
                    $(this).each(function () {
                        if ($(this).text().toLowerCase().indexOf(value.toLowerCase()) >= 0) {
                            found = 'true';
                        }
                    });
                    if (found == 'true') {
                        $(this).show();
                    }
                    else {
                        $(this).hide();
                    }
                });
            }
        });

        function togglePaginationButtons() {
            var table = $('#tabela').DataTable(); // Obter a referência para a tabela

            var info = table.page.info(); // Obter informações sobre a paginação
            var pages = info.pages; // Total de páginas
            var currentPage = info.page + 1; // Página atual

            // Loop através de cada botão de paginação
            $('.paginate_button').each(function (index) {
                // Mostrar botões até o número total de páginas
                if (index < pages) {
                    $(this).show();
                } else {
                    $(this).hide();
                }

                // Adicionar classe 'current' à página atual
                if (index === currentPage) {
                    $(this).addClass('current');
                } else {
                    $(this).removeClass('current');
                }
            });
        }

        // Chamada da função ao carregar a página e quando a tabela é desenhada
        $(document).ready(function () {
            togglePaginationButtons(); // Chamar a função quando a página for carregada

            // Chamar a função sempre que a tabela for redesenhada
            $('#tabela').on('draw.dt', function () {
                togglePaginationButtons();
            });
        });

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
    <script>
        function updateVisibility() {
            if (window.innerWidth < 768) {
                document.querySelector('.acessos').style.display = 'none';
                document.querySelector('.acessos-small').style.display = 'flex';
                document.querySelector('#tabela').style.display = 'none';
                document.querySelector('.imitation-table').style.display = 'block';
            } else {
                document.querySelector('.acessos').style.display = 'flex';
                document.querySelector('.acessos-small').style.display = 'none';
                document.querySelector('#tabela').style.display = 'table';
                document.querySelector('.imitation-table').style.display = 'none';
            }
        }

        window.addEventListener('resize', updateVisibility);
        document.addEventListener('DOMContentLoaded', updateVisibility);

        // Função de redirecionamento igual na outra tela
        function redirecionar(url) {
            window.location.href = url;
        }
    </script>


</asp:Content>
