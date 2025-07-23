<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="notificacoes.aspx.cs" Inherits="Bsk.Site.Cliente.notificacoes" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao cotacoes-cli">
       


        <div class="card card-cotacao-dados">
            <div class="titulo_card">
                <img src="../assets/imagens/dados-icon.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Notificações</h2>
            </div>
            <div class="filtros_card">


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
                <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <th>ID </th>
                            <th>Título</th>
                            <th>Mensagem</th>
                            <th>Data</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%var cotacoes = Notificacoes();
                            string link = "";
                            foreach (var item in cotacoes)
                            {                               
                        %>

                        <tr class="cursor visualizado<%Response.Write(Convert.ToInt32(item.visualizado)); %>" onclick="window.location.href='notificacao.aspx?id=<%Response.Write(item.idnotificacao); %>&link=<%Response.Write(item.link); %>'">
                            <td><%Response.Write(item.idnotificacao); %></td>
                            <td><%Response.Write(item.titulo); %></td>
                            <td><%Response.Write(item.mensagem); %></td>
                            <td><%Response.Write(item.data); %></td>
                        </tr>
                        <%  }
                            
                        %>
                    </tbody>
                </table>
            </div>
         <div class="imitation-table" id="imitationTable" style="display:none;">
            <% 
                var notificacoes2 = Notificacoes();
                if (notificacoes2 == null || notificacoes2.Count == 0) {
            %>
                <div class="table-row">
                    <div class="table-cell" style="justify-content: center; text-align: center;">
                        Nenhum registro encontrado.
                    </div>
                </div>
            <% } else {
                foreach (var item in notificacoes2) { 
                    string linkFinal = $"notificacao.aspx?id={item.idnotificacao}&link={item.link}";
            %>
                <div class="table-row cursor visualizado<%= Convert.ToInt32(item.visualizado) %>" onclick="redirecionar('<%= linkFinal %>')">
                    <div class="table-cell"><strong>ID:</strong> <%= item.idnotificacao %></div>
                    <div class="table-cell"><strong>Título:</strong> <%= item.titulo %></div>
                    <div class="table-cell"><strong>Mensagem:</strong> <%= item.mensagem %></div>
                    <div class="table-cell"><strong>Data:</strong> <%= item.data %></div>
                </div>
            <%  } 
               } %>
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
        @media (max-width: 768px) {
            .conteudo-dash{
                padding: 0px 0px 0px 0px !important;
            }
            .conteudo-dash{
                min-height: 0px !important;
            }
            .card-cotacao-dados {
                width: 400px !important;
            }
            .cotacoes-cli .acessos {
                flex-wrap: unset;
            }
            .acessos-small {
                display: flex; /* Exibe para telas pequenas */
            }
            .btn_card {
                font-size: 14px;
                width: 40% !important;
                min-width: 0px !important;
            }
           .card {
               padding: 15px!important;
           }
           .card-cotacao-dados {
               width: 100% !important;
           }
           .cotacao .card {
               margin-top: 0px !important;
           }
        }
        a.notificacoes{
            background: #f4f3f2;
            color: #770e18 !important;
        }

        div#tabela_paginate > span {
            display: flex
        }
        .visualizado0{
            font-weight:bold;
            color:#000 !important
        }
        .visualizado1{
            font-weight:bold;
            color:#666 !important
        }
        .imitation-table {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .table-row {
            font-family: Rajdhani-semi;
            border: 1px solid #ccc;
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            cursor: pointer;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .table-cell {
            flex: 1 1 100%;
            display: flex;
            justify-content: space-between;
        }

        @media(min-width: 768px) {
            .imitation-table {
                display: none !important;
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
    <script>
        function updateVisibility() {
            if (window.innerWidth < 768) {
                document.querySelector('#tabela').style.display = 'none';
                document.querySelector('.imitation-table').style.display = 'flex';
            } else {
                document.querySelector('#tabela').style.display = 'table';
                document.querySelector('.imitation-table').style.display = 'none';
            }
        }

        window.addEventListener('resize', updateVisibility);
        document.addEventListener('DOMContentLoaded', updateVisibility);

        function redirecionar(valor) {
            window.location.href = valor;
        }
    </script>
    

</asp:Content>
