<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-cotacoes.aspx.cs" Inherits="Bsk.Site.Cliente.minhas_cotacoes" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pd-0">
                <label>Filtro de Status:</label>
                <select class="form-control" onchange="filtraTabela();" id="slcStatus">
                    <option value="0">Selecione um status</option>
                    <option value="1">Pendente de envio</option>
                    <option value="2">Em andamento</option>
                    <option value="3">Aguardando pagamento</option>
                    <option value="4">Em cotação</option>
                    <option value="5">Aguardando liberação do pagamento</option>
                    <option value="6">Aguardando aceite</option>
                    <option value="7">Finalizado</option>
                </select>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Nº Cotação <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Data criação <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Título <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Data Atualização <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <td>Status <i class="glyphicon glyphicon-arrow-down pull-right"></i></td>
                        <%-- <td>Ação</td>--%>
                    </tr>
                </thead>
                <tbody>
                    <%var cotacoes = PegaCotacoes();
                        string link = "";
                        foreach (var item in cotacoes)
                        {

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
                        <td><%Response.Write(item.IdCotacao); %><span style="color:red;"><%Response.Write(item.Mensagens); %></span></td>
                        <td><%Response.Write(item.DataCriacao); %></td>
                        <td><%Response.Write(item.Titulo); %></td>
                        <td><%Response.Write(item.DataAlteracao.ToString().Replace("01/01/0001 00:00:00","")); %></td>
                        <%  
                            if (item.Status == "Criação")
                            {%>
                        <td>Pendente de envio
                        </td>
                        <%}
                            else if (item.Status == "Aberto")
                            {%>
                        <td>Em cotação
                        </td>
                        <% }
                            else if (item.Status == "Em andamento")
                            {%>
                        <td>Em andamento
                        </td>
                        <%}
                            else if (item.Status == "Aguardando pagamento")
                            {%>
                        <td>Aguardando pagamento
                        </td>
                        <%}
                            else if (item.Status == "Finalizado")
                            {%>
                        <td>Finalizado
                        </td>
                        <% }
                            else if (item.Status == "Pendente de aceite do cliente")
                            {%>
                        <td>Aguardando aceite
                        </td>
                        <% }
                            else if (item.Status == "Aguardando liberação do pagamento")
                            {%>
                        <td>Aguardando liberação do pagamento
                        </td>
                        <% }%>
                        <%-- <%  
                            if (item.Status == "Criação")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="cadastro-cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Detalhes</a>
                        </td>
                        <%}
                            else if (item.Status == "Aberto")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="cotacao-lista.aspx?Id=<%Response.Write(item.IdCotacao); %>">Em cotação</a>
                        </td>
                        <% }
                            else if (item.Status == "Em andamento")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Em andamento</a>
                        </td>
                        <%}
                            else if (item.Status == "Aguardando pagamento")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="pagamento.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Pagamento pendente</a>
                        </td>
                        <%}
                            else if (item.Status == "Finalizado")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="avaliar.aspx?Id=<%Response.Write(item.IdCotacao); %>">Avaliação</a>
                        </td>
                        <% }
                            else if (item.Status == "Pendente de aceite do cliente")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdCotacaoFornecedor); %>">Aceitar/Negar</a>
                        </td>
                        <% }
                            else if (item.Status == "Aguardando liberação do pagamento")
                            {%>
                        <td>
                            <a class="btn btn-brikk" href="finalizar-pagamento.aspx?Id=<%Response.Write(item.IdCotacao); %>">Liberar pagamento</a>
                        </td>
                        <% }%>--%>
                    </tr>
                    <%  }
                    %>
                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

    <script>

        function redirecionar(valor) {
            window.location.href = valor;
        }

        function filtraTabela() {
    
            var table = $('#tabela').DataTable();

            if ($("#slcStatus").val() == "0") {
                table.search("").draw();
            } else if ($("#slcStatus").val() == "1") {
                table.search("Pendente de envio").draw();
            } else if ($("#slcStatus").val() == "2") {
                table.search("Em andamento").draw();
            } else if ($("#slcStatus").val() == "3") {
                table.search("Aguardando pagamento").draw();
            } else if ($("#slcStatus").val() == "4") {
                table.search("Em cotação").draw();
            } else if ($("#slcStatus").val() == "5") {
                table.search("Aguardando liberação do pagamento").draw();
            } else if ($("#slcStatus").val() == "6") {
                table.search("Aguardando aceite").draw();
            } else if ($("#slcStatus").val() == "7") {
                table.search("Finalizado").draw();
            }
        }
    </script>

</asp:Content>
