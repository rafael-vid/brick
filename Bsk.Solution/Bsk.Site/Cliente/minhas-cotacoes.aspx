<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-cotacoes.aspx.cs" Inherits="Bsk.Site.Cliente.minhas_cotacoes" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2 class="tableTitle">Minhas cotações</h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <a class="btn btn-lg btn-brikk pull-right" href="buscar-servico.aspx">Nova Cotação</a>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Nº Cotação</td>
                        <td style="display:none;">Data criação</td>
                        <td>Título</td>
                        <td>Status</td>
                        <td>Ação</td>
                    </tr>
                </thead>
                <tbody>
                    <%var cotacoes = PegaCotacoes();
                        foreach (var item in cotacoes)
                        { %>
                    <tr>
                        <td><%Response.Write(item.IdCotacao); %></td>
                        <td style="display:none;"><%Response.Write(item.DataCriacao); %></td>
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
                            <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Mensagens</a>
                        </td>
                        <%}
                            else if (item.Status == "Aguardando pagamento")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Mensagens</a>
                            <a class="btn btn-brikk" href="pagamento.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Pagamento</a>
                        </td>
                        <%}
                            else if (item.Status == "Finalizado")
                            {%>
                         <td>
                             <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                             <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Mensagens</a>
                             <a class="btn btn-brikk" href="avaliar.aspx?Id=<%Response.Write(item.IdCotacao); %>">Avaliação</a>
                        </td>
                           <% } else if (item.Status == "Pendente de aceite do cliente")
                            {%>
                         <td>
                             <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                             <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Aceitar/Negar</a>
                        </td>
                           <% }else if (item.Status == "Aguardando liberação do pagamento")
                            {%>
                         <td>
                             <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Serviço</a>
                             <a class="btn btn-brikk" href="finalizar-pagamento.aspx?Id=<%Response.Write(item.IdCotacao); %>">Liberar pagamento</a>
                        </td>
                           <% }%>
                    </tr>
                    <%  }
                    %>
                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

</asp:Content>
