<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastro.aspx.cs" Inherits="Bsk.Site.Fornecedor.cadastro" %>

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
    <script src="js/comum.js"></script>


</head>
<body>
    <form id="form1" runat="server">
        <!-- Header site -->
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 header-site">
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <img src="img/logo.png" class="img-responsive logo" alt="BRIKK">
            </div>
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12 text-center">
            </div>
        </div>
        <!-- Login site -->
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 cadstro-site pd-0">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 mobile-pd-0">
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mobile-pd-0">
                        <p id="mensagens"></p>
                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                                <input type="text" class="form-control cnpj" id="cnpj" placeholder="CNPJ">
                            </div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>


                            <div id="enderecoEmpresaPessoFisica">
                            </div>


                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                                <input type="text" class="form-control" id="nomeResponsavel" placeholder="Nome Responsável" required>
                            </div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                                <input type="text" class="form-control" id="sobrenomeResponsavel" placeholder="Sobrenome Responsável" required>
                            </div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                                <input type="text" class="form-control" id="email" placeholder="E-mail" required>
                            </div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <input type="text" class="form-control " id="whatsapp" placeholder="Whatsapp">
                            </div>
                             <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <input type="text" class="form-control cpf" id="cpfResponsavel" placeholder="CPF responsável">
                            </div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 dadosResponsavel">
                                <input type="password" class="form-control" id="senha" placeholder="Senha" required />
                            </div>
                            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 dadosResponsavel">
                                <input type="password" class="form-control" id="confirmaSenha" placeholder="Confirmar Senha" required />
                            </div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <button type="button" class="btn pull-right btn-salvar btn-brikk">Salvar</button>
                            </div>
                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <input type="hidden" id='fantasia' />
                            </div>
                        </div>
                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
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
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
        <script src="js/wow.js"></script>
        <script src="js/master.js"></script>
        <script>

            $(document).ready(function () {
                $('.btn-salvar').attr('disabled', true);

                if ($('input#escolheCnpj').is(':checked')) {
                    $('input.cnpj').show();
                    $('input.cpf').hide();
                    $('#nomeResponsavel').attr('placeholder', 'Nome Responsável');
                    $('#whatsapp').attr('placeholder', 'Whatsapp');

                }
                if ($('input#escolheCpf').is(':checked')) {
                    $('input.cnpj').hide();
                    $('input.cpf').show();
                    $('#nomeResponsavel').attr('placeholder', 'Nome Completo');
                    $('#whatsapp').attr('placeholder', 'Telefone');
                }
                $('input[type="radio"]').click(function () {
                    if ($('input#escolheCnpj').is(':checked')) {
                        $('input.cnpj').show();
                        $('input.cpf').hide();
                        $('#nomeResponsavel').attr('placeholder', 'Nome Responsável');
                        $('#whatsapp').attr('placeholder', 'Whatsapp');
                    }
                    if ($('input#escolheCpf').is(':checked')) {
                        $('input.cnpj').hide();
                        $('input.cpf').show();
                        $('#nomeResponsavel').attr('placeholder', 'Nome Completo');
                        $('#whatsapp').attr('placeholder', 'Telefone');
                    }
                });

                $('.btn-comprar').click(function () {
                    $('.btn-escolha').fadeOut();
                    $('.form-cad').fadeIn();
                    $('span.quemSou').html('Farmácia');
                    if ($('input#cnpj').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#nomeResponsavel').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#email').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#senha').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#confirmaSenha').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                });
                $('.btn-vender').click(function () {
                    $('.btn-escolha').fadeOut();
                    $('.form-cad').fadeIn();
                    $('span.quemSou').html('Fornecedor');
                    if ($('input#cnpj').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#nomeResponsavel').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#email').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#senha').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                    if ($('input#confirmaSenha').val() == '') {
                        $('.btn-salvar').attr('disabled', true);
                    }
                });

                // busca CNPJ
                (function ($) {
                    $.fn.receitaws = function (options) {
                        $this = this;

                        $.fn.receitaws.options = {
                            afterRequest: function () { },
                            success: function (data) { },
                            notfound: function (message) { },
                            fail: function (message) { },
                            fields: {},
                            urlRequest: 'https://receitaws.com.br/v1/cnpj/'
                        };

                        /*
                         Duplicate request controller. (Cache)
                         */
                        $.fn.receitaws.lastRequest = {
                            cnpj: null,
                            data: null
                        };


                        function getData(cnpj) {
                            cnpj = cnpj.replace(/\D/g, '');

                            var lastRequest = $.fn.receitaws.lastRequest;

                            return new Promise(function (success, fail) {
                                if (lastRequest.cnpj == cnpj) {
                                    success(lastRequest.dados);
                                } else {
                                    var myObject = {
                                        async: false,
                                        dataType: 'json'
                                    };

                                    $.getJSON($.fn.receitaws.options.urlRequest + cnpj + '?callback=?', function (data) {
                                        lastRequest.cnpj = cnpj;
                                        lastRequest.dados = data;
                                        success(data);
                                    })

                                        .fail(function (jqxhr, textStatus, error) {
                                            fail(textStatus + ", " + error);
                                        });
                                }
                            });
                        }


                        $.fn.receitaws.init = function (options) {

                            $.fn.receitaws.options = $.extend({}, $.fn.receitaws.options, options);

                            return $this.keyup(function () {
                                var cnpj = $(this).val().replace(/\D/g, '');

                                if (cnpj.length != 14) {
                                    return false;
                                }
                                options.afterRequest();

                                getData(cnpj).then(function (data) {

                                    if (data.status == 'OK') {
                                        $.each(options.fields, function (index, value) {
                                            if (typeof value == "string") {
                                                $(options.fields[index]).val(data[index]);
                                            } else if (typeof value == 'function') {
                                                value(data[index]);
                                            }
                                        });

                                        options.success(data);
                                    } else {
                                        options.notfound('CNPJ "' + $this.val() + '" não encontrado.');
                                    }

                                }, function (error) {
                                    options.fail(error);
                                });
                            });
                        };

                        return $.fn.receitaws.init(options);
                    };
                })(jQuery);

                $('#cnpj').receitaws({
                    fields: {
                        nome: '#nome',
                        situacao: '#situacao',
                        abertura: '#abertura',
                        tipo: '#tipo',
                        telefone: '#telefone',
                        logradouro: '#logradouro',
                        cep: '#cep',
                        numero: '#numero',
                        complemento: '#complemento',
                        bairro: '#bairro',
                        municipio: '#municipio',
                        uf: '#uf',
                        fantasia: '#fantasia'
                    },

                    afterRequest: function () {
                        $('#mensagens').html('<div class="alert alert-info" role="alert"><div class="glyphicon glyphicon-search" aria-hidden="true"></div> Buscando CNPJ</div>');
                    },
                    success: function (data) {
                        $('#mensagens').html('<div class="alert alert-success" role="alert"><div class="glyphicon glyphicon-ok" aria-hidden="true"></div> CNPJ encontrado</div>');

                        $('#enderecoEmpresaPessoFisica').html('<div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0 dadosRetira dadosEmpresa" style="display: none;"><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12"><input type="text" class="form-control razaoSocial" id="nome" placeholder="Razão Social" value="' + data.nome + '" disabled></div><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12"><input type="text" class="form-control fantasia" id="fantasia" placeholder="Nome Fantasia" value="' + data.fantasia + '" disabled></div><div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">                               <input type="text" class="form-control situacao" id="situacao" placeholder="Situação" value="' + data.situacao + '" disabled>                            </div> <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                           <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">                                <input type="text" class="form-control dataAbertura" id="abertura" value="' + data.abertura + '" placeholder="Data de abertura" disabled>                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">                               <input type="text" class="form-control tipo" id="tipo" value="' + data.tipo + '" placeholder="Tipo" disabled>                            </div>      <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                      <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">                                <input type="text" class="form-control" id="telefone" value="' + data.telefone + '" placeholder="Telefone">                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 ">                                <input type="text" class="form-control logradouro" value="' + data.logradouro + '" id="logradouro" placeholder="Endereço" disabled>                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 ">                                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control" id="cep" value="' + data.cep + '" placeholder="CEP" disabled>                                </div>    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control numero" id="numero" value="' + data.numero + '" placeholder="Número" disabled>                                </div> <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                               <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdr-0">                                    <input type="text" class="form-control complemento" id="complemento" value="' + data.complemento + '" placeholder="Complemento" disabled>                                </div>                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 ">                                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control bairro" id="bairro" value="' + data.bairro + '" placeholder="Bairro" disabled>                                </div>  <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                              <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control cidade" id="municipio" value="' + data.municipio + '" placeholder="Cidade" disabled>                                </div>  <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                              <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdr-0">                                    <input type="text" class="form-control uf" id="uf" value="' + data.uf + '" placeholder="UF" disabled>                                </div>                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                        </div>');
                        //Dados obtidos
                        var nome = data.qsa[0].nome;
                        var nm = nome.split(' ');
                        var snome = nm[nm.length - 1];
                        $("#nomeResponsavel").val(nome.replace(snome,''));
                        $("#sobrenomeResponsavel").val(snome);
                       
                        console.log(data);
                    },
                    fail: function (message) {
                        $('#mensagens').html('<div class="alert alert-danger" role="alert"><div class="glyphicon glyphicon-remove-sign" aria-hidden="true"></div> Falha na requisição</div>');
                    },
                    notfound: function (message) {
                        $('#mensagens').html('<div class="alert alert-danger" role="alert"><div class="glyphicon glyphicon-remove-sign" aria-hidden="true"></div> CNPJ não encontrado ou inválido</div>');
                    }
                });

                $("input#cnpj").focusout(function () {
                    if ($('input#cnpj').val() == '') {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input#cnpj').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo é obrigatório</div>');
                        $('input#cnpj').focus();
                    }
                    if ($('input#cnpj').val().length != 18) {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input#cnpj').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo tem que ter no mínimo 14 números</div>');
                        $('input#cnpj').focus();
                    } else {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('.dadosEmpresa').slideToggle();
                        $('.dadosRetira').removeClass('dadosEmpresa');
                    }
                });

                $("input.cpf").focusout(function () {
                    if ($('input.cpf').val() == '') {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input.cpf').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo é obrigatório</div>');
                        $('input.cpf').focus();
                    }
                    if ($('input.cpf').val().length != 14) {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input.cpf').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo tem que ter no mínimo 11 números</div>');
                        $('input.cpf').focus();
                    } else {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('#enderecoEmpresaPessoFisica').html('<div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0 dadosRetira dadosPessoFisica" style="display: none;">                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 ">                                <input type="text" class="form-control logradouro" id="logradouro" placeholder="Endereço">                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 ">                                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control cep" id="cep" placeholder="CEP">                                </div>      <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control numero" id="numero" placeholder="Número">                                </div>         <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                         <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdr-0">                                    <input type="text" class="form-control complemento" id="complemento" placeholder="Complemento">                                </div>                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 ">                                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control bairro" id="bairro" placeholder="Bairro">                                </div>  <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                                <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdl-0">                                    <input type="text" class="form-control cidade" id="municipio" placeholder="Cidade">                                </div>       <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>                           <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 pdr-0">                                    <input type="text" class="form-control uf" id="uf" placeholder="UF">                                </div>                            </div>                            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>                        </div>');
                        $('.dadosPessoFisica').slideToggle();
                        $('.cep').focus();
                    };

                    $(".cep").focusout(function () {
                        var cep = $('input.cep').val().replace(/\D/g, '');
                        if (cep != "") {
                            var validacep = /^[0-9]{8}$/;
                            if (validacep.test(cep)) {

                                $("#logradouro").val("...");
                                $("#bairro").val("...");
                                $("#municipio").val("...");
                                $("#uf").val("...");
                                $.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?", function (dados) {

                                    if (!("erro" in dados)) {
                                        $("#logradouro").val(dados.logradouro);
                                        $("#bairro").val(dados.bairro);
                                        $("#municipio").val(dados.localidade);
                                        $("#uf").val(dados.uf);
                                    } else {
                                        limpa_formulário_cep();
                                        Swal.fire(
                                            'Ooops!',
                                            'Não encontramos este CEP.',
                                            'error'
                                        )
                                    }
                                });
                            } else {
                                Swal.fire(
                                    'Ooops!',
                                    'Esta não é o formato de CEP esperado.',
                                    'error'
                                )
                            }
                        }
                    });

                });

                $('input#nomeResponsavel').focusout(function () {
                    if ($('input#nomeResponsavel').val() == '') {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input#nomeResponsavel').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo é obrigatório</div>');
                        $('input#nomeResponsavel').focus();
                    } else {
                        $('.dadosResponsavel').find('.mensagem').remove();
                    }
                });
                $('input#email').focusout(function () {
                    if ($('input#email').val() == '') {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input#email').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo é obrigatório</div>');
                        $('input#email').focus();
                    } else {
                        var emailFilter = /^.+@.+\..{2,}$/;
                        var illegalChars = /[\(\)\<\>\,\;\:\\\/\"\[\]]/;
                        if (!(emailFilter.test($('input#email').val())) || $('input#email').val().match(illegalChars)) {
                            $('.dadosResponsavel').find('.mensagem').remove();
                            $('input#email').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Por favor, informe um email válido.</div>');
                            $('input#email').val('');
                            $('input#email').focus();
                        } else {
                            $('.dadosResponsavel').find('.mensagem').remove();
                        }
                    }
                });
                $('input#senha').focusout(function () {
                    if ($('input#senha').val() == '') {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input#senha').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo é obrigatório</div>');
                        $('input#senha').focus();
                    } else {
                        $('.dadosResponsavel').find('.mensagem').remove();
                    }
                });
                $('input#confirmaSenha').focusout(function () {
                    if ($('input#confirmaSenha').val() == '') {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        $('input#confirmaSenha').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Este campo é obrigatório</div>');
                        $('input#confirmaSenha').focus();
                    } else {
                        $('.dadosResponsavel').find('.mensagem').remove();
                        if ($('input#senha').val() != $('input#confirmaSenha').val()) {
                            $('input#confirmaSenha').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Os campos não são iguais, por favor colocar a mesma senha nos dois</div>');
                            $('input#senha').parent().append('<div class="mensagem" style="color: #b8272c; font-weight: bold;">Os campos não são iguais, por favor colocar a mesma senha nos dois</div>');
                            $('input#confirmaSenha').val('');
                            $('input#senha').val('');
                            $('input#senha').focus();
                        }
                        $('.btn-salvar').attr('disabled', false);
                    }
                });

                $('.btn-salvar').click(function () {

                    var parametro = {
                        Cpf: $('input#cpf').val(),
                        Cnpj: $('input#cnpj').val(),
                        RazaoSocial: $('input#nome').val(),
                        Situacao: $('input#situacao').val(),
                        Abertura: $('input#abertura').val(),
                        Tipo: $('input#tipo').val(),
                        Telefone: $('input#telefone').val(),
                        Logradouro: $('input#logradouro').val(),
                        Cep: $('input#cep').val(),
                        Numero: $('input#numero').val(),
                        Complemento: $('input#complemento').val(),
                        Bairro: $('input#bairro').val(),
                        Municipio: $('input#municipio').val(),
                        Uf: $('input#uf').val(),
                        Responsavel: $('input#nomeResponsavel').val(),
                        Whatsapp: $('input#whatsapp').val(),
                        Senha: $('input#senha').val(),
                        Email: $('input#email').val(),
                        NomeFantasia: $('input#fantasia').val(),
                        SobreNome: $("#sobrenomeResponsavel").val(),
                        CpfResponsavel: $("#cpfResponsavel").val()
                    }

                    comum.post("Fornecedor/CadastroFornecedor", parametro, function (data) {
                        if (data.Msg == "Ok") {
                            Swal.fire("Cadastro efetuado com sucesso! Você será redirecionado...");
                            setTimeout(function () { window.location.href = host + "/Fornecedor/default.aspx"; }, 5000);
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Oops...',
                                text: data.Msg
                            });
                        }

                    });



                });
            });
        </script>
    </form>
</body>
</html>
