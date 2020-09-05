<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Bsk.Site.Fornecedor._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>BRIKK</title>
    <link rel="icon" type="image/png" href="img/favico.png" />
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/default.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/master.css">
    <link rel="stylesheet" href="css/mobile.css">
</head>
<body>
    <form id="form1" runat="server" style="height: 100%;">
        <!-- Header site -->
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 header-site">
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <img src="img/logo.png" class="img-responsive logo" alt="BRIKK" />
            </div>
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12 text-center">
            </div>
        </div>
        <!-- Login site -->
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 login-site pd-0" style="height: 100%!important; position: absolute; left: 0; top: -20px;">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right mobile-center-txt">
                        <a href="cadastro.aspx" class="link-brikk cadastrar">Não tenho cadastro</a>
                    </div>
                    <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right mobile-center-txt">
                        <a onclick="redefinirSenha()" class="link-brikk cadastrar">Esqueci a senha</a>
                    </div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <input type="text" class="form-control" placeholder="E-mail" clientidmode="static" runat="server" id="login" />
                    </div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <input type="password" class="form-control" placeholder="Senha" runat="server" id="senha" />
                    </div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 mobile-pd-0 mobile-center-txt">
                            <asp:Label ID="msg" runat="server" Text=""></asp:Label>
                            <%--<a href="" class="link-brikk">Esqueci minha senha</a>--%>
                        </div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                        <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">
                            <button class="btn btn-brikk loga l100" runat="server" id="btnEntrar" onserverclick="btnEntrar_ServerClick">Entrar</button>
                        </div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                        <img src="img/loading.gif" style="display:none;" id="loadGif" />
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <!-- Bootstrap JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!-- Outros scripts -->
        <script src="js/jquery.mask.js"></script>
        <script src="js/datatables.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
        <script src="js/wow.js"></script>
        <script src="js/master.js"></script>
        <script src="js/comum.js"></script>
        <script>
            function redefinirSenha() {

                if ($("#login").val() == "") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Dados incompletos.',
                        text: 'Por favor, preencha o email cadastrado!'
                    });
                } else {
                    $("#loadGif").show();
                    var parametro = {
                        tipo: "F",
                        email: $("#login").val()
                    };
                    comum.postAsync("Comum/RecuperaSenha", parametro, function (data) {
                        if (data.Result == "Ok") {
                            Swal.fire({
                                icon: 'success',
                                title: 'Sucesso.',
                                text: 'Um link pra redefinição de senha foi enviado no seu email. Caso não encontre, procure na caixa de spam.'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Erro',
                                text: data.Result
                            });
                        }
                        $("#loadGif").hide();

                    });

                }

            }
        </script>


    </form>


</body>
</html>
