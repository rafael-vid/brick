<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Bsk.Site.Admin._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Loja Julice</title>
    <link rel="icon" type="image/png" href="../img/logo.png" />
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/master.css">
    <meta name="title" content="" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="rating" content="General" />
    <meta name="language" content="portuguese, PT-BR" />
    <meta name="distribution" content="Global" />
    <meta name="revisit-after" content="1 Days" />
    <meta name="author" content="Studio Brasuka - www.studiobrasuka.com.br" />
    <meta name="publisher" content="Studio Brasuka - www.studiobrasuka.com.br" />
    <meta name="copyright" content="Studio Brasuka - www.studiobrasuka.com.br" />
</head>
<body>
    <form id="form1" runat="server">
       <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
    <div class="col col-lg-4 col-md-4 col-lg-offset-4 col-md-offset-4 col-sm-12 col-xs-12 panel panel-default pd-0">
        <div class="panel-heading">
            <h3 class="panel-title">Login</h3>
        </div>
        <div class="panel-body">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <fieldset class="form-group">
                    <label for="username">
                        Entre com seu E-mail:
                    </label>
                    <input type="text" class="form-control form-control-lg" name="login" id="login" runat="server" placeholder="E-mail" required="">
                </fieldset>
                <fieldset class="form-group">
                    <label for="password">
                        Entre com a senha de acesso:
                    </label>
                    <input type="password" name="senha" id="senha" class="form-control form-control-lg pass" runat="server" placeholder="********" required="">
                </fieldset>

                <button class="btn btn-warning btn-block btn-lg" id="btnLogin" runat="server" onserverclick="btnLogin_ServerClick"> Entrar </button>
                <asp:Label ID="msg" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </div>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.mask.js"></script>
    <script src="js/sweetAlert.js"></script>
    <script src="js/wow.js"></script>
    <script src="js/receitaws.js"></script>
    <script src="js/master.js"></script>
    <script src="js/comum.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
   
    </form>
</body>
</html>




