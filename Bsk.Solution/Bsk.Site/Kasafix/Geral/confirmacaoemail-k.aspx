<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="confirmacaoemail-k.aspx.cs" Inherits="Bsk.Site.Kasafix.Geral.confirmacaoemailkasafix" %>



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
            border-radius: 0px 50px 50px 50px;
            background-color: #f4f3f2;
        }
        .filtro {
            height: 93px;
            background: url(../imagens/fundo.png) ;
            background-size: auto !important;
            width: 100%;
        }
        .centered-label {
        position: absolute; /* Or 'fixed' depending on your requirement */
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 80%; /* Adjust width as needed */
        text-align: center;
        background-color: #770e18; /* Deep red background */
        color: #ffffff; /* White text color for contrast */
        padding: 20px;
        border-radius: 15px; /* Rounded corners */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
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
            <div class="centered-label">
                <asp:Label ID="Label" runat="server" Text=""></asp:Label>
            </div>



        </main>

<asp:Label ID="mensagem" runat="server" Text=""></asp:Label>
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
    <script>

</script>
</body>
</html>