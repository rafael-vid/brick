<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="em-andamento.aspx.cs" Inherits="Bsk.Site.Fornecedor.em_andamento" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="conteudo-dash agendamento">
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
                <h2 class="subtitulo_1">Em Andamento</h2>
            </div>

            <div class="card-tabela" style="overflow-x: auto;">
                <table class="table table-condensed table-responsive table-striped table-hover" id="tabela">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <td>Nº Cotação</td>
                            <td>Detalhamento</td>
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
                                <% } else if (item.Status == "Aberto" || item.Status == "Aguardando pagamento" || item.Status == "Em andamento" || item.Status == "Pendente de finalização do cliente" || item.Status == "Finalizado") { %>
                                    <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%: item.CotacaoId %>">Visualizar</a>
                                    <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%: item.RespostaCotacaoId %>">Negociar</a>
                                <% } %>
                                    <% if (item.Status == "Aguardando Avaliação") { %>
                                        <a class="btn btn-brikk" href="avaliar.aspx?Id=<%: item.RespostaCotacaoId %>">Avaliação</a>
                                    
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

            <div class="footer_card">
                <a class="voltar btn" href="dashboard.aspx"><< voltar </a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            .conteudo-dash {
                padding: 15px 0px;
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
    </style>
</asp:Content>
