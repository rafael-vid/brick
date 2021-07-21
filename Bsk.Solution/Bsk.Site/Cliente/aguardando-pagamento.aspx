<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aguardando-pagamento.aspx.cs" Inherits="Bsk.Site.Cliente.aguardando_pagamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash agendamento">
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
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Em Andamento</h2>
            </div>
            <div class="filtros_card">
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
                            <td>Nº Cotação</td>
                            <td style="display: none;">Data criação</td>
                            <td>Título</td>
                            <td>Status</td>
                        </tr>
                    </thead>

                    <tbody>
                        <%var cotacoes = PegaCotacaoPagamento();
                            foreach (var item in cotacoes)
                            {
                                string link = "";


                                if (item.Status == "Criação")
                                {
                                    link = "cadastro-cotacao.aspx?Cotacao=" + item.IdCotacao;
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
                                else if (item.Status == "Pendente de aceite do cliente")
                                {
                                    link = "negociar-cotacao.aspx?Id=" + item.IdCotacaoFornecedor;
                                }
                                else if (item.Status == "Aguardando liberação do pagamento")
                                {
                                    link = "finalizar-pagamento.aspx?Id=" + item.IdCotacao;
                                }
                        %>
                        <tr onclick="redirecionar('<%Response.Write(link);%>');">
                            <td><%Response.Write(item.IdCotacao); %></td>
                            <td style="display: none;"><%Response.Write(item.DataCriacao); %></td>
                            <td><%Response.Write(item.Titulo); %></td>
                            <td><%Response.Write(item.Status); %></td>

                        </tr>
                        <%  }
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
                        << anterior
                    </button>
                    <span class="numero_card">10</span>
                    <button class="proximo">próximo >></button>
                </div>
            </div>

            <div class="footer_card">
                <a class="voltar btn" href="cliente-dashboard.aspx"><< voltar
                </a>
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
            </div>

        </div>
    </div>
    <script>

        function redirecionar(valor) {
            window.location.href = valor;
        }
    </script>

</asp:Content>
