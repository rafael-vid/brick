<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perfil.aspx.cs" Inherits="Bsk.Site.Cliente.perfil" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

     <div class="conteudo-dash cotacao cotacoes-cli">

          <div class="acessos">
              <a class="btn_card" href="buscar-servico.aspx">
                  <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                  Nova Cotação
              </a>
              <button class="btn_card">
                  Minhas Cotações
              </button>
              <button class="btn_card">
                  Pagamentos
              </button>
          </div>

          <div class="card">
              <div class="titulo_card">
                  <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                  <h2 class="subtitulo_1">Dados Cadastrais</h2>
              </div>

              <form action="" class="form-boleto-cadastro">
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Nome</label>
                      <input type="text" class="card-input-add" id="nome" runat="server" required>
                  </div>
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Sobrenome</label>
                      <input type="text" class="card-input-add" id="sobrenome" required>
                  </div>
                  <div class="item_content_card quebra">
                      <label class="subtitulo_card_1 subtitulo_1">E-mail</label>
                      <input type="text" class="card-input-add" id="email" runat="server" required>
                  </div>
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Documento</label>
                      <input type="text" class="card-input-add" id="cpf" runat="server" required>
                  </div>

                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Telefone</label>
                      <input type="text" class="card-input-add" id="telefone" runat="server" required>
                  </div>
                  <div class="item_content_card quebra">
                      <label class="subtitulo_card_1 subtitulo_1">Endereço</label>
                      <input type="text" class="card-input-add rua" id="rua" runat="server" required>
                  </div>
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Bairro</label>
                      <input type="text" class="card-input-add bairro" id="bairro" runat="server" required>
                  </div>
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Número</label>
                      <input type="text" class="card-input-add" id="numero" runat="server" required>
                  </div>
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">CEP</label>
                      <input type="text" class="card-input-add cep" id="cep" runat="server" required>
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
                  </script>

                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Complemento</label>
                      <input type="text" class="card-input-add" id="complemento" runat="server" required>
                  </div>
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Cidade</label>
                      <input type="text" class="card-input-add cidade" id="cidade" runat="server" required>
                  </div>
                  <div class="item_content_card">
                      <label class="subtitulo_card_1 subtitulo_1">Estado</label>
                      <input type="text" class="card-input-add uf" id="uf" runat="server" required>
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


   
</asp:Content>
