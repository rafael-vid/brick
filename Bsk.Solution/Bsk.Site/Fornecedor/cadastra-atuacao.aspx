<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastra-atuacao.aspx.cs" Inherits="Bsk.Site.Fornecedor.cadastra_atuacao" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="conteudo-dash listar-servicos">
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
                <img src="../assets/imagens/atuacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Minhas áreas de atuação</h2>
            </div>

            <div class="item_content_card">
                <%var cat = PegaCategoria(); %>

                <h2 class="subtitulo_card subtitulo_1">Meus serviços </h2>
                <p><%Response.Write(cat.Nome); %></p>
            </div>

            <div class="filtros_card">
                <div class="select-card">
                    <select id="slcAtu" runat="server">
                       <option value="">Selecione um serviço</option>
                    </select>
                </div>
            </div>
              <div class="card-acoes">
                <button class="btn" style="margin-top: 20px;" id="btnAdicionar" runat="server" onserverclick="btnAdicionar_ServerClick">Adicionar serviço</button>
            </div>
            <h2 class="subtitulo_card subtitulo_1">Meus serviços</h2>

            <div class="servicos_atuacao lista-even">
                <div class="servico_item">
                  <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                            <thead>
                                <tr class="linha1">
                                    <td>Serviço</td>
                                    <td>Ação</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%var servicos = PegaServico();
                                    foreach (var item in servicos)
                                    {%>
                                <tr>
                                    <td><%Response.Write(item.Nome); %></td>
                                    <td>
                                        <a href="cadastra-atuacao.aspx?Id=<%Response.Write(item.IdCategoria); %>&Del=<%Response.Write(item.IdServico); %>" class="btn btn-brikk">Deletar</a>
                                    </td>
                                </tr>
                                <% }
                                %>
                            </tbody>
                        </table>
                </div>
            </div>

          
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
    </style>

</asp:Content>
