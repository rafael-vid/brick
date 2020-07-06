$(document).ready(function() {
    $('.data').mask('11/11/1111');
    $('.hora').mask('00:00:00');
    $('.data_hora').mask('99/99/9999 00:00:00');
    $('.cep').mask('99999-999');
    $('.phone').mask('9999-9999');
    $('.phone_ddd').mask('(99) 9999-9999');
    $('.phone_cel_ddd').mask('(99) 99999-9999');
    $('.peso').mask('#.##0', { reverse: true });
    $('.dinheiro').mask("#.##0,00", { reverse: true });
    $('.cnpj').mask('99.999.999/9999-99');
    $('.cpf').mask('999.999.999-99');

    $('.btn-menu').click(function() {
        $('.menu').removeClass('menuFechado');
        $('.menu').addClass('menuAberto');
        $('body').css('overflow', 'hidden');
    });
    $('.btn-fechar-menu').click(function() {
        $('.menu').removeClass('menuAberto');
        $('.menu').addClass('menuFechado');
        $('body').css('overflow', '');
    });


});