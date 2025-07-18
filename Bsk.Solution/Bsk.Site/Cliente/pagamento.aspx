<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao cotacoes-cli">

<div class="conteudo-dash cotacao dados-cotacao cotacoes-cli">
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

        <div class="card" id="divPagamento" runat="server">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotações/ Cod.<asp:Label ID="nrCotacao" runat="server" Text=""></asp:Label>/ Pagamento</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <p id="tituloServ" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Detalhamento </h2>
                <p id="descricao" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Prestador de Serviço </h2>
                <p id="fornecedorNome" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Resumo da Cotação</h2>
                <p>Cotação nº <span id="nrServico" runat="server"></span></p>
            </div>

            <div class="item_content_card ">
                <div class="card-content-chat">
                    <div>
                        <div class="item_content_card ">
                            <div class="subtitulo-com-icone">
                                <img src="../assets/imagens/calendario.svg" alt="ícone" style="width: 20px;">
                                <h2 class="subtitulo_card_1 subtitulo_1">Data  Entrega</h2>
                            </div>
                            <div class="expo-info-values">
                                <span id="dtEntrega" runat="server"></span>
                            </div>
                        </div>
                       <div class="cli-infos-value">
                    <div class="item_content_card ">
                        <div class="subtitulo-com-icone">
                            <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                            <h2 class="subtitulo_card_1 subtitulo_1">Valor do Serviço</h2>
                        </div>
                        <div class="expo-info-values">
                            <span id="valorServ" runat="server"></span>
                        </div>
                    </div>
                </div>
                     
                    </div>

                    <div class="item_content_card ">
                        <div class="subtitulo-com-icone">
                            <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                            <h2 class="subtitulo_card_1 subtitulo_1">Forma de Pagamento</h2>
                          
                        </div>
                        <div class="files-upload cotacao-dados-upload">
                            <%--<a class="btn_card" id="btnBoleto" href="pagamento-boleto.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">Boleto Bancário</a>--%>
                            <a class="btn_card" id="btnCartao" href="pagamento-cartao.aspx?&Id=<%Response.Write(Request.QueryString["Id"]); %>">Cartão de Crédito </a>
                            <a class="btn_card" id="btnBoleto" href="pagamento-boleto.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">Boleto Bancário</a>
                            <a class="btn_card" id="btnPix" href="pagamento-pix.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">PIX</a>

                        </div>
                    </div>

                </div>
            </div>

            <div>
                <asp:Literal ID="ltBoleto" runat="server"></asp:Literal>
            </div>

            <div>
                <asp:Literal ID="ltRecibo" runat="server"></asp:Literal>
            </div>

            <div class="footer_card">
                <a class="voltar btn" href="minhas-cotacoes.aspx"><< voltar
                </a>
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
        .divAceitar2{
            bottom: 0px; 
            right: 0px; 
            position: absolute; 
            z-index: 1000; 
            border: 0px;
        }
    }
   

/* Estilos para dispositivos móveis */
    @media (max-width: 768px) {

        acessos-small {
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



  <%--  <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12 corpo-site">
        <div>
            <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Pagamento<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert alert-success bg-success text-center" style="width: 100%;">
                <span class="tableTitle"><small>Mensagem do sistema:</small><br />
                    <strong>Legal!</strong> Ficamos felizes que tudo deu certo entre você e nosso Parceiro<br />
                    Agora falta pouco. Confira atentamente o valor descrito abaixo e escolha a forma de pagamento<br />
                    Esperamos que use nossos serviços novamente.<br />
                    Muito Obrigado!
                </span>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 col-lg-offset-2 col-md-offset-2">
                <h2 style="margin-top: 0;">Resumo da cotação</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 notaFiscal">
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                        <img src="img/logo.png" class="img-responsive center-block" />
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <strong class="pull-right">Cotação nº </strong>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <span class="pull-left">Prestador de Serviços:</span> <strong text=""></strong>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        Serviço Prestado: <strong class="pull-right" text=""></strong>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <h4 style="color: #b8272c;"><strong class="pull-left">Valor do Serviço:</strong> <strong class="pull-right" text=""></strong></h4>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                </div>
            </div>
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <h2 style="margin-top: 0;">Pagar com:</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" style="width: 100%;" >
                        <img src="img/boleto.jpg" class="img-responsive center-block btn-pagamento" alt="">
                    </a>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" style="width: 100%;" >
                        <img src="img/cartao.jpg" class="img-responsive center-block btn-pagamento" alt="">
                    </a>
                </div>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        </div>

    </div>
    <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>--%>


</asp:Content>
