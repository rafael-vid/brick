 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastro.aspx.cs" Inherits="Bsk.Site.Geral.cadastro" %>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="TUDO EM SUAS MÃOS! MANUTENÇÃO RÁPIDA, SEGURA E SEM DOR DE CABEÇA " />
    <meta name="keywords" content="plataforma de contratação, manutenção, serviços, equipamentos" />

    <title>BRIKK - PARA CLIENTES</title>

    <link rel="stylesheet" href="./assets/css/style.css">
    <link rel="stylesheet" href="./assets/css/cadastros.css">


     <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Outros scripts -->


</head>

<body>


    

    <form id="form1" runat="server">
        <header>
            <div class="menu-topo container">
                <a href="index.html">
                    <img src="./assets/imagens/logo.png" alt="BRIKK logomarca" class="logo">
                </a>
                <nav class="menu" id="nav">
                    <button id="btn-mobile">
                        Menu
          <span id="hamburger"></span>
                    </button>
                    <ul class="menu-itens">
                        <li>
                            <a href="sobre.html">sobre nós</a>
                        </li>
                        <li><a href="index.html#parceiros">para parceiros</a></li>
                        <li><a href="index.html#clientes">PARA CLIENTES</a></li>
                        <li><a href="ajuda.html">ajuda</a></li>
                        <li><a href="login.aspx" class="btn-cadastro">ENTRAR / CADASTRAR</a></li>
                    </ul>
                </nav>
            </div>

            <div class="filtro">
                <div class="container" style="display:none">
                    <input type="text" placeholder="Qual serviço você precisa?      ">
                    <img src="./assets/imagens/lupa.png" alt="lupa" class="lupa" style="width: 20px; height: 20px;">
                </div>
            </div>
        </header>
        
        <div class="cadastro container">            
            <div class="controles">
                <label id="paramLabel" style="display: none;" class="titulo">Cadastro de fornecedor</label>
                <label id="paramLabel2" style="display: none;" class="titulo">Cadastro de cliente</label>
                <div>
                    <input class="checar" type="radio" id="pf" checked name="pessoa" value="pf">
                    <label for="pf">Pessoa Física</label>
                </div>
                <div>
                    <input class="checar" type="radio" id="pj" name="pessoa" value="pj">
                    <label for="pj">Pessoa Jurídica</label>
                </div>
            </div>
            <div class="dados-cliente" id="pessoa_fisica">

                <div class="dados-cadastrais">
                    <img src="assets/imagens/dados-icon.svg" alt="dados" style="width: 14px;">
                    <h1 class="subtitulo_1">Dados Cadastrais
                    </h1>
                </div>

                <div class="row campos">
                    <div class="col-md-4">
                        <label for="nome" class="subtitulo_1">Nome*</label>
                        <input type="text" name="nome" id="nome" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="sobrenome" class="subtitulo_1">Sobrenome*</label>
                        <input type="text" name="sobrenome" id="sobrenome" runat="server" required>
                    </div>
                    <div class="col-md-4 queda">
                        <label for="email" class="subtitulo_1">E-mail*</label>
                        <input type="email" name="email" id="email" runat="server" required>
                    </div>
                    <div class="col-md-4 ">
                        <label for="cpf" class="subtitulo_1">CPF*</label>
                        <input type="text" name="cpf" id="cpf" maxlength="14" runat="server" onkeyup="mascaraCPF()"  required>
                    </div>
                    <div class="col-md-4">
                        <label for="telefone" class="subtitulo_1">Telefone*</label>
                        <input type="text" name="telefone" id="telefone" runat="server"  onkeyup="mascaraTel()" required>
                    </div>

                    <div class="col-md-4">
                        <label for="cep" class="subtitulo_1">CEP*</label>
                        <input type="text" name="cep" class="cep" id="cep" onkeyup="mascaraCEP()" maxlength="9"  runat="server" required>
                    </div>
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
                                      <script>
                                          document.querySelector("#cep").onchange = function () {
                                              var txtCep = document.querySelector("#cep").value
                                              if (txtCep && (txtCep.length == 9 || txtCep.length == 8)) {
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
                                                              $("input[name=endereco]").val(json.logradouro);
                                                              $("input[name=bairro]").val(json.bairro);
                                                              $("input[name=cidade]").val(json.localidade);
                                                              $("input[name=estado]").val(json.uf);
                                                              $("input[name=numero]").val('');
                                                              $("input[name=complemento]").val('');
                                                              $("input[name=numero]").focus()
                                                          }
                                                      }
                                                  });
                                              }
                                          }
                                      </script>

                    <div class="col-md-4">
                        <label for="endereco" class="subtitulo_1">Rua*</label>
                        <input type="text" name="endereco" id="endereco" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="bairro" class="subtitulo_1">Bairro*</label>
                        <input type="text" name="bairro" id="bairro" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="numero" class="subtitulo_1">Número*</label>
                        <input type="number" name="numero" id="numero" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="complemento" class="subtitulo_1">Complemento</label>
                        <input type="text" name="complemento" id="complemento" runat="server" >
                    </div>
                    <div class="col-md-4">
                        <label for="cidade" class="subtitulo_1">Cidade*</label>
                        <input type="text" name="cidade" id="cidade" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="estado" class="subtitulo_1">Estado*</label>
                        <input type="text" name="estado" id="estado" runat="server" required>
                    </div>

                     <div class="col-md-4">
                         
                        <label for="senha" class="subtitulo_1">Senha*</label>
                         
                        <input type="password" name="senha" id="senha" runat="server" required>
                         <img id="olho1" class="olho" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABDUlEQVQ4jd2SvW3DMBBGbwQVKlyo4BGC4FKFS4+TATKCNxAggkeoSpHSRQbwAB7AA7hQoUKFLH6E2qQQHfgHdpo0yQHX8T3exyPR/ytlQ8kOhgV7FvSx9+xglA3lM3DBgh0LPn/onbJhcQ0bv2SHlgVgQa/suFHVkCg7bm5gzB2OyvjlDFdDcoa19etZMN8Qp7oUDPEM2KFV1ZAQO2zPMBERO7Ra4JQNpRa4K4FDS0R0IdneCbQLb4/zh/c7QdH4NL40tPXrovFpjHQr6PJ6yr5hQV80PiUiIm1OKxZ0LICS8TWvpyyOf2DBQQtcXk8Zi3+JcKfNafVsjZ0WfGgJlZZQxZjdwzX+ykf6u/UF0Fwo5Apfcq8AAAAASUVORK5CYII="
/>
                    </div>
                    <script>
                        var senha = $('#senha');
                        var olho = $("#olho1");

                        olho.mousedown(function () {
                            senha.attr("type", "text");
                        });

                        olho.mouseup(function () {
                            senha.attr("type", "password");
                        });
                        // para evitar o problema de arrastar a imagem e a senha continuar exposta, 
                        //citada pelo nosso amigo nos comentários
                        $("#olho1").mouseout(function () {
                            $("#senha").attr("type", "password");
                        });
                    </script>
                     <div class="col-md-4">
                        <label for="validaSenha" class="subtitulo_1">Confirmar senha*</label>
                        <input type="password" name="validaSenha" id="validaSenha" runat="server" required>
                         <img id="olho2" class="olho" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABDUlEQVQ4jd2SvW3DMBBGbwQVKlyo4BGC4FKFS4+TATKCNxAggkeoSpHSRQbwAB7AA7hQoUKFLH6E2qQQHfgHdpo0yQHX8T3exyPR/ytlQ8kOhgV7FvSx9+xglA3lM3DBgh0LPn/onbJhcQ0bv2SHlgVgQa/suFHVkCg7bm5gzB2OyvjlDFdDcoa19etZMN8Qp7oUDPEM2KFV1ZAQO2zPMBERO7Ra4JQNpRa4K4FDS0R0IdneCbQLb4/zh/c7QdH4NL40tPXrovFpjHQr6PJ6yr5hQV80PiUiIm1OKxZ0LICS8TWvpyyOf2DBQQtcXk8Zi3+JcKfNafVsjZ0WfGgJlZZQxZjdwzX+ykf6u/UF0Fwo5Apfcq8AAAAASUVORK5CYII="
/>
                    </div>
                    <script>
                        var senha2 = $('#validaSenha');
                        var olho2 = $("#olho2");

                        olho2.mousedown(function () {
                            senha2.attr("type", "text");
                        });

                        olho2.mouseup(function () {
                            senha2.attr("type", "password");
                        });
                        // para evitar o problema de arrastar a imagem e a senha continuar exposta, 
                        //citada pelo nosso amigo nos comentários
                        $("#olho2").mouseout(function () {
                            $("#validaSenha").attr("type", "password");
                        });
                    </script>
                </div>
                <div style="clear:both; margin-top:15px"></div>
                <div class="volt ar-chat" style="clear:both;    margin-top: 40px;">
                    <div class="subtitulo_contato" style="float:left;margin-left:25px">
                        <a href="login.aspx" class="voltar btn"><< voltar</a>
                    </div>
                        

                    <div class="subtitulo_contato" style="float:right">
                        <button runat="server" id="btnFisica" onserverclick="btnFisica_ServerClick" class="cadastro btn">salvar</button>
                    </div>

                </div>
            </div>

            <div class="dados-cliente" id="pessoa_juridica">

                <div class="dados-cadastrais">
                    <img src="assets/imagens/dados-icon.svg" alt="dados" style="width: 14px;">
                    <h1 class="subtitulo_1">Dados Cadastrais
                    </h1>
                </div>

                <script>
                    $('#pj').change(function () {
                        $('#campos_empresa').show()
                    })
                </script>

                <style>
                    .campos {
                        display:block !important;
                    }
                </style>

                <div class="campos" id ="campos_empresa">
                    <div class="col-md-4">
                        <label for="nomeJuridica" class="subtitulo_1">Nome*</label>
                        <input type="text" name="nomeJuridica" id="nomeJuridica" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="sobrenomeJuridica" class="subtitulo_1">Sobrenome*</label>
                        <input type="text" name="sobrenomeJuridica" id="sobrenomeJuridica" runat="server" required>
                    </div>
                    <div class="col-md-4 queda">
                        <label for="emailJuridica" class="subtitulo_1">E-mail*</label>
                        <input type="email" name="emailJuridica" id="emailJuridica" runat="server" required>
                    </div>
                    <div class="col-md-4 queda">
                        <label for="cnpj"  class="subtitulo_1">CNPJ*</label>
                        <input type="text" name="cnpj" id="cnpj" runat="server" maxlength="18" onkeyup="mascaraCNPJ()" required>
                    </div>
                    <div class="col-md-4 queda">
                        <label for="razao" class="subtitulo_1">Razão Social*</label>
                        <input type="text" name="razao" id="razao" runat="server" required>
                    </div>
                    <div class="col-md-4 queda">
                        <label for="fantasia" class="subtitulo_1">Nome Fantasia*</label>
                        <input type="text" name="fantasia" id="fantasia" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="situacao" class="subtitulo_1">Situação*</label>
                        <input type="text" name="situacao" id="situacao" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="abertura" class="subtitulo_1">Data de Abertura*</label>
                        <input type="date" name="abertura" id="abertura" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="matriz" class="subtitulo_1">Matriz*</label>
                        <input type="text" name="matriz" id="matriz" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="telefoneJuridica" class="subtitulo_1">Telefone*</label>
                        <input type="tel" name="telefoneJuridica"  id="telefoneJuridica"  onkeyup="mascaraTel()"  runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="bairroJuridica" class="subtitulo_1">Bairro*</label>
                        <input type="text" name="bairroJuridica" id="bairroJuridica" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="numeroJuridica" class="subtitulo_1">Número*</label>
                        <input type="number" name="numeroJuridica" id="numeroJuridica" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="cepJuridica" class="subtitulo_1">CEP*</label>
                        <input type="text" name="cepJuridica" id="cepJuridica" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="complementoJuridica" class="subtitulo_1">Complemento</label>
                        <input type="text" name="complementoJuridica" id="complementoJuridica" runat="server" >
                    </div>
                    <div class="col-md-4">
                        <label for="cidadeJuridica" class="subtitulo_1">Cidade*</label>
                        <input type="text" name="cidadeJuridica" id="cidadeJuridica" runat="server" required>
                    </div>
                    <div class="col-md-4">
                        <label for="estadoJuridica" class="subtitulo_1">Estado*</label>
                        <input type="text" name="estadoJuridica" id="estadoJuridica" runat="server" required>
                    </div>
                     <div class="col-md-4">
                        <label for="senhaJuridica" class="subtitulo_1">Senha*</label>
                        <input type="password" name="senhaJuridica" id="senhaJuridica" runat="server" required>
                        <img id="olho3" class="olho" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABDUlEQVQ4jd2SvW3DMBBGbwQVKlyo4BGC4FKFS4+TATKCNxAggkeoSpHSRQbwAB7AA7hQoUKFLH6E2qQQHfgHdpo0yQHX8T3exyPR/ytlQ8kOhgV7FvSx9+xglA3lM3DBgh0LPn/onbJhcQ0bv2SHlgVgQa/suFHVkCg7bm5gzB2OyvjlDFdDcoa19etZMN8Qp7oUDPEM2KFV1ZAQO2zPMBERO7Ra4JQNpRa4K4FDS0R0IdneCbQLb4/zh/c7QdH4NL40tPXrovFpjHQr6PJ6yr5hQV80PiUiIm1OKxZ0LICS8TWvpyyOf2DBQQtcXk8Zi3+JcKfNafVsjZ0WfGgJlZZQxZjdwzX+ykf6u/UF0Fwo5Apfcq8AAAAASUVORK5CYII="
/>
                    </div>
                    <script>
                        var senha3 = $('#senhaJuridica');
                        var olho3 = $("#olho3");

                        olho3.mousedown(function () {
                            senha3.attr("type", "text");
                        });

                        olho3.mouseup(function () {
                            senha3.attr("type", "password");
                        });
                        // para evitar o problema de arrastar a imagem e a senha continuar exposta, 
                        //citada pelo nosso amigo nos comentários
                        $("#olho3").mouseout(function () {
                            $("#senhaJuridica").attr("type", "password");
                        });
                    </script>
                     <div class="col-md-4">
                        <label for="validaSenhaJuridica" class="subtitulo_1">Confirmar senha*</label>
                        <input type="password" name="validaSenhaJuridica" id="validaSenhaJuridica" runat="server" required>
                         <img id="olho4" class="olho" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABDUlEQVQ4jd2SvW3DMBBGbwQVKlyo4BGC4FKFS4+TATKCNxAggkeoSpHSRQbwAB7AA7hQoUKFLH6E2qQQHfgHdpo0yQHX8T3exyPR/ytlQ8kOhgV7FvSx9+xglA3lM3DBgh0LPn/onbJhcQ0bv2SHlgVgQa/suFHVkCg7bm5gzB2OyvjlDFdDcoa19etZMN8Qp7oUDPEM2KFV1ZAQO2zPMBERO7Ra4JQNpRa4K4FDS0R0IdneCbQLb4/zh/c7QdH4NL40tPXrovFpjHQr6PJ6yr5hQV80PiUiIm1OKxZ0LICS8TWvpyyOf2DBQQtcXk8Zi3+JcKfNafVsjZ0WfGgJlZZQxZjdwzX+ykf6u/UF0Fwo5Apfcq8AAAAASUVORK5CYII="
/>
                    </div>
                    <script>
                        var senha4 = $('#validaSenhaJuridica');
                        var olho4 = $("#olho4");

                        olho4.mousedown(function () {
                            senha4.attr("type", "text");
                        });

                        olho4.mouseup(function () {
                            senha4.attr("type", "password");
                        });
                        // para evitar o problema de arrastar a imagem e a senha continuar exposta, 
                        //citada pelo nosso amigo nos comentários
                        $("#olho4").mouseout(function () {
                            $("#validaSenhaJuridica").attr("type", "password");
                        });
                </script>
                </div>
                <div style="clear:both"></div>
                <div class="vol tar-chat">
                    <div class="subtitulo_contato" style="float:left; margin-left:25px">
                        <a href="login.aspx" class="voltar btn"><< voltar</a>
                    </div>
                        

                    <div class="subtitulo_contato" style="float:right">
                        <button runat="server" id="btnJuridica" onserverclick="btnJuridica_ServerClick" class="cadastro btn">salvar</button>
                    </div>


                </div>
            </div>
        </div>
        <div class="minhaclasse2"
                    <asp:Label ID="msg" runat="server" Text=""></asp:Label>
        </div>
        <!-- footer -->
        <footer>
            <a href="/">
                <img src="./assets/imagens/logo-footer.png" alt="logomarca" style="width: 152px;"></a>
            <div>
                <a href="#">
                    <img src="./assets/imagens/facebook.png" alt="facebook " style="width: 42px;">
                </a>
                <a href="#">
                    <img src="./assets/imagens/instagram.png" alt="instagram" style="width: 42px;"></a>
                <a href="#">
                    <img src="./assets/imagens/whatsapp.png" alt="whatsapp" style="width: 42px;"></a>
            </div>
        </footer>
    </form>

    <style>
        .cadastro.btn{
            border:none;
            text-align:center;
            padding-left:0;
            cursor:pointer
        }
    </style>
    <script async src="assets/js/script.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <script>
        AOS.init();
    </script>

    <script> 


        $("#pessoa_fisica").show();
        $("#pessoa_juridica").hide();

        $("#pf").change(function () {
            $("#pessoa_fisica").show();
            $("#pessoa_juridica").hide();
        });

        $("#pj").change(function () {
            $("#pessoa_fisica").hide();
            $("#pessoa_juridica").show();
        });
        

        function validatePhone(phone) {
            var regex = new RegExp('^((1[1-9])|([2-9][0-9]))((3[0-9]{3}[0-9]{4})|(9[0-9]{3}[0-9]{5}))$');
            return regex.test(phone);
        }

        function mascaraCPF() {
            const cpf = document.getElementById('cpf')

          

            if (cpf.value.length == 3 || cpf.value.length == 7) {
                cpf.value += '.'
            } else if (cpf.value.length == 11) {
                cpf.value += '-'
            }
        }

        function mascaraCNPJ() {
            const cnpj = document.getElementById('cnpj')
            if (cnpj.value.length == 2 || cnpj.value.length == 5) {
                cnpj.value += '.'
            } else if (cpf.value.length == 8) {
                cpf.value += '/'
            } else if (cpf.value.length == 12) {
                cpf.value += '-'
            }
        }

        function mascaraCEP() {
            const cep = document.getElementById('cep')
            if (cep.value.length == 5) {
                cep.value += '-'
            }
        }

        function validarSenha(s, s2) {
            const senha = document.getElementById(s)
            const senha2 = document.getElementById(s2)

            senha2.addEventListener('blur', validar)

            function validar() {
                if (senha.value != senha2.value) {
                    alert('As senhas não são iguais')
                }
            }
        } validarSenha('senha', 'validaSenha'); validarSenha('senhaJuridica', 'validaSenhaJuridica')

    </script>
    <script>
        // Função para verificar se um parâmetro na URL tem um valor específico
        function checkURLParameter(parameter, value) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.has(parameter) && urlParams.get(parameter) === value;
        }

        // Verificar se o parâmetro 'Tipo' tem o valor 'for'
        if (checkURLParameter('Tipo', 'for')) {
            // Se estiver presente, mostrar a label
            document.getElementById('paramLabel').style.display = 'block';
        }
        if (checkURLParameter('Tipo', 'cli')) {
            document.getElementById('paramLabel2').style.display = 'block';
        }
    </script>

</body>

</html>