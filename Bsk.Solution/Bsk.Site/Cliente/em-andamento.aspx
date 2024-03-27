<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="em-andamento.aspx.cs" Inherits="Bsk.Site.Cliente.em_andamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

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

                <div class="pesquisar">
                    <img src="../assets/imagens/lupa-cinza.svg" alt="lipa" style="width: 15px;">
                    <input type="text" placeholder="Pesquisar" class="pesquisar_input">
                </div>
            </div>

            <div class="card-tabela " style="overflow-x: auto;">
                <table class="table table-condensed table-responsive table-striped table-hover">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <th>Cotação</th>
                            <th>Título </th>
                            <th>Categoria</th>
                            <th class="centered">Ação</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%var cotacoes = PegaCotacaoAndamento();
                            foreach (var item in cotacoes)
                            { %>
                        <tr>
                            <td><%Response.Write(item.IdCotacao); %></td>
                            <td style="display: none;"><%Response.Write(item.DataCriacao); %></td>
                            <td><%Response.Write(item.Titulo); %></td>
                            <td><%Response.Write(item.Status); %></td>
                            <%  
                                if (item.Status == "Criação")
                                {%>
                            <td>
                                <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                            </td>
                            <%}
                                else if (item.Status == "Aberto")
                                {%>
                            <td>
                                <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                                <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%Response.Write(item.IdCotacao); %>">Cotações</a>
                            </td>
                            <% }
                                else if (item.Status == "Em andamento")
                                {%>
                            <td>
                                <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>" style="width: 30%">Serviço</a>
                                <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%Response.Write(item.IdCotacao); %>" style="width: 30%">Cotações</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>" style="width: 30%">Mensagens</a>
                            </td>
                            <%}
                                else if (item.Status == "Aguardando pagamento")
                                {%>
                            <td>
                                <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                                <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%Response.Write(item.IdCotacao); %>">Cotações</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Mensagens</a>
                            </td>
                            <%}
                                else if (item.Status == "Finalizado")
                                {%>
                            <td>
                                <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                                <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%Response.Write(item.IdCotacao); %>">Cotações</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Mensagens</a>
                                <a class="btn btn-brikk" href="avaliar.aspx?Id=<%Response.Write(item.IdCotacao); %>">Avaliação</a>
                            </td>
                            <% }%>
                        </tr>
                        <%  }
                        %>
                    </tbody>
                </table>
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
        a.andamento{
            background: #f4f3f2;
            color: #770e18 !important;
        }
    </style>

</asp:Content>
