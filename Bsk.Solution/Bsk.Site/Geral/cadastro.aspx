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
                <div class="container">
                    <input type="text" placeholder="Qual serviço você precisa?      ">
                    <img src="./assets/imagens/lupa.png" alt="lupa" class="lupa" style="width: 20px; height: 20px;">
                </div>
            </div>
        </header>

        <div class="cadastro container">
            <div class="controles">
                <div>
                    <input class="checar" type="radio" id="pf" checked name="pessoa" value="pf">
                    <label for="pf">Pessoa Física</label>
                </div>
                <div>
                    <input class="checar" type="radio" id="pj" name="pessoa" value="pj">
                    <label for="pj">Pessoa Jurídica</label>
                </div>
            </div>
            <div class="dados-cliente ativo" id="pessoa_fisica">

                <div class="dados-cadastrais">
                    <img src="assets/imagens/dados-icon.svg" alt="dados" style="width: 14px;">
                    <h1 class="subtitulo_1">Dados Cadastrais
                    </h1>
                </div>

                <div class="campos">
                    <div>
                        <label for="nome" class="subtitulo_1">Nome</label>
                        <input type="text" name="nome" id="nome" runat="server" required>
                    </div>
                    <div>
                        <label for="sobrenome" class="subtitulo_1">Sobrenome</label>
                        <input type="text" name="sobrenome" id="sobrenome" runat="server" required>
                    </div>
                    <div class="queda">
                        <label for="email" class="subtitulo_1">E-mail</label>
                        <input type="email" name="email" id="email" runat="server" required>
                    </div>
                    <div>
                        <label for="cpf" class="subtitulo_1">CPF</label>
                        <input type="text" name="cpf" id="cpf" runat="server" required>
                    </div>
                    <div>
                        <label for="telefone" class="subtitulo_1">Telefone</label>
                        <input type="text" name="telefone" id="telefone" runat="server" required>
                    </div>
                    <div class="queda">
                        <label for="endereco" class="subtitulo_1">Endereço</label>
                        <input type="text" name="endereco" id="endereco" runat="server" required>
                    </div>
                    <div>
                        <label for="bairro" class="subtitulo_1">Bairro</label>
                        <input type="text" name="bairro" id="bairro" runat="server" required>
                    </div>
                    <div>
                        <label for="numero" class="subtitulo_1">Número</label>
                        <input type="number" name="numero" id="numero" runat="server" required>
                    </div>
                    <div>
                        <label for="cep" class="subtitulo_1">CEP</label>
                        <input type="number" name="cep" id="cep" runat="server" required>
                    </div>
                    <div>
                        <label for="complemento" class="subtitulo_1">Complemento</label>
                        <input type="text" name="complemento" id="complemento" runat="server" required>
                    </div>
                    <div>
                        <label for="cidade" class="subtitulo_1">Cidade</label>
                        <input type="text" name="cidade" id="cidade" runat="server" required>
                    </div>
                    <div>
                        <label for="estado" class="subtitulo_1">Estado</label>
                        <input type="text" name="estado" id="estado" runat="server" required>
                    </div>
                     <div>
                        <label for="senha" class="subtitulo_1">Senha</label>
                        <input type="text" name="senha" id="senha" runat="server" required>
                    </div>
                     <div>
                        <label for="validaSenha" class="subtitulo_1">Confirmar senha</label>
                        <input type="text" name="validaSenha" id="validaSenha" runat="server" required>
                    </div>
                </div>

                <div class="voltar-chat">
                    <a href="login.aspx" class="voltar btn"><< voltar</a>

                        

                    <div class="subtitulo_contato">
                        <button runat="server" id="btnFisica" onserverclick="btnFisica_ServerClick" class="cadastro btn">salvar</button>
                    </div>

                    <div class="subtitulo_contato">
                        <img src="assets/imagens/chat-icon.png" style="width: 50px;" alt="ícone contato">
                        <span class="notificacao">01</span>
                     </div>
                </div>
            </div>

            <div class="dados-cliente" id="pessoa_juridica">

                <div class="dados-cadastrais">
                    <img src="assets/imagens/dados-icon.svg" alt="dados" style="width: 14px;">
                    <h1 class="subtitulo_1">Dados Cadastrais
                    </h1>
                </div>

                <div class="campos">
                    <div>
                        <label for="nomeJuridica" class="subtitulo_1">Nome</label>
                        <input type="text" name="nomeJuridica" id="nomeJuridica" runat="server" required>
                    </div>
                    <div>
                        <label for="sobrenomeJuridica" class="subtitulo_1">Sobrenome</label>
                        <input type="text" name="sobrenomeJuridica" id="sobrenomeJuridica" runat="server" required>
                    </div>
                    <div class="queda">
                        <label for="emailJuridica" class="subtitulo_1">E-mail</label>
                        <input type="email" name="emailJuridica" id="emailJuridica" runat="server" required>
                    </div>
                    <div class="queda">
                        <label for="cnpj" class="subtitulo_1">CNPJ</label>
                        <input type="text" name="cnpj" id="cnpj" runat="server" required>
                    </div>
                    <div class="queda">
                        <label for="razao" class="subtitulo_1">Razão Social</label>
                        <input type="text" name="razao" id="razao" runat="server" required>
                    </div>
                    <div class="queda">
                        <label for="fantasia" class="subtitulo_1">Nome Fantasia</label>
                        <input type="text" name="fantasia" id="fantasia" runat="server" required>
                    </div>
                    <div>
                        <label for="situacao" class="subtitulo_1">Situação</label>
                        <input type="text" name="situacao" id="situacao" runat="server" required>
                    </div>
                    <div>
                        <label for="abertura" class="subtitulo_1">Data de Abertura</label>
                        <input type="date" name="abertura" id="abertura" runat="server" required>
                    </div>
                    <div>
                        <label for="matriz" class="subtitulo_1">Matriz</label>
                        <input type="text" name="matriz" id="matriz" runat="server" required>
                    </div>
                    <div>
                        <label for="telefoneJuridica" class="subtitulo_1">Telefone</label>
                        <input type="tel" name="telefoneJuridica" id="telefoneJuridica"  runat="server" required>
                    </div>
                    <div>
                        <label for="bairroJuridica" class="subtitulo_1">Bairro</label>
                        <input type="text" name="bairroJuridica" id="bairroJuridica" runat="server" required>
                    </div>
                    <div>
                        <label for="numeroJuridica" class="subtitulo_1">Número</label>
                        <input type="number" name="numeroJuridica" id="numeroJuridica" runat="server" required>
                    </div>
                    <div>
                        <label for="cepJuridica" class="subtitulo_1">CEP</label>
                        <input type="text" name="cepJuridica" id="cepJuridica" runat="server" required>
                    </div>
                    <div>
                        <label for="complementoJuridica" class="subtitulo_1">Complemento</label>
                        <input type="text" name="complementoJuridica" id="complementoJuridica" runat="server" required>
                    </div>
                    <div>
                        <label for="cidadeJuridica" class="subtitulo_1">Cidade</label>
                        <input type="text" name="cidadeJuridica" id="cidadeJuridica" runat="server" required>
                    </div>
                    <div>
                        <label for="estadoJuridica" class="subtitulo_1">Estado</label>
                        <input type="text" name="estadoJuridica" id="estadoJuridica" runat="server" required>
                    </div>
                     <div>
                        <label for="senhaJuridica" class="subtitulo_1">Senha</label>
                        <input type="password" name="senhaJuridica" id="senhaJuridica" runat="server" required>
                    </div>
                     <div>
                        <label for="validaSenhaJuridica" class="subtitulo_1">Confirmar senha</label>
                        <input type="password" name="validaSenhaJuridica" id="validaSenhaJuridica" runat="server" required>
                    </div>
                </div>

                <div class="voltar-chat">
                    <a href="login.aspx" class="voltar btn"><< voltar</a>

                        

                    <div class="subtitulo_contato">
                        <button runat="server" id="btnJuridica" onserverclick="btnJuridica_ServerClick" class="cadastro btn">salvar</button>
                    </div>

                    <div class="subtitulo_contato">
                        <img src="assets/imagens/chat-icon.png" style="width: 50px;" alt="ícone contato">
                        <span class="notificacao">01</span>
                     </div>
                </div>
            </div>
        </div>
         <asp:Label ID="msg" runat="server" Text=""></asp:Label>
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
        function validarCpf(cpf) {
            const cpf = document.getElementById(cpf)

            if (typeof cpf !== 'string') return false
            cpf = cpf.replace(/[^\d]+/g, '')
            if (cpf.length !== 11 || !!cpf.match(/(\d)\1{10}/)) return false
            cpf = cpf.split('')
            const validator = cpf
                .filter((digit, index, array) => index >= array.length - 2 && digit)
                .map(el => +el)
            const toValidate = pop => cpf
                .filter((digit, index, array) => index < array.length - pop && digit)
                .map(el => +el)
            const rest = (count, pop) => (toValidate(pop)
                .reduce((soma, el, i) => soma + el * (count - i), 0) * 10) % 11 % 10
            return !(rest(10, 2) !== validator[0] || rest(11, 1) !== validator[1])

        } validarCpf('cpf')

        function validarCNPJ(cnpj) {
            const cpf = document.getElementById('cpf')

            cnpj = cnpj.replace(/[^\d]+/g, '');

            if (cnpj == '') return false;

            if (cnpj.length != 14)
                return false;

         
            if (cnpj == "00000000000000" ||
                cnpj == "11111111111111" ||
                cnpj == "22222222222222" ||
                cnpj == "33333333333333" ||
                cnpj == "44444444444444" ||
                cnpj == "55555555555555" ||
                cnpj == "66666666666666" ||
                cnpj == "77777777777777" ||
                cnpj == "88888888888888" ||
                cnpj == "99999999999999")
                return false;

            tamanho = cnpj.length - 2
            numeros = cnpj.substring(0, tamanho);
            digitos = cnpj.substring(tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                return false;

            tamanho = tamanho + 1;
            numeros = cnpj.substring(0, tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                return false;

            return true;

        } validarCNPJ('cnpj')

        function validarTelefone(telefone) {
            const telefone = document.getElementById(telefone)

            const brazilianPhoneRegex = /^\(\d{2}\) \d{4,5}-\d{4}$/gi;
            return brazilianPhoneRegex.test(telefone);
        } validarTelefone('telefoneJuridica'); validarTelefone('telefone')

        function validacaoEmail(email) {
            const email = document.getElementById(emailJuridica)
            usuario = email.value.substring(0, email.value.indexOf("@"));
            dominio = email.value.substring(email.value.indexOf("@") + 1, email.value.length);

            if ((usuario.length >= 1) &&
                (dominio.length >= 3) &&
                (usuario.search("@") == -1) &&
                (dominio.search("@") == -1) &&
                (usuario.search(" ") == -1) &&
                (dominio.search(" ") == -1) &&
                (dominio.search(".") != -1) &&
                (dominio.indexOf(".") >= 1) &&
                (dominio.lastIndexOf(".") < dominio.length - 1)) {
                document.getElementById("msgemail").innerHTML = "E-mail válido";
                alert("E-mail valido");
            }
            else {
                document.getElementById("msgemail").innerHTML = "<font color='red'>E-mail inválido </font>";
                alert("E-mail invalido");
            } validacaoEmail('emailJuridica'); validacaoEmail('email')
        }

        function validarSenha(senha, confirmacao) {
            var password = document.getElementById(senha)
                , confirm_password = document.getElementById(confirmacao);

            function validar() {
                if (password.value != confirm_password.value) {
                    confirm_password.setCustomValidity("as senhas estão diferentes!");
                } else {
                    confirm_password.setCustomValidity('');
                }
            }

            password.addEventListener('onChange', validar)
            confirm_password.addEventListener('onkeyup', validar)
        } validarSenha('senhaJuridica', 'validaSenhaJuridica')
    </script>


</body>

</html>
