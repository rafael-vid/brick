//var host = "http://209.133.199.252:5208/api/";
//var rdc = "http://209.133.199.252:5208/api/";
var host = "https://localhost:5001/api/";
var rdc = "https://localhost:5001/api/";
var hostPagamento = "http://pagamento.mostazapago.com.br/";
var seller = "736f57ce-b47c-4598-a2b6-7f5d400318c9";
var codigoCarrinho = "";



function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "; expires=" + date.toGMTString();
    } else var expires = "";

    document.cookie = name + "=" + value + expires + "; path=/";
}


function getCookie(name) {
    let matches = document.cookie.match(new RegExp(
        "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ));
    return matches ? decodeURIComponent(matches[1]) : undefined;
}

function setCookie(name, value, options = {}) {
    options = {
        path: '/',
        // add other defaults here if necessary
        ...options
    };

    if (options.expires instanceof Date) {
        options.expires = options.expires.toUTCString();
    }

    let updatedCookie = encodeURIComponent(name) + "=" + encodeURIComponent(value);

    for (let optionKey in options) {
        updatedCookie += "; " + optionKey;
        let optionValue = options[optionKey];
        if (optionValue !== true) {
            updatedCookie += "=" + optionValue;
        }
    }

    document.cookie = updatedCookie;
}

function deleteCookie(name) {
    setCookie(name, "", {
        'max-age': -1
    })
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function TimeOutLogin() {
    setInterval(function() {
        comum.get("HubProduto/VerificaSessao", null, function(data) {
            if (data.Result == "ERRO") {
                window.location.href = "Login";
            }
        });
    }, 120000);
}

var closeMsg = function(titulo, mensagem, tipo, tempo) {
    var color = "#C46A69";
    if (tempo === null)
        tempo = 1000;
    if (tipo === "S")
        color = "#C46A69";

    $.smallBox({
        title: titulo,
        content: mensagem,
        color: color,
        iconSmall: "fa fa-cloud",
        timeout: tempo
    });
}

function formatarValorSaida(valor) {
    tam = valor.length;
    if (tam <= 2) {
        return valor;
    }
    if ((tam > 2) && (tam <= 6)) {
        return valor.replace(".", ",");
    }
    if ((tam > 6) && (tam <= 9)) {
        return valor.substr(0, tam - 6) + '.' + valor.substr(tam - 6, 3) + ',' + valor.substr(tam - 2, tam);
    }
    if ((tam > 9) && (tam <= 12)) {
        return valor.substr(0, tam - 9) + '.' + valor.substr(tam - 9, 3) + '.' + valor.substr(tam - 6, 3) + ',' + valor.substr(tam - 2, tam);
    }
}

function formatarValorEntrada(valor) {
    if (valor === null)
        valor = 0;

    if (valor !== 0)
        return parseFloat(valor.replace(",", ""))
    else
        return valor

}

function getMoney(el) {
    var money = el.replace(',', '.');
    return parseFloat(money) * 100;
}

function guidGenarator() {
    var d = new Date().getTime();
    var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = (d + Math.random() * 16) % 16 | 0;
        d = Math.floor(d / 16);
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
    return uuid;
}


var comum = {
    SellerID: function() {
        return seller;
    },
    get: function(metodo, objtJson, funcao) {

        jQuery.ajax({
            type: 'GET',
            url: host + metodo,
            data: objtJson,
            async: false,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falhaLista();
            }

        });
    },
    getAsync: function(metodo, objtJson, funcao) {

        jQuery.ajax({
            type: 'GET',
            url: host + metodo,
            data: objtJson,
            async: true,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falhaLista();
            }

        });

    },
    post: function(metodo, objtJson, funcao) {
        jQuery.ajax({
            type: 'POST',
            url: host + metodo,
            data: objtJson,
            async: false,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falha();
            }

        });
    },
    postAsync: function(metodo, objtJson, funcao) {

        jQuery.ajax({
            type: 'POST',
            url: host + metodo,
            data: objtJson,
            async: true,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falha();
            }

        });
    },
    queryString: function(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    },
    msg: function(titulo, msg, tipo, tempo) {

        if (tempo === null)
            tempo = 2000;

        var color = "#C46A69";
        var icone = "fa fa-warning shake animated";

        if (tipo === "S") {
            color = "#739E73";
            icone = "fa fa-check"
        }
    }

}

var comumPagamento = {
    SellerID: function() {
        return seller;
    },
    get: function(metodo, objtJson, funcao) {

        jQuery.ajax({
            type: 'GET',
            url: hostPagamento + metodo,
            data: objtJson,
            async: false,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falhaLista();
            }

        });
    },
    getAsync: function(metodo, objtJson, funcao) {

        jQuery.ajax({
            type: 'GET',
            url: hostPagamento + metodo,
            data: objtJson,
            async: true,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falhaLista();
            }

        });

    },
    post: function(metodo, objtJson, funcao) {
        jQuery.ajax({
            type: 'POST',
            url: hostPagamento + metodo,
            data: objtJson,
            async: false,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falha();
            }

        });
    },
    postAsync: function(metodo, objtJson, funcao) {

        jQuery.ajax({
            type: 'POST',
            url: hostPagamento + metodo,
            data: objtJson,
            async: true,
            success: function(data) {
                funcao(data);
            },
            error: function() {
                falha();
            }

        });
    },
    queryString: function(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    },
    msg: function(titulo, msg, tipo, tempo) {

        if (tempo === null)
            tempo = 2000;

        var color = "#C46A69";
        var icone = "fa fa-warning shake animated";

        if (tipo === "S") {
            color = "#739E73";
            icone = "fa fa-check"
        }
    }

}