<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento-transacao.aspx.cs" Inherits="Bsk.Site.Admin.pagamento_transacao" MasterPageFile="~/Admin/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h3 class="tableTitle">Pagamentos</h3>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Cotação</td>
                        <td>Cliente</td>
                        <td>Fornecedor</td>
                        <td>Titulo</td>
                        <td>Tipo</td>
                        <td>Categoria</td>
                        <td>Valor</td>
                        <td>Status</td>
                    </tr>
                </thead>
                <tbody>
                    <!-- LOOP -->
                    <%
                        var transacoes = PegaTransacoes();

                        foreach (var item in transacoes)
                        {
                    %>
                    <tr onclick="darBaixa(<%Response.Write(item.IdTransacao); %>);">
                        <td>Nº<%Response.Write(item.IdCotacao); %></td>
                        <td><%Response.Write(item.Cliente); %></td>
                        <td><%Response.Write(item.Fornecedor); %></td>
                        <td><%Response.Write(item.Titulo); %></td>
                        <%if (String.IsNullOrEmpty(item.Url))
                            {%>
                        <td>Cartão</td>
                        <%  }
                            else
                            {%>
                        <td>Boleto</td>
                        <%  } %>
                        <td><%Response.Write(item.Categoria); %></td>
                        <td><%Response.Write(item.Valor); %></td>
                        <%if (item.Status == "1")
                            {%>
                        <td>Pago</td>
                        <% }
                            else if (item.Status == "2")
                            {%>
                        <td>Pendente</td>
                        <%}
                            else if (item.Status == "3")
                            { %>
                        <td>Vencido</td>
                        <%}
                            else if (item.Status == "5")
                            { %>
                        <td>Finalizado</td>
                        <%} %>
                    </tr>
                    <%
                        }
                    %>
                    <!-- FIM LOOP -->
                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

    <script>
        function darBaixa(valor) {
            Swal.fire({
                toast: true,
                title: 'Mudar status?',
                text: "Dar baixa na transação?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sim'
            }).then((result) => {
                if (result.value) {
                    var parametros = {
                        status: "5",
                        id: valor
                    };
                    comum.postAsync("Comum/MudaStatusTransacao", parametros, function (data) {
                        Swal.fire(
                            'Alterado',
                            'Registrado com sucesso.',
                            'success'
                        ).then(function (result2) {
                            location.reload();
                        });
                    });

                }
            });
        }
    </script>
</asp:Content>
