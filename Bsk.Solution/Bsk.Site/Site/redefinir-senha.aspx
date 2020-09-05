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
    <form id="form1" runat="server">
        <div>
            <div id="msg" runat="server">

            </div>
            <div id="campos" runat="server">
                <label>Informe a nova senha</label>
                <input type="password" id="senha1" runat="server" /><br />
                <label>Confirme a senha</label>
                <input type="password" id="senha2" runat="server" /><br />
                <button type="button" id="btnAltera" runat="server" onserverclick="btnAltera_ServerClick">Salvar</button>
            </div>
        </div>
        <script>
            if (comum.queryString("Acao")!=null) {
                var acao = comum.queryString("Acao");
                if (acao=="Expirado") {
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
