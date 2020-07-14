<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="avaliar.aspx.cs" Inherits="Bsk.Site.Cliente.avaliar" %>

<!DOCTYPE html>
<html lang="">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>BRIKK</title>
    <link rel="icon" type="image/png" href="img/favico.png" />
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" integrity="sha256-3dkvEK0WLHRJ7/Csr0BZjAWxERc5WH7bdeUya2aXxdU= sha512-+L4yy6FRcDGbXJ9mPG8MT/3UCDzwR9gPeyFNMCtInsol++5m3bk2bXWKdZjvybmohrAsn3Ua5x8gfLnbE1YkOg==" crossorigin="anonymous">
    <link rel="stylesheet" href="css/default.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/datatables.min.css" />
    <link rel="stylesheet" href="css/master.css">
    <link rel="stylesheet" href="css/mobile.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.3/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
</head>

<body>
    <!-- Header site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 header-site">
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
        <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
            <img src="img/logo.png" class="img-responsive logo" alt="BRIKK">
        </div>
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12 text-center">
            <a href="" class="pull-right link-brikk hidden-sm hidden-xs mr-20"><%
                                                                                   var usuario = RetornaUsuario();
                                                                                   Response.Write(usuario.Nome);
            %></a>
            <a href="" class="text-center link-brikk hidden-lg hidden-md">Olá Amiguinho</a>
            <i class="glyphicon glyphicon-menu-hamburger btn-menu pull-right" title="MENU"></i>
        </div>

    </div>
    <!-- Corpo Site -->
    <form id="form1" runat="server">
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
            <%var cot = PegaCotacao(); %>
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
            <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
                <h2 class="tableTitle">
                    <p>Prestador de Serviço:</p>
                    <br>
                    <%Response.Write(cot.NomeFornecedor); %>
                </h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                    <h3>Título da prestação de serviço: <%Response.Write(cot.Titulo); %></h3>
                </div>

                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 boxDesc">
                    <%Response.Write(cot.Descricao); %>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                    <span id="rating-1" data-star='0'></span>
                </div>

                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0">
                    <textarea name="" id="depoimento" class="form-control" cols="30" runat="server" rows="10"></textarea><br>
                    <button class="btn btn-brikk btn-lg center-block" runat="server" id="btnDepoimento" onserverclick="btnDepoimento_ServerClick">Enviar Depoimento</button>
                </div>
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 valorServico">
                    <h2>
                        <strong>
                            <p>Valor do serviço:</p>
                            <br>
                            R$<%Response.Write(cot.Valor); %>
                        </strong>
                    </h2>
                </div>
            </div>

            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        </div>
    </form>

    <!-- Menu -->
    <div class="menu menuFechado">
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
            <i class="glyphicon glyphicon-remove btn-fechar-menu pull-right" title="FECHAR MENU"></i>
            <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Menu<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
            <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12">
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="minhas-cotacoes.aspx">
                        <img src="img/listaCotacao.jpg" class="img-responsive listaCotacao" width="100%" alt=""></a>
                </div>
                <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="cadastro-cotacao.aspx">
                        <img src="img/novaCotacao.jpg" class="img-responsive" width="100%" alt=""></a>
                </div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="em-andamento.aspx">
                        <img src="img/semImagem.jpg" class="img-responsive" width="100%" alt=""></a>
                </div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="liberar-pagamento.aspx">
                        <img src="img/liberaPagamento.jpg" class="img-responsive liberaPagamento" width="100%" alt=""></a>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="finalizado.aspx">
                        <img src="img/semImagem.jpg" class="img-responsive finalizado" width="100%" alt=""></a>
                </div>


                <%--<div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <img src="img/perfil.jpg" class="img-responsive cadastrar" width="100%" alt="">
                </div>--%>
            </div>
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        </div>
    </div>
    <!-- Fim Menu -->

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Outros scripts -->
    <script src="js/jquery.mask.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="js/wow.js"></script>
    <script src="js/rating.js"></script>
    <script src="js/master.js"></script>
    <script src="js/comum.js"></script>
    <script>

        setTimeout(function () {
            $("#rating-1").data('stars').val("2");
            alert(document.getElementById("hdNota").value);
        }, 1000);

        $(document).ready(function () {
            $('#tabela').DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json"
                }
            });

            $.ratePicker("#rating-1", {
                max: 5,
                rgbOn: "#e74c3c",
                rgbSelection: "#e74c3c",
                cursor: "pointer",
                rate: function (stars) {
                    var parametros = {
                        nota: stars,
                        id: comum.queryString("Id")
                    };

                    comum.postAsync("Comum/NotaCotacao", parametros, function (data) {
                    });
                }
            });

            $('.liberarPagamento').click(function () {
                swal({
                    title: "Tem certeza que podemos liberar o pagamento?",
                    text: "Após o aceite a quantia acordada será liberada para o prestador de serviço!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                    .then((willDelete) => {
                        if (willDelete) {
                            swal("Pagamento liberado com sucesso!", {
                                icon: "success",
                            });
                        } else {
                            swal("Ok, vamos aguardar mais um pouco para liberar o pagamento!");
                        }
                    });
            });

        });
    </script>
</body>

</html>
