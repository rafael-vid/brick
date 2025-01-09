<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cotacao-lista.aspx.cs" Inherits="Bsk.Site.Cliente.cotacao_lista" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash  cli-cotacao">
         <div class="acessos">
              <a class="btn_card" href="buscar-servico.aspx"><img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Nova Solicitações</a>
              <a class="btn_card" href="minhas-cotacoes.aspx">Minhas Solicitações</a>
              <a class="btn_card" href="aguardando-pagamento.aspx">Pagamentos</a>
          </div>
          <div class="acessos-small">
              <div class="row">
                  <div class="dropdown">
                      <a class="btn_card" href="buscar-servico.aspx" style="margin-top: 10px;">
                          <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Nova Solicitações
                      </a>
                      <button type="button" class="btn_card dropdown-toggle" onclick="toggleDropdown()" style="margin-top: 10px; justify-content: right; background: white; filter: brightness(100%); box-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3); border: none; cursor: pointer; appearance: none; -webkit-appearance: none; -moz-appearance: none;">
                          <i class="fas fa-ellipsis-v" style="font-size: 16px;"></i>
                      </button>
                      <div class="dropdown-menu" id="dropdownMenu" style="display: none;">
                          <a class="dropdown-item" href="minhas-cotacoes.aspx">Minhas Solicitações</a>
                          <a class="dropdown-item" href="aguardando-pagamento.aspx">Pagamentos</a>
                      </div>

                      <script>
                          function toggleDropdown() {
                              var menu = document.getElementById("dropdownMenu");
                              // Toggle between showing and hiding the dropdown
                              menu.style.display = (menu.style.display === "none" || menu.style.display === "") ? "block" : "none";
                          }

                          // Close the dropdown if the user clicks outside of it
                          window.onclick = function (event) {
                              if (!event.target.matches('.dropdown-toggle')) {
                                  var dropdowns = document.getElementsByClassName("dropdown-menu");
                                  for (var i = 0; i < dropdowns.length; i++) {
                                      var openDropdown = dropdowns[i];
                                      if (openDropdown.style.display === 'block') {
                                          openDropdown.style.display = 'none';
                                      }
                                  }
                              }
                          }
                      </script>
                  </div>
              </div>
              <div class="row">
          
              </div>
          </div>
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotação /Cod.<span id="nrCotacao" runat="server"></span></h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <p id="titulo" runat="server">Pintura Loja Oscar Freire</p>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Detalhamento </h2>
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
                            <td><%Response.Write(item.NomeParticipante); %></td>
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
        .conteudo-dash {
            padding: 30px 35px 40px 35px;
        }
        .card-tabela tr td a.btn {
            text-align: center;
            padding: 10px;
            margin-bottom: 20px;
        }
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
                 padding: 5px 15px 15px 15px;
                 flex-direction: column;
             }
             .btn_card {
                 font-size: 14px;
                 width: 44% !important;
                 min-width: 0px !important;
             }
            .card {
                padding: 15px!important;
            }
            .card-cotacao-dados {
                width: 100% !important;
                max-width: 388px; /* Mantenha esse limite, se necessário */
            }
            .dataTables_length label select{
                left: 15px !important;
            }
            .total_a_receber p {
                font-size: 25px;
            }
            .grid {
                flex-direction: column;
                margin-left: 15px;
            }    
            .media-cotacoes {
                min-width: 80% !important;
                
            }
        }
        acessos-small{
             display: flex;
             flex-direction: column; /* Empilha verticalmente */
        }
        .dropdown-menu {
            position: absolute; /* Permite o posicionamento em relação ao botão */
            background-color: white;
            border: 1px solid #ccc;
            z-index: 1;
            min-width: 150px; /* Largura do dropdown */
            top: calc(100% + 5px); /* O menu aparece logo abaixo do botão */
            right: 25px; /* Alinha o menu com a borda esquerda do botão */
        }
        .dropdown-toggle::after {
            content: none; /* Remove a setinha */
        }

        .dropdown {
            position: relative; /* Necessário para a posição do dropdown */
            display: inline-flex;
            justify-content: space-around;
        }

        .dropdown-item {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: black;
            margin-right: 0px;
        }

        .dropdown-item:hover {
            background-color: #f1f1f1; /* Muda a cor ao passar o mouse */
        }
    </style>
     <script>
         function updateVisibility() {
             if (window.innerWidth < 768) {
                 document.querySelector('.acessos').style.display = 'none';
                 document.querySelector('.acessos-small').style.display = 'flex';
             } else {
                 document.querySelector('.acessos').style.display = 'flex';
                 document.querySelector('.acessos-small').style.display = 'none';
             }
         }

         // Chama a função ao carregar a página
         updateVisibility();

         // Adiciona evento para redimensionamento da janela
         window.addEventListener('resize', updateVisibility);
         function toggleDropdown() {
             var menu = document.getElementById("dropdownMenu");
             if (menu.style.display === "none") {
                 menu.style.display = "block";
             } else {
                 menu.style.display = "none";
             }
         }

         // Fecha o dropdown se o usuário clicar fora dele
         window.onclick = function (event) {
             if (!event.target.matches('.dropdown-toggle')) {
                 var dropdowns = document.getElementsByClassName("dropdown-menu");
                 for (var i = 0; i < dropdowns.length; i++) {
                     var openDropdown = dropdowns[i];
                     if (openDropdown.style.display === 'block') {
                         openDropdown.style.display = 'none';
                     }
                 }
             }
         }
     </script>
</asp:Content>
