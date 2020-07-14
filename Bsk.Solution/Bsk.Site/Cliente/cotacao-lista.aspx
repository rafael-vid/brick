<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cotacao-lista.aspx.cs" Inherits="Bsk.Site.Cliente.cotacao_lista" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2 class="tableTitle">Cotação <span id="nrCotacao" runat="server"></span></h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <h3>Título da cotação</h3>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Fornacedor</td>
                        <td>Mensagem</td>
                        <td>Valor</td>
                        <td>Última resposta</td>
                        <td>Ação</td>
                    </tr>
                </thead>
                <tbody>
                    <%var cotacaoLista = PegaCotacaoLista();

                        foreach (var item in cotacaoLista)
                        {%>
                    <tr>
                        <td><%Response.Write(item.NomeFornecedor); %></td>
                        <td>
                            <button class="btn btn-brikk mensagem">Mensagem&nbsp;&nbsp;&nbsp;<span class="badge bg-success"><%Response.Write(item.NumeroMensagens); %></span></button>

                        </td>
                        <td>R$<%Response.Write(item.Valor); %>

                        </td>
                        <td><%Response.Write(item.DataUltimaResposta); %></td>
                        <td>
                            <a class="btn btn-brikk mensagem" href="negociar-cotacao.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Visualizar &nbsp;</a></td>
                    </tr>
                    <% }
                    %>
                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>
   
</asp:Content>
