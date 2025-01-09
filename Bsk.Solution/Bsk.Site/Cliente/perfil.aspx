<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perfil.aspx.cs" Inherits="Bsk.Site.Cliente.perfil" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

     <div class="conteudo-dash cotacao cotacoes-cli">
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
                  <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                  <h2 class="subtitulo_1">Dados Cadastrais</h2>
              </div>

              <form action="" class="form-boleto-cadastro">
                  <div style="display:grid;grid-template-columns: 50% 1fr;  grid-gap: 20px;">
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Nome</label>
                          <input type="text" class="card-input-add" id="nome" runat="server" required>
                          <label id="msgnome" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Sobrenome</label>
                          <input type="text" class="card-input-add" id="sobrenome" runat="server" required>
                          <label id="msgsobrenome" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card que bra">
                          <label class="subtitulo_card_1 subtitulo_1">E-mail</label>
                          <input type="text" class="card-input-add" id="email" runat="server" required>
                          <label id="msgemail" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Documento</label>
                          <input type="text" class="card-input-add" id="cpf" runat="server" required>
                          <label id="msgcpf" runat="server" class="card_erro subtitulo_1"></label>
                      </div>

                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Telefone</label>
                          <input type="text" class="card-input-add" id="telefone" runat="server" required>
                          <label id="msgtelefone" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card que bra">
                          <label class="subtitulo_card_1 subtitulo_1">Endereço</label>
                          <input type="text" class="card-input-add rua" id="rua" runat="server" required>
                          <label id="msgrua" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Bairro</label>
                          <asp:TextBox type="text" class="card-input-add bairro" id="bairro" runat="server" required ></asp:TextBox>
                          <label id="msgbairro" runat="server" class="card_erro subtitulo_1"></label>
                    </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Número</label>
                          <input type="text" class="card-input-add" id="numero" runat="server" required>
                          <label id="msgnumero" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">CEP</label>
                          <input type="text" class="card-input-add cep" id="cep" runat="server" required>
                          <label id="msgcep" runat="server" class="card_erro subtitulo_1"></label>
                      </div>

                      <script>
                          document.querySelector(".cep").onchange = function () {
                              var txtCep = document.querySelector(".cep").value
                              if (txtCep.length == 9) {
                                  txtCep = txtCep.replace(/[^0-9]/, '');
                                  var url = 'https://viacep.com.br/ws/' + txtCep + '/json/';
                                  $.ajax({
                                      url: url,
                                      dataType: 'jsonp',
                                      crossDomain: true,
                                      contentType: "application/json",
                                      success: function (json) {
                                          console.log(json)
                                          if (json.logradouro) {
                                              document.querySelector('.rua').value = json.logradouro
                                              document.querySelector('.bairro').value = json.bairro
                                              document.querySelector('.cidade').value = json.localidade
                                              document.querySelector('.uf').value = json.uf
                                          }
                                      }
                                  });
                              }
                          }
                          function updateVisibility() {
                              if (window.innerWidth < 768) {
                                  document.querySelector('.acessos').style.display = 'none';
                                  document.querySelector('.acessos-small').style.display = 'flex';
                              } else {
                                  document.querySelector('.acessos').style.display = 'flex';
                                  document.querySelector('.acessos-small').style.display = 'none';
                              }
                          }

                          updateVisibility();
                      </script>

                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Complemento</label>
                          <input type="text" class="card-input-add" id="complemento" runat="server">
                      </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Cidade</label>
                          <input type="text" class="card-input-add cidade" id="cidade" runat="server" required>
                          <label id="msgcidade" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Estado</label>
                          <input type="text" class="card-input-add uf" id="uf" runat="server" required>
                          <label id="msguf" runat="server" class="card_erro subtitulo_1"></label>
                      </div>
                      <div class="item_content_card">
                          <label class="subtitulo_card_1 subtitulo_1">Presta Serviços</label>
                          <input type="checkbox" id="prestaServicos" runat="server">
                      </div>
                    </div>
              </form>

              <div class="footer_card" style="margin-top: 36p;">
               <button class="btn btn-brikk btn-lg center-block" style="float: right;" id="btnAlterar" runat="server" onserverclick="btnAlterar_ServerClick">Alterar dados</button>

                  <!--
                  <a href="" class="item_notifica">
                      <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                      <span class="notificacao">02</span>
                  </a>
                  -->
              </div>

          </div>
      </div>
    <style>

        /*sweet alert style*/

        div:where(.swal2-container).swal2-center > .swal2-popup {
            border-radius: 40px !important;
            font-size: 16px !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-cancel {
            border-radius: 20px !important;
            background-color: #770e18 !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
            border-radius: 20px !important;
            background-color: #f08f00 !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-deny {
            border-radius: 20px !important;
            background-color: #f08f00 !important;
        }

        div:where(.swal2-icon).swal2-info {
            border-color: #770e18 !important;
            color: #770e18 !important;
        }

        .swal2-icon.swal2-error {
            border-color: #770e18 !important;
            color: #770e18 !important;
        }
        div:where(.swal2-icon).swal2-error [class^=swal2-x-mark-line] {
            background-color: #770e18 !important;
        }

        /*sweet alert style*/
            @media (max-width: 768px) {
                .conteudo-dash{
                    padding: 0px 0px 0px 0px !important;
                }
                .conteudo-dash{
                    min-height: 0px !important;
                }
                .card-cotacao-dados {
                    width: 410px !important;
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
                    max-width: 410px; /* Mantenha esse limite, se necessário */
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
                .enviar-msg {
                    width: 38%;
                }
                .divAceitar2{
                    bottom: 0px; 
                    right: 0px; 
                    position: absolute;  
                    border: 0px;
                }
                .subtitulo-com-icone {
                    width: 380px;
                }
                .btnAceitar{
                    background: white;
                    width: 150px;
                }
                .btnRecusar{
                    width: 150px;
                    margin-right: 15px;

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
        
        .divAceitar3 {
            position: fixed !important;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            padding: 85px;
            animation: slideUp 0.5s ease-out; /* Aplica a animação de deslizamento */
            flex-direction: row-reverse;

        }

    }



    </style>

   
</asp:Content>
