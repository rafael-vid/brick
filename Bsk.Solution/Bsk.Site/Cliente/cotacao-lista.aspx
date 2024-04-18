<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cotacao-lista.aspx.cs" Inherits="Bsk.Site.Cliente.cotacao_lista" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash  cli-cotacao">
        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Nova Cotação
            </a>
            <a href="minhas-cotacoes.aspx" class="btn_card">Minhas Cotações
            </a>
            <a href="aguardando-pagamento.aspx" class="btn_card">Pagamentos
            </a>
        </div>
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotação /Cod.<span id="nrCotacao" runat="server"></span></h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Título </h2>
                <p id="titulo" runat="server">Pintura Loja Oscar Freire</p>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <asp:Label ID="descricao" runat="server"></asp:Label>
            </div>

            <div class="grid" style="margin-top:20px">
                 <div class="item_content_card">
                    <div class="total_a_receber media-cotacoes">
                        <span>Mínimo das cotações recebidas</span>
                        <p id="valorMinimoCotacoes" runat="server"></p>
                        <div class="eleva_sifra cli-eleva">
                            <img src="../assets/imagens/media.svg" alt="ícone">
                        </div>
                    </div>
                </div>
                <div class="item_content_card">
                    <div class="total_a_receber media-cotacoes">
                        <span>Média das cotações recebidas</span>
                        <p id="valorMedioCotacoes" runat="server"></p>
                        <div class="eleva_sifra cli-eleva">
                            <img src="../assets/imagens/media.svg" alt="ícone">
                        </div>
                    </div>
                </div>
                <div class="item_content_card">
                    <div class="total_a_receber media-cotacoes">
                        <span>Máximo das cotações recebidas</span>
                        <p id="valorMaximoCotacoes" runat="server"></p>
                        <div class="eleva_sifra cli-eleva">
                            <img src="../assets/imagens/media.svg" alt="ícone">
                        </div>
                    </div>
                </div>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="filtros_card cota-info" style="margin-top: 40px;">
                <div class="resultado">
                    <span class="numero_card">04</span>

                    <p class="texto-resultado">
                        Resultado por página
                    </p>
                </div>

                <div class="pesquisar">
                    <img src="../assets/imagens/lupa-cinza.svg" alt="lipa" style="width: 15px;">
                    <input type="text" placeholder="Pesquisar" class="pesquisar_input">
                </div>
            </div>


            <div class="card-tabela " style="overflow-x: auto;">
                <table>
                    <thead id="cabecalho-tabela">
                        <tr class="linha1">
                            <td>Fornecedor</td>
                            <td class="text-center">Mensagem</td>
                            <td>Valor</td>
                            <td>Última resposta</td>
                            <td>Ação</td>
                        </tr>
                    </thead>

                    <tbody>
                        <%var cotacaoLista = PegaCotacaoLista();

                            foreach (var item in cotacaoLista)
                            {%>
                        <tr>
                            <td><%Response.Write(item.NomeFornecedor); %></td>
                            <td style="color: red; text-align: center;">
                                <%if (!String.IsNullOrEmpty(item.Mensagens))
                                    { Response.Write("<i class='center-block glyphicon glyphicon-envelope'></i>"); } %>
                                <span style="color: red;"><% if (item.Novo == 1)
                                                              {
                                                                  Response.Write("<i class='center-block glyphicon glyphicon-check'></i>");
                                                              }  %></span>
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

            <div class="paginas_card">
                <p>
                    Mostrando de <span>01</span> até <span>04</span> de <span>04</span> registros
                </p>

                <div class="paginas">
                    <button class="anterior">
                        &lt;&lt; anterior</button>
                    <span class="numero_card">10</span>
                    <button class="proximo">próximo &gt;&gt;</button>
                </div>
            </div>

            <div class="footer_card">
                <a class="voltar btn" href="minhas-cotacoes.aspx"><< voltar </a>
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

        .card-tabela tr td a.btn {
    text-align: center;
    padding: 10px;
    margin-bottom: 20px;
}
    </style>
</asp:Content>
