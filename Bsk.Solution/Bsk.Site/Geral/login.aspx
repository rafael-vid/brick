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
        .tab.ativo {
            box-shadow: none !important;
            transition: ease .5s;
            z-index: 99;
        }
        .tab-content.ativo {
            display: block;
            padding: 31px 46px 77px 48px;
            box-shadow: 0px 4px 14px rgba(0, 0, 0, 0.4) !important;
            border-radius: 50px 50px 50px 50px;
            background-color: #f4f3f2;
        }
        .filtro {
            height: 93px;
            background: url(../imagens/fundo.png) ;
            background-size: auto !important;
            width: 100%;
        }
        .cookie-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        @keyframes slideUp {
            from {
                transform: translateY(100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .cookie-consent {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            padding: 85px;
            z-index: 1000;
            animation: slideUp 0.5s ease-out; /* Aplica a animação de deslizamento */
        }

    </style>
</head>

<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <!-- header -->
        <header>

            <div class="menu-topo container">
                <a href="index.html">
                    <img src="./assets/imagens/logo.png" alt="BRIKK logomarca" class="logo">
                </a>
                
            </div>

            <div class="filtro">
    <div class="container" style="display:none">
        <input type="text" id="catSelBusca" placeholder="Qual serviço você precisa?      ">
        <img src="../assets/imagens/lupa.png" alt="lupa" class="lupa" style="width: 20px; height: 20px;" onclick="buscaCats();">
    </div>
</div>
        </header>
        <main class="loginCadastro">
            <div class="tabs-menu container">

                <div class="tab-content ativo">

                    <form>
                        <input type="text" name="usuario" runat="server" id="usuarioCliente" placeholder="Email" required>
                        <input type="password" name="senha" runat="server" id="senhaCliente" placeholder="Senha" required>
                        <div style="display: flex; align-items: center;">
                            <asp:Label ID="lblMsg" runat="server" style="color:darkred; font-size:32px; margin-right: 10px;"></asp:Label>
                            <button id="btnMensagem" runat="server" onserverclick="btnReenviar_ServerClick" class="btn" style="visibility: hidden; border: none;">
                                Reenviar email
                            </button>
                        </div>

                    </form>

                    <div class="acessos">
                        <div>
                            <a href="esqueciasenha.aspx?tipo=cli" class="esqueceusenha">Esqueci a senha</a>
                            <a href="cadastro.aspx?Tipo=cli" class="naotemacesso">Não tenho cadastro</a>
                            
                        </div>
                        <button id="btnCliente" runat="server" onserverclick="btnCliente_ServerClick" class="btn">Entrar</button>
                    </div>

                </div>
       
            </div>

        </main>

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



        
        <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
        <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

        <script>
            AOS.init();
        </script>

        <script async src="assets/js/script.js"></script>

        
    </form>
    <div class="cookie-backdrop" id="cookieBackdrop" style="display:none;"></div>

    <div class="cookie-consent" id="cookieConsent" style="text-align:justify; font-size:18px; display:none;">

Este site utiliza cookies estritamente necessários para garantir o funcionamento adequado e seguro de nossos serviços. Esses cookies são essenciais para habilitar a navegação e utilização das funcionalidades do site.

Não utilizamos cookies para coletar informações pessoais.

Ao continuar a usar nosso site, você entende e concorda com o uso desses cookies essenciais. Para mais informações, consulte nossa <a href="#" style="color: deepskyblue;">Política de Privacidade</a>.
        <button class="btn" onclick="closeCookieConsent()" style="position: absolute; right: 20px; bottom: 20px;">OK</button>
    </div>
    <script>
        // Função para acionar o evento de clique do botão "Entrar" para clientes quando a tecla Enter for pressionada
        document.addEventListener("DOMContentLoaded", function () {
            document.getElementById("senhaCliente").addEventListener("keypress", function (event) {
                if (event.key === "Enter") {
                    document.getElementById("<%= btnCliente.ClientID %>").click(); // Simula o clique no botão de cliente
            }
        });
    });

</script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Verifica se o alerta de cookies já foi fechado
            if (!localStorage.getItem('cookieConsentClosed')) {
                document.getElementById('cookieConsent').style.display = 'block';
                document.getElementById('cookieBackdrop').style.display = 'block';
            }
        });

        function closeCookieConsent() {
            // Oculta o alerta de cookies
            document.getElementById('cookieConsent').style.display = 'none';
            document.getElementById('cookieBackdrop').style.display = 'none';
            // Salva a informação de que o alerta foi fechado
            localStorage.setItem('cookieConsentClosed', 'true');
        }

    </script>
</body>
</html>
l>
