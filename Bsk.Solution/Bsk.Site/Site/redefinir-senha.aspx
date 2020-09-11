<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="redefinir-senha.aspx.cs" Inherits="Bsk.Site.Site.redefinir_senha" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>BRIKK</title>
    <link rel="icon" type="image/png" href="../img/favico.png" />
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/default.css" />
    <link rel="stylesheet" href="../css/animate.css" />
    <link rel="stylesheet" href="../css/datatables.min.css" />
    <link rel="stylesheet" href="../css/master.css" />
    <link rel="stylesheet" href="../css/mobile.css" />


    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Outros scripts -->

    <script src="js/jquery.mask.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>
    <script src="js/rating.js"></script>
    <script src="js/wow.js"></script>
    <script src="js/master.js"></script>
    <script src="js/comum.js"></script>
</head>
<body>
    <form id="form1" runat="server" style="height: 100%;">
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 header-site">
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <img src="img/logo.png" class="img-responsive logo" alt="BRIKK" />
            </div>
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12 text-center">
            </div>
        </div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 login-site pd-0" style="height: 100%!important; position: absolute; left: 0; top: -20px;">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                    <div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>
                    </div>

                    <div id="msg" runat="server">
                    </div>
                    <div id="campos" runat="server">
                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <label>Informe a nova senha</label>
                            <input type="password" class="form-control" id="senha1" runat="server" />
                        </div>

                        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">&nbsp;</div>

                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                            <label>Confirme a senha</label>
                            <input type="password" class="form-control" id="senha2" runat="server" /><br />
                            <button type="button" class="btn btn-brikk loga l100" id="btnAltera" runat="server" onserverclick="btnAltera_ServerClick">Salvar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            if (comum.queryString("Acao") != null) {
                var acao = comum.queryString("Acao");
                if (acao == "Expirado") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Link expirado ou já usado...'
                    }).then((result) => {
                        window.location.href = host;
                    });
                } else if (acao == "Campos") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'Preencha todos os campos'
                    });
                } else if (acao == "Diferentes") {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: 'As senhas não conferem'
                    });
                } else if (acao == "Certo") {
                    Swal.fire({
                        icon: 'success',
                        title: 'Sucesso',
                        text: 'Senha alterada com sucesso.'
                    }).then((result) => {
                        window.location.href = host;
                    });;
                }
            }
        </script>
    </form>
</body>
</html>
