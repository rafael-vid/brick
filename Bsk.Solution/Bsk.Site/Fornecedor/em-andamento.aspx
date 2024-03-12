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
          

            <div class="card-tabela " style="overflow-x: auto;">
                <table class="table table-condensed table-responsive table-striped table-hover">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <td>Nº Cotação</td>
                            <td>Título</td>
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
                            <td><%Response.Write(item.CotacaoId); %></td>
                            <td><%Response.Write(item.Titulo); %></td>
                            <td><%Response.Write(item.Nome); %></td>
                            <td><%Response.Write(item.Status); %></td>
                            <td>
                                <%if (item.Status == "Recusado")
                                    {%>
                                <center>-</center>
                                <%}
                                    else if (item.Status == "Aberto")
                                    {%>
                                <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Negociar</a>
                                <%}
                                    else if (item.Status == "Aguardando pagamento")
                                    {%>
                                <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Mensagens</a>

                                <%}
                                    else if (item.Status == "Em andamento")
                                    {%>
                                <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Mensagens</a>

                                <%}
                                    else if (item.Status == "Pendente de finalização do cliente")
                                    {%>
                                <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Mensagens</a>

                                <%}
                                    else if (item.Status == "Finalizado")
                                    {%>
                                <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                                <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Mensagens</a>
                                <a class="btn btn-brikk" href="avaliar.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Avaliação</a>
                                <%} %>                               
                            </td>

                        </tr>
                        <%  }
                        %>
                    </tbody>
                </table>
            </div>

           

            <div class="footer_card">
                <a class="voltar btn" href="dashboard.aspx"><< voltar </a>
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
