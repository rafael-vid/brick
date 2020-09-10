<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-cotacoes.aspx.cs" Inherits="Bsk.Site.Fornecedor.minhas_cotacoes" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2 class="tableTitle">Minhas cotações em negociação</h2>
        Total a receber: <span id="totalReceber" runat="server">R$0,00</span>
        <a class="btn btn-lg btn-brikk pull-right" href="minhas-areas.aspx">Minhas Áreas</a> <div class="col col-lg-1 col-md-1 col-sm-1 col-xs-1 pull-right">&nbsp;</div>
        <a class="btn btn-lg btn-brikk pull-right" href="cotacao-lista.aspx">Buscar Cotação <span style="color:#ffffff; font-weight: lighter!important;">
            <asp:Label ID="icone" runat="server" Text="Label"></asp:Label></span></a>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pd-0">
            <label>Filtro de Status:</label>
            <select class="form-control" onchange="filtraTabela();" id="slcStatus">
                <option value="0">Selecione um status</option>
                <option value="1">Recusado</option>
                <option value="2">Aberto</option>
                <option value="3">Aguardando pagamento</option>
                <option value="4">Em andamento</option>
                <option value="5">Pendente de finalização do cliente</option>
                <option value="6">Finalizado</option>
            </select>
        </div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Nº Cotação</td>
                        <td>Título</td>
                        <td>Nome cliente</td>
                        <td>Entrega</td>
                        <td>Valor</td>
                        <td>Última atualização</td>
                        <td>Status</td>
                        <%--<td>Ação</td>--%>
                    </tr>
                </thead>
                <tbody>
                    <%var cotacoes = PegaCotacoes();
                        foreach (var item in cotacoes)
                        {
                            string link = "";
                            if (item.Status == "Recusado")
                            {
                                link = "negociar-cotacao.aspx?Id=" + item.CotacaoFornecedorId;
                            }
                            else if (item.Status == "Aberto")
                            {
                                link = "negociar-cotacao.aspx?Id=" + item.CotacaoFornecedorId;
                            }
                            else if (item.Status == "Aguardando pagamento")
                            {
                                link = "negociar-cotacao.aspx?Id=" + item.CotacaoFornecedorId;
                            }
                            else if (item.Status == "Em andamento")
                            {
                                link = "negociar-cotacao.aspx?Id=" + item.CotacaoFornecedorId;
                            }
                            else if (item.Status == "Pendente de finalização do cliente")
                            {
                                link = "negociar-cotacao.aspx?Id=" + item.CotacaoFornecedorId;
                            }
                            else if (item.Status == "Finalizado")
                            {
                                link = "avaliar.aspx?Id=" + item.CotacaoFornecedorId;
                            }
                    %>
                    <tr onclick="redirecionar('<%Response.Write(link); %>')">
                        <td><%Response.Write(item.CotacaoId); %><span style="color:red;"><%Response.Write(item.Mensagens); %></span></td>
                        <td><%Response.Write(item.Titulo); %></td>
                        <td><%Response.Write(item.Nome); %></td>
                        <td><%Response.Write(item.DataEntrega); %></td>
                        <td><%Response.Write(string.Format("{0:C}", item.Valor)); %></td>
                        <td><%Response.Write(item.DataAlteracao); %></td>
                        <td>
                            <%if (item.Status == "Recusado")
                                {%>
                            Recusado
                            <%}
                                else if (item.Status == "Aberto")
                                {%>
                            Em cotação
                            <%}
                                else if (item.Status == "Aguardando pagamento")
                                {%>
                           Aguardando pagamento
                            <%}
                                else if (item.Status == "Em andamento")
                                {%>
                           Em andamento
                            <%}
                                else if (item.Status == "Pendente de finalização do cliente")
                                {%>
                          Pendente de finalização do cliente
                            <%}
                                else if (item.Status == "Finalizado")
                                {%>
                           Finalizado
                            <%} %>
                        </td>
                        <%-- <td>
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
                        </td>--%>
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
                table.search("Recusado").draw();
            } else if ($("#slcStatus").val() == "2") {
                table.search("Aberto").draw();
            } else if ($("#slcStatus").val() == "3") {
                table.search("Aguardando pagamento").draw();
            } else if ($("#slcStatus").val() == "4") {
                table.search("Em andamento").draw();
            } else if ($("#slcStatus").val() == "5") {
                table.search("Pendente de finalização do cliente").draw();
            } else if ($("#slcStatus").val() == "6") {
                table.search("Finalizado").draw();
            }
        }
    </script>
</asp:Content>

