<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="em-andamento.aspx.cs" Inherits="Bsk.Site.Fornecedor.em_andamento" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <div class="conteudo-dash agendamento">
        <div id="acessos" class="acessos">
            <a href="minhas-cotacoes.aspx" class="btn_card">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Buscar nova cotação
            </a>
            <a href="em-andamento.aspx" class="btn_card">Cotações em negociação</a>
            <a href="minhas-areas.aspx" class="btn_card">Minhas áreas de atuação</a>            
        </div>
        <div id="acessos-small" class="acessos-small">
            <div class="row">
                <div class="dropdown">
                    <a href="minhas-cotacoes.aspx" class="btn_card" style="margin-top: 10px;">
                        <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Buscar nova cotação
                    </a>
                    <button type="button" class="btn_card dropdown-toggle" onclick="toggleDropdown2()" style="margin-top: 10px; justify-content: right; background: white; filter: brightness(100%); box-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3); border: none; cursor: pointer; appearance: none;">
                        ⋮
                    </button>
                    <div class="dropdown-menu" id="dropdownMenu2" style="display: none;">
                        <a href="em-andamento.aspx" class="dropdown-item">Cotações em negociação</a>
                        <a href="minhas-areas.aspx" class="dropdown-item">Minhas áreas de atuação</a>
                        <div class="dropdown-item">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Em Andamento</h2>
            </div>

            <div class="card-tabela" style="overflow-x: auto;">
                <table class="table table-condensed table-responsive table-striped table-hover" id="tabela">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <td>Nº Cotação</td>
                            <td>Descrição</td>
                            <td>Nome cliente</td>
                            <td>Status</td>
                            <td>Ação</td>
                        </tr>
                    </thead>

                    <tbody>
                        <%var cotacoes = PegaCotacoes();
                            foreach (var item in cotacoes)
                            { %>
                        <tr>
                            <td><%: item.CotacaoId %></td>
                            <td><%: item.Titulo %></td>
                            <td><%: item.Nome %></td>
                            <td><%: item.Status %></td>
                            <td>
                                <% if (item.Status == "Recusado") { %>
                                    <center>-</center>
                                <% } else if (item.Status == "Aberto" || item.Status == "Aguardando pagamento" || item.Status == "Em andamento" || item.Status == "Aguardando Aceite" || item.Status == "Finalizado") { %>
                                    <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%: item.CotacaoId %>">Visualizar</a>
                                    <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%: item.IdFornecedorDB %>">Negociar</a>
                                <% } %>
                                    <% if (item.Status == "Aguardando Avaliação") { %>
                                        <a class="btn btn-brikk" href="avaliar.aspx?Id=<%: item.IdFornecedorDB %>">Avaliação</a>
                                    
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <div class="dataTables_info" id="tabela_info" role="status"></div>
                <!-- Paginação -->
                <div class="dataTables_paginate paging_simple_numbers" id="tabela_paginate">
                    <a class="paginate_button previous disabled" aria-controls="tabela" data-dt-idx="0" tabindex="-1" id="tabela_previous">Anterior</a>
                    <span>
                  
                    </span>
                    <a class="paginate_button next" aria-controls="tabela" data-dt-idx="7" tabindex="0" id="tabela_next">Próximo</a>
                </div>
                <!-- Fim da Paginação -->
            </div>
            <!-- imitation-table: versão mobile da tabela -->
            <div class="imitation-table" id="imitation-tabela">
                <% foreach (var item in cotacoes) { %>
                    <div class="imitation-row">
                        <div><strong>Nº Cotação:</strong> <%: item.CotacaoId %></div>
                        <div><strong>Descrição:</strong> <%: item.Titulo %></div>
                        <div><strong>Nome cliente:</strong> <%: item.Nome %></div>
                        <div><strong>Status:</strong> <%: item.Status %></div>
                        <div>
                            <% if (item.Status == "Recusado") { %>
                                <center>-</center>
                            <% } else if (item.Status == "Aberto" || item.Status == "Aguardando pagamento" || item.Status == "Em andamento" || item.Status == "Aguardando Aceite" || item.Status == "Finalizado") { %>
                                <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%: item.CotacaoId %>">Visualizar</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%: item.IdFornecedorDB %>">Negociar</a>
                            <% } %>
                            <% if (item.Status == "Aguardando Avaliação") { %>
                                <a class="btn btn-brikk" href="avaliar.aspx?Id=<%: item.IdFornecedorDB %>">Avaliação</a>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>
            <div class="footer_card">
                <a class="voltar btn" href="dashboard.aspx"><< voltar </a>
            </div>
        </div>
    </div>


    <script>
        $(document).ready(function () {
            var rowsPerPage = 10; // Number of rows to display per page
            var rows = $('#tabela tbody tr');
            var rowsCount = rows.length;
            var pageCount = Math.ceil(rowsCount / rowsPerPage); // Calculate the total number of pages
            var currentPage = 1;

            // Function to display the rows for the current page
            function displayRows(page) {
                var start = (page - 1) * rowsPerPage;
                var end = start + rowsPerPage;
                rows.hide();
                rows.slice(start, end).show();
            }

            // Function to update pagination controls
            function updatePagination() {
                $('#tabela_paginate span').html('');
                for (var i = 1; i <= pageCount; i++) {
                    var pageLink = $('<a class="paginate_button" aria-controls="tabela" data-dt-idx="' + i + '" tabindex="0">' + i + '</a>');
                    if (i === currentPage) {
                        pageLink.addClass('current');
                    }
                    $('#tabela_paginate span').append(pageLink);
                }
            }

            // Click event for pagination buttons
            $('#tabela_paginate').on('click', '.paginate_button', function () {
                currentPage = parseInt($(this).data('dt-idx'));
                displayRows(currentPage);
                updatePagination();
                atualizarInfoTabela();
            });

            // Initial display of rows and pagination
            displayRows(currentPage);
            updatePagination();
            atualizarInfoTabela();

            // Function to update the table info
            function atualizarInfoTabela() {
                var startItem = (currentPage - 1) * rowsPerPage + 1;
                var endItem = Math.min(currentPage * rowsPerPage, rowsCount);
                $('#tabela_info').text('Mostrando de ' + startItem + ' até ' + endItem + ' de ' + rowsCount + ' registros');
            }
        });
    </script>


    <style>
        @media (max-width: 768px) {
            div#tabela_filter {
                /* position: relative; */
                display: flex;
                /* right: 0; */
                /* margin-top: 30px; */
                margin-bottom: 40px;
            }
            div#tabela_filter::before {
                content: '🔍︎';
                z-index: 400;
                position: absolute;
                display:flex;
                bottom: 10px;
                top: -30px;
                /* display: block; */
            }
            div#tabela_filter input[type="search"], .dataTables_length label {
                width: 100% !important;
            }
            div#tabela_filter input[type="search"] {
                height: 40px;
                margin: -40px 40px 30px -10px !important;
            }
        }
        div#tabela_paginate .paginate_button {
            display: inline-flex;
            margin-right: 5px;
            text-align: center;
        }
        a.andamento {
            background: #f4f3f2;
            color: #770e18 !important;
        }
         .dropdown-menu {
            position: absolute; /* Permite o posicionamento em relação ao botão */
            background-color: white;
            border: 1px solid #ccc;
            z-index: 1;
            min-width: 150px; /* Largura do dropdown */
            top: calc(100% + 5px); /* O menu aparece logo abaixo do botão */
            left: 50%; /* Alinha o menu com a borda esquerda do botão */
         }

        .dropdown {
            margin: 0px 25px;
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
        @media (max-width: 768px) {
            #tabela {
                display: none;
            }

            .imitation-table {
                display: block;
                margin-top: 20px;
            }

            .imitation-row {
                background: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
            
            .imitation-row {
                border: 1px solid #ccc;
                padding: 12px;
                margin-bottom: 10px;
                border-radius: 5px;
                background: #fff;
            }
            .imitation-row div {
                margin-bottom: 8px;
            }
        }
        table-row {
           font-family: Rajdhani-semi;
           border: 1px solid #ccc;
           margin-bottom: 10px;
           padding: 10px;
           background-color: #f9f9f9;
           cursor: pointer;
        }

        @media (min-width: 769px) {
            .imitation-table {
                display: none;
            }
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
     </script>
      <script>
          function toggleDropdown2() {
              var menu = document.getElementById("dropdownMenu2");
              menu.style.display = (menu.style.display === "none" || menu.style.display === "") ? "block" : "none";
          }

          // Fecha o dropdown se o usuário clicar fora
          window.onclick = function (event) {
              if (!event.target.closest('.dropdown-toggle')) {
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
        const rowsPerPage = 5;

        function sincronizarImitationTable(paginaAtual) {
            const linhas = document.querySelectorAll('.imitation-row');

            if (linhas.length === 1 && linhas[0].textContent.trim() === "Nenhum registro encontrado") {
                linhas[0].style.display = 'block';
                return;
            }

            linhas.forEach((row, index) => {
                row.style.display = (index >= (paginaAtual - 1) * rowsPerPage && index < paginaAtual * rowsPerPage) ? 'block' : 'none';
            });
        }

        $(document).ready(function () {
            let tabela = $('#tabela').DataTable({
                pageLength: rowsPerPage,
                lengthChange: false,
                language: {
                    url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/pt-BR.json'
                }
            });

            tabela.on('page.dt', function () {
                const paginaAtual = tabela.page.info().page + 1;
                sincronizarImitationTable(paginaAtual);
            });

            tabela.on('draw', function () {
                const paginaAtual = tabela.page.info().page + 1;
                sincronizarImitationTable(paginaAtual);
            });

            sincronizarImitationTable(1);
        });
    </script>

</asp:Content>
