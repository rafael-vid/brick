<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-cotacoes.aspx.cs" Inherits="Bsk.Site.Cliente.minhas_cotacoes" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2 class="tableTitle">Minhas cotações</h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <button class="btn btn-lg btn-brikk pull-right">Nova Cotação</button>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Nº Cotação</td>
                        <td>Título</td>
                        <td>Depoimento</td>
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
                        <td><%Response.Write(item.Titulo); %></td>
                        <td><%Response.Write(item.Depoimento); %></td>
                        <td><%Response.Write(item.Status); %></td>
                        <td>
                            <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%Response.Write(item.IdCotacao); %>">Visualizar</a>
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
