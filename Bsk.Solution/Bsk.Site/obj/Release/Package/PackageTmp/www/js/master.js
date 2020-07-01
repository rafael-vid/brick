$(document).ready(function() {
    $('.btn-envia').click(function() {
        window.location.href = 'index.html';
    });
    $('.btn-cadastro').click(function() {
        window.location.href = 'cadastro.html';
    });
    $('.btn-acessa').click(function() {
        window.location.href = 'pagar-com-fiadito.html';
    });
    $('.btn-acesso').click(function() {
        window.location.href = 'codigo-convite.html';
    });
    $('.btn-fiadito').click(function() {
        window.location.href = 'qrcode.html';
    });
    $('.btn-extrato').click(function() {
        window.location.href = 'extrato.html';
    });
    $('.btn-menu').click(function() {
        $('.menu').slideToggle();
        $('.fundo-menu').slideToggle();
    });
    $('.btn-login').click(function () {
        window.location.href = 'login.html';
    });
});