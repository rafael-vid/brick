<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-cotacoes.aspx.cs" Inherits="Bsk.Site.Cliente.minhas_cotacoes" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao cotacoes-cli">
        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Nova Solicitações
            </a>
            <a href="minhas-cotacoes.aspx" class="btn_card">Minhas Solicitações
            </a>
            <a href="aguardando-pagamento.aspx" class="btn_card">Pagamentos
            </a>
        </div>

        <div class="card card-cotacao-dados">
            <div class="titulo_card">
                <img src="../assets/imagens/dados-icon.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotação</h2>
            </div>
            <div class="filtros_card">

                <div class="select-card">
                    <select onchange="filtraTabela();" id="slcStatus">
                        <option value="0">Selecione um status</option>
                        <% 
                            var itens = GetDashboardCliente();

                            foreach(var i in itens)
                            {
                                %>
                                    <option value="<% Response.Write(i.id); %>" <% if (Request.QueryString["status"] != null && Request.QueryString["status"] == i.id.ToString()) { Response.Write("selected"); }  %> ><% Response.Write(i.nome); %></option>
                                <%
                            }

                            %>


                    </select>
                </div>

                <%--<div class="pesquisar">
                    <img src="../assets/imagens/lupa-cinza.svg" class="dash-lupa" alt="lupa" style="width: 15px;">
                    <input type="text" placeholder="Pesquisar" class="pesquisar_input">
                </div>--%>
            </div>

           <%-- <div class="resultado">
                <span class="numero_card">10</span>

                <p class="texto-resultado">
                    Resultado por página
                </p>
            </div>--%>

            <div class="card-tabela " style="overflow-x: auto;">
                
                <table id="tabela" data-order='[[ 4, "asc" ]]' class="table table-condensed table-responsive table-striped table-hover">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <th>Nº Cotação </th>
                            <th>Data de Criação</th>
                            <th>Título</th>
                            <th>Data Atualizada</th>
                            <th style="text-align: center;">Status</th>
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
                                else if (item.Status == "Aguardando aceite")
                                {
                                    link = "negociar-cotacao.aspx?Id=" + item.IdCotacaoFornecedor;
                                }
                                else if (item.Status == "Aguardando liberação do pagamento")
                                {
                                    link = "finalizar-pagamento.aspx?Id=" + item.IdCotacao;
                                }
                                else if (item.Status == "Avaliado")
                                {
                                    link = "avaliar.aspx?Id=" + item.IdCotacao;
                                }
                        %>

                        <tr class="cursor" onclick="redirecionar('<%Response.Write(link);%>');">
                            <td><%Response.Write(item.IdCotacao); %></td>
                            <td><%Response.Write(item.DataCriacao); %></td>
                            <td><%Response.Write(item.Titulo); %></td>
                            <td><%Response.Write(item.DataAlteracao.ToString().Replace("01/01/0001 00:00:00", "")); %></td>

                           

                            <td class="status"><%Response.Write(item.nome); %>
                            </td>
                           
                        </tr>
                        <%  }
                            
                        %>
                    </tbody>
                </table>
            </div>

            

            <div class="footer_card">
                <a href="cliente-dashboard.aspx" class="voltar btn"><< voltar </a>
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
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }

        div#tabela_paginate > span {
            display: flex
        }
    </style>

    <script>
        

        function redirecionar(valor) {
            window.location.href = valor;
        }

        function filtraTabela() {

            var table = $('#tabela').DataTable();

            if ($("#slcStatus").val() == "0") {
                table.search("").draw();
            } else if ($("#slcStatus").val() == "1") {
                table.search("Aguardando Cotação").draw();
            } else if ($("#slcStatus").val() == "2") {
                table.search("Em Cotação").draw();
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
            } else if ($("#slcStatus").val() == "8") {
                table.search("Rascunho").draw();
            }
        }

        setTimeout(function () { filtraTabela() }, 10)




    </script>

    

</asp:Content>
