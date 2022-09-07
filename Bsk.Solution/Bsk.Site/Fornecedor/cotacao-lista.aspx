<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cotacao-lista.aspx.cs" Inherits="Bsk.Site.Fornecedor.cotacao_lista" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="conteudo-dash atuacao">
        <div class="acessos">
            <a href="cotacao-lista.aspx" class="btn_card">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Buscar nova cotação
            </a>
            <a href="em-andamento.aspx" class="btn_card">Cotações em negociação
            </a>
            <a href="minhas-areas.aspx" class="btn_card">Minhas áreas de atuação
            </a>
        </div>
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">

                <h2 class="subtitulo_1">Cotação / Cod. <span id="nrCotacao" runat="server"></span></h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Título </h2>
                <p>Pintura Loja Oscar Freire</p>
            </div>

            <div class="item_content_card descricao">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <p>Pintura de Parede</p>
            </div>


            <div class="filtros_card cota-info" style="margin-top: 40px;">
        

                <%--<div class="pesquisar">
                    <img src="../assets/imagens/lupa-cinza.svg" alt="lipa" style="width: 15px;">
                    <input type="text" placeholder="Pesquisar" class="pesquisar_input">
                </div>--%>
            </div>
            <div class="card-tabela " style="overflow-x: auto;">
                <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                    <thead>
                        <tr class="linha1">
                            <td>Título</td>
                            <td>Categoria</td>
                            <td>Ação</td>
                        </tr>
                    </thead>
                    <tbody>
                        <%var cotacaoLista = PegaCotacaoLista();

                            foreach (var item in cotacaoLista)
                            {%>
                        <tr>
                            <td><%Response.Write(item.Titulo); %></td>
                            <td><%Response.Write(item.Categoria); %></td>
                            <td>
                                <a class="btn btn-brikk mensagem" href="cotacao.aspx?Cotacao=<%Response.Write(item.IdCotacao); %>">Visualizar</a>

                            </td>

                        </tr>
                        <% }
                        %>
                    </tbody>
                </table>
            </div>

            <%--<div class="paginas_card">
                <p>
                    Mostrando de <span>01</span> até <span>04</span> de <span>04</span> registros
                </p>

                <div class="paginas">
                    <button class="anterior">
                        << anterior</button>
                    <span class="numero_card">10</span>
                    <button class="proximo">próximo >></button>
                </div>
            </div>--%>

            <div class="footer_card">
                <a class="voltar btn" href="cliente-dashboard.aspx"><< voltar </a>
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
</asp:Content>
