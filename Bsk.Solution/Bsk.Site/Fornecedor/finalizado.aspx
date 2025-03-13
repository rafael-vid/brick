<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="finalizado.aspx.cs" Inherits="Bsk.Site.Fornecedor.finalizado" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao cotacoes-cli">
        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Nova Solicitação
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
            <div class="filtros_card" style="display:none">

                <div class="select-card">
                    <select onchange="filtraTabela();" id="slcStatus">
                        <option value="0">Selecione um status</option>
                        
                        <option value="7" <% if (Request.QueryString["status"] != null && Request.QueryString["status"] == "7") { Response.Write("selected"); }  %>>Finalizado</option>
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
                                    link = "cadastro-solicitacao.aspx?Cotacao=" + item.CotacaoId;
                                }
                                else if (item.Status == "Aberto")
                                {
                                    link = "cotacao-lista.aspx?Id=" + item.CotacaoId;
                                }
                                else if (item.Status == "Em andamento")
                                {
                                    link = "negociar-cotacao.aspx?Id=" + item.CotacaoFornecedorId;
                                }
                                else if (item.Status == "Aguardando pagamento")
                                {
                                    link = "pagamento.aspx?Id=" + item.CotacaoFornecedorId;
                                }
                                else if (item.Status == "Finalizado")
                                {
                                    link = "avaliar.aspx?Id=" + item.CotacaoId;
                                }
                                else if (item.Status == "Aguardando aceite")
                                {
                                    link = "negociar-cotacao.aspx?Id=" + item.CotacaoFornecedorId;
                                }
                                else if (item.Status == "Aguardando liberação do pagamento")
                                {
                                    link = "finalizar-pagamento.aspx?Id=" + item.CotacaoId;
                                }
                                else if (item.Status == "Avaliado")
                                {
                                    link = "avaliar.aspx?Id=" + item.CotacaoId;
                                }
                        %>

                        <tr class="cursor" onclick="redirecionar('<%Response.Write(link);%>');">
                            <td><%Response.Write(item.CotacaoId); %></td>
                            <td><%Response.Write(item.Titulo); %></td>
                            <td><%Response.Write(item.DataAlteracao.ToString().Replace("01/01/0001 00:00:00", "")); %></td>

                            <%  
                                if (item.Status == "Criação")
                                {%>
                            <td class="status">Pendente de envio
                            </td>
                            <%}
                                else if (item.Status == "Aberto")
                                {%>
                            <td class="status">Em Solicitação 
                            </td>
                            <% }
                                else if (item.Status == "Em andamento")
                                {%>
                            <td class="status">Em andamento
                            </td>
                            <%}
                                else if (item.Status == "Aguardando pagamento")
                                {%>
                            <td class="status">Aguardando pagamento
                            </td>
                            <%}
                                else if (item.Status == "Finalizado")
                                {%>
                            <td class="status">Finalizado
                            </td>
                            <% }
                                else if (item.Status == "Pendente de aceite do cliente")
                                {%>
                            <td class="status">Aguardando aceite
                            </td>
                            <% }
                                else if (item.Status == "Aguardando liberação do pagamento")
                                {%>
                            <td class="status">Aguardando liberação do pagamento
                            </td>
                            <% }
                                else if (item.Status == "Avaliado")
                                {%>
                            <td class="status">Avaliado
                            </td>
                        </tr>
                        <%  }
                            }
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
        a.finalizada{
            background: #f4f3f2;
            color: #770e18 !important;
        }

        div#tabela_paginate > span {
            display: flex
        }
         @media (max-width: 768px) {
             div#tabela_filter {
                 /* position: relative; */
                 display: flex;
                 /* right: 0; */
                 /* margin-top: 30px; */
                 margin-bottom: 40px;
             }
             div#tabela_filter::before {
                 content: '🔍︎';
                 z-index: 400;
                 position: absolute;
                 display:flex;
                 bottom: 10px;
                 top: -30px;
                 /* display: block; */
             }
             .conteudo-dash {
                 padding: 15px 0px !important;
             }
             div#tabela_filter input[type="search"], .dataTables_length label {
                 width: 100% !important;
             }
             div#tabela_filter input[type="search"] {
                 height: 40px;
                 margin: -40px 40px 30px -10px !important;
             }
             .acessos {
                display: flex;
                justify-content: space-evenly !important;
                flex-wrap: wrap;
                grid-gap: 30px !important;
             }
            .cotacao .card {
                min-height: 100vh;
                min-width: 56vh;
            }
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
