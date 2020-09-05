<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cotacao-lista.aspx.cs" Inherits="Bsk.Site.Cliente.cotacao_lista" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2 class="tableTitle">Cod. <strong id="nrCotacao" runat="server"></strong></h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <strong id="titulo" runat="server"></strong>
             <div> Média das cotacoes recebidas: <strong id="valorMedioCotacoes" runat="server"></strong></div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Fornecedor <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Mensagem <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Valor <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Última resposta <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Ação <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                    </tr>
                </thead>
                <tbody>
                    <%var cotacaoLista = PegaCotacaoLista();

                        foreach (var item in cotacaoLista)
                        {%>
                    <tr>
                        <td><%Response.Write(item.NomeFornecedor); %><span style="color:red;"><% if (item.Novo==1)
                                                                                                  {
                                                                                                    Response.Write("N");
                                                                                                  }  %></span></td>
                        <td style="color:red;">
                            <%Response.Write(item.Mensagens); %>

                        </td>
                        <td>R$<%Response.Write(item.Valor); %>

                        </td>
                        <td><%Response.Write(item.DataUltimaResposta); %></td>
                        <%if (item.Ativo == 0)
                            {%>
                        <td>Fornecedor desistiu da cotação</td>
                          <%}
                              else
                              {%>
                        <td>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.CotacaoFornecedorId); %>">Visualizar</a></td>

                        <%  } %>
                    </tr>
                    <% }
                    %>
                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

</asp:Content>
