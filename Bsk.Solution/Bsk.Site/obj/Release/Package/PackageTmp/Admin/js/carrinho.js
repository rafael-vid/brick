$(document).on('click', '.btn-remove', function() {
    debugger;
    var parametro = {
        IdCarrinho: $(this).attr('data-IdCarrinho')
    };

    comum.post("Carrinho/DeletarCarrinho", parametro, function(data) {});
    CarregaCarrinho();
});

$(document).on('click', '.carrinhoQtd', function() {
    debugger;
    var parametro = {
        IdCarrinho: $(this).attr('data-IdCarrinho'),
        Qtd: $(this).val()
    };
    comum.post("Carrinho/AtualizarQtdCarrinho", parametro, function(data) {});

    CarregaCarrinho();
});

function CarregaCarrinho() {

    if (getCookie('Carrinho') != undefined) {
        codigoCarrinho = getCookie('Carrinho');
    } else {
        codigoCarrinho = guidGenarator();
        createCookie("Carrinho", codigoCarrinho, 60);
    }

    var html = "";
    var parametro = {
        SellerID: comum.SellerID,
        CodigoCarrinho: codigoCarrinho
    };

    $('.produtosAdicionados').empty();
    var ValorTotalCarrinho = 0;

    comum.get("Carrinho/ConsultaProdutoCarrinho", parametro, function(data) {

        $.each(data, function(i, item) {
            debugger;
            ValorTotalCarrinho += item.ValorTotal;
            html += '<div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 prodCarrinho"><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 title-carrinho">    <h3>' + item.Titulo + '</h3></div><div class="col col-lg-3 col-md-3 col-sm-3 col-xs-3 img-carrinho"><img src="RepositoryImg/' + item.ImagemPrincipal + '" width="100" style="margin:10px;" ></div><div class="col col-lg-9 col-md-9 col-sm-9 col-xs-9 desc-val-carrinho"><p class="desc-carrinho text-justify">' + item.Descricao + '</p><p class="valor text-right">R$<span class="val-carrinho">' + parseFloat(item.ValorTotal).toFixed(2) + '</span></p></div><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 qntCarrinho"><div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 btn btn-default text-right">Quantidade:</div><div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12"><input type="number" class="form-control carrinhoQtd" value="' + item.Qtd + '" data-IdCarrinho="' + item.IdCarrinho + '"></div></div><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div><div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 qntCarrinho" ><button class="btn btn-lg btn-danger pull-right btn-remove" data-IdCarrinho="' + item.IdCarrinho + '">Remover</button></div></div>';
        });

    });
    $('.produtosAdicionados').append(html);
    return ValorTotalCarrinho;
}

$(document).on('click', '.carrinho', function() {
    debugger;
    $('.fundoCarrinho').fadeIn();
    $('.carrinhoFechado').toggleClass('carrinhoAberto');
    CarregaCarrinho();
});

$(document).on('click', '.fundoCarrinho', function() {
    $('.fundoCarrinho').fadeOut();
    $('.carrinhoFechado').toggleClass('carrinhoAberto');
});
$(document).on('click', '.btn-continuar', function() {
    $('.fundoCarrinho').fadeOut();
    $('.carrinhoFechado').toggleClass('carrinhoAberto');
});