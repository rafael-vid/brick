<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="liberar-pagamento.aspx.cs" Inherits="Bsk.Site.Cliente.liberar_pagamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
      <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2 class="tableTitle">Liberação de Pagamento</h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <button class="btn btn-lg btn-brikk pull-right">Nova Cotação</button>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Nº Cotação</td>
                        <td>Fornecedor</td>
                        <td>Status</td>
                        <td>Valor</td>
                        <td>Ação</td>
                    </tr>
                </thead>
                <tbody>
                    <%var pagamentos = PegaCotacaoPagamento();

                        foreach (var item in pagamentos)
                        {%>
 <tr>
                        <td><%Response.Write(item.CotacaoId); %></td>
                        <td><%Response.Write(item.NomeFornecedor); %></td>
                        <td>Aguardando pagamento</td>
                        <td>R$<%Response.Write(item.Valor); %></td>
                        <td>
                            <a class="btn btn-brikk liberarPagamento" href="pagamento.aspx?Id=<%Response.Write(item.CotacaoId); %>">Liberar Pagamento</a>&nbsp;&nbsp; <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                        </td>
                    </tr>
                       <% }
                        %>
                   
                    
                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

</asp:Content>
