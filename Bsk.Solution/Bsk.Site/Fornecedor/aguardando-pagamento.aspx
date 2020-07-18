<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="aguardando-pagamento.aspx.cs" Inherits="Bsk.Site.Fornecedor.aguardando_pagamento" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
 <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h3 class="tableTitle">Aguardando pagamento do cliente</h3>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
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

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>
</asp:Content>
