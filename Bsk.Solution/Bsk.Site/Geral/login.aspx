<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Bsk.Site.Geral.login" %>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="TUDO EM SUAS MÃOS! MANUTENÇÃO RÁPIDA, SEGURA E SEM DOR DE CABEÇA " />
    <meta name="keywords" content="plataforma de contratação, manutenção, serviços, equipamentos" />

    <title>BRIKK - LOGIN</title>
    <link rel="stylesheet" href="./assets/css/style.css">
    <link rel="stylesheet" href="./assets/css/tabsmenu.css">
    <!--
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    -->
        <style>
        .tab-content.ativo  {
            display: flex;
            flex-direction: column;
        }
        .tab-content  input {
            width: 100%;
            height: 60px;
            background: #770e18;
            border: none;
            outline: none;
            margin: 17px 0;
            font-size: 24px;
            color: #f4f3f2;
            font-family: Rajdhani;
            padding: 18px 32px;
            border-radius: 30px;
            transition: 0.3s ease;
        }
        .tab-content   .acessos {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <!-- header -->
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
        <main class="loginCadastro">
            <div class="tabs-menu container">
                <nav>
                    <a href="#" class="tab ativo">
                        <img src="./assets/imagens/dados-icon.svg" alt="ícone usuário" style="width: 20px;">
                        <span>Sou Cliente</span>
                    </a>
                    <a href="#" class="tab">
                        <img src="./assets/imagens/dados-icon.svg" alt="ícone usuário" style="width: 20px;">
                        <span>Sou Parceiro</span>
                    </a>
                </nav>

                <div class="tab-content ativo">
                    <h2>Para clientes</h2>

                    <form>
                        <input type="text" name="usuario" runat="server" id="usuarioCliente" placeholder="Usuário" required>
                        <input type="password" name="senha" runat="server" id="senhaCliente" placeholder="Senha" required>
                        <asp:Label ID="lblMsg" runat="server"></asp:Label>
                    </form>

                    <div class="acessos">
                        <div>
                            <a href="#" class="esqueceusenha">Esqueci a senha</a>
                            <a href="cadastro.aspx?Tipo=cli" class="naotemacesso">Não tenho cadastro</a>
                            
                        </div>
                        <button id="btnCliente" runat="server" onserverclick="btnCliente_ServerClick" class="btn">Entrar</button>
                    </div>

                </div>

                <div class="tab-content ">
                    <h2>Para parceiros</h2>

                    <div>
                        <input type="text" name="usuario" id="usuarioParceiro" runat="server" placeholder="Usuário" required>
                        <input type="password" name="senha" id="senhaParceiro" runat="server" placeholder="Senha" required>
                        <asp:Label ID="lblMsgParceiro" runat="server"></asp:Label>
                    </div>

                    <div class="acessos">
                        <div>
                            <a href="#" class="esqueceusenha">Esqueci a senha</a>
                            <a href="cadastro.aspx?Tipo=for" class="naotemacesso">Não tenho cadastro</a>
                            
                        </div> 
                        <button runat="server" id="btnParceiroEntrar" onserverclick="btnParceiroEntrar_ServerClick" class="btn">Entrar</button>
                    </div>


                </div>

            </div>

        </main>

         <asp:Label ID="msg" runat="server" Text=""></asp:Label>
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

        <style>
            .tab.ativo {
                box-shadow:  3px 6px 10px rgba(119, 14, 24, 0.5);
                transition:ease .5s
            }
        </style>

        
        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

        <script>
            AOS.init();
        </script>

        <script async src="assets/js/script.js"></script>

        <script>
            function tabs() {
                const tabMenu = document.querySelectorAll('.tab')
                const tabContent = document.querySelectorAll('.tab-content')

                function activeTab(index) {
                    tabContent.forEach(content => {
                        content.classList.remove('ativo')
                    })
                    tabContent[index].classList.add('ativo')
                }

                tabMenu.forEach((item, index) => {
                    item.addEventListener('click', () => {
                        activeTab(index)
                        index.classList.toggle('ativo')
                    })
                })

            } tabs()

            //menu active
            function menuActive() {
                const links = document.querySelectorAll('.tab')

                const handleLink = (event) => {
                    links.forEach(link => {
                        link.classList.remove('ativo')
                    })
                    event.currentTarget.classList.add('ativo')
                }

                links.forEach(link => {
                    link.addEventListener('click', handleLink)
                })
            }
            menuActive();
            
        </script>
    </form>
</body>
</html>
