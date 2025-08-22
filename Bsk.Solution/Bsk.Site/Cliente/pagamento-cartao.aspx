<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento-cartao.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento_cartao" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <%-- All content is rendered inside the MasterPage’s single <form runat="server"> --%>
    <div class="conteudo-dash cotacao cotacoes-cli">

        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Nova Solicitações
            </a>
            <a class="btn_card" href="minhas-cotacoes.aspx">Minhas Solicitações</a>
            <a class="btn_card" href="aguardando-pagamento.aspx">Pagamentos</a>
        </div>

        <div class="acessos-small">
            <div class="row">
                <div class="dropdown">
                    <a class="btn_card btn_nova_solicitacao" href="buscar-servico.aspx" style="margin-top: 10px;">
                        <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Nova Solicitações
                    </a>
                    <button type="button" class="btn_card dropdown-toggle" onclick="toggleDropdown()" style="margin-top: 10px; justify-content: right; background: white; filter: brightness(100%); box-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3); border: none; cursor: pointer; appearance: none; -webkit-appearance: none; -moz-appearance: none;">
                        <i class="fas fa-ellipsis-v" style="font-size: 16px;"></i>
                    </button>
                    <div class="dropdown-menu" id="dropdownMenu" style="display: none;">
                        <a class="dropdown-item" href="minhas-cotacoes.aspx">Minhas Solicitações</a>
                        <a class="dropdown-item" href="aguardando-pagamento.aspx">Pagamentos</a>
                    </div>
                </div>
            </div>
            <div class="row"></div>
        </div>

        <div class="card boleto">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotações/ Cod.<span id="nrcotacao" runat="server"></span> Pagamento Cartão</h2>
            </div>
            <div class="titulo_card" style="margin-top: 30px;">
                <h2 class="subtitulo_1">Confira seus Dados Cadastrais</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Nome Completo</h2>
                <p id="nome" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">E-mail</h2>
                <p id="email" runat="server"></p>
            </div>

            <div class="card-cl2">
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">CPF</h2>
                    <p id="cpf" runat="server"></p>
                </div>
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Telefone</h2>
                    <p id="telefone" runat="server"></p>
                </div>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Endereço</h2>
                <p id="rua" runat="server"></p>
            </div>

            <div class="grupo-pg-boleto">
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Bairro</h2>
                    <p id="bairro" runat="server"></p>
                </div>
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Número</h2>
                    <p id="numero" runat="server"></p>
                </div>
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">CEP</h2>
                    <p id="cep" runat="server"></p>
                </div>
            </div>

            <div class="grupo-pg-boleto">
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Complemento</h2>
                    <p id="complemento" runat="server"></p>
                </div>
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Cidade</h2>
                    <p id="cidade" runat="server"></p>
                </div>
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Estado</h2>
                    <p id="uf" runat="server"></p>
                </div>
            </div>

            <button id="btnAlterar" runat="server" onserverclick="btnAlterar_ServerClick" class="btn_card btn_alterar_dados" style="width: 140px; margin-top: 30px;">Alterar Dados</button>

            <div class="item_content_card">
                <div class="titulo_card">
                    <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                    <h2 class="subtitulo_1">Dados do Cartão</h2>
                </div>
            </div>

            <!-- Pagar.me tokenization fields -->
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Nome do Cartão</h2>
                <input type="text" name="holder-name" data-pagarmecheckout-element="holder_name" id="nomeCartao" class="card-input-add" />
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Número do Cartão</h2>
                <input type="text" name="card-number" data-pagarmecheckout-element="number" id="numeroCartao" class="card-input-add" oninput="mascaraCartao(this)" />
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Mês</h2>
                <input type="text" name="card-exp-month" data-pagarmecheckout-element="exp_month" id="mes" class="card-input-add" />
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Ano</h2>
                <input type="text" name="card-exp-year" data-pagarmecheckout-element="exp_year" id="ano" class="card-input-add" />
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">CVV</h2>
                <input type="text" name="cvv" data-pagarmecheckout-element="cvv" id="codigo" class="card-input-add" />
            </div>
            <button type="submit" class="btn_card">Pagar</button>

            <div class="item_content_card card_boleto_valor">
                <span class="valor_" id="valor" runat="server"></span>
                <div id="divCartao" runat="server">
                    <button class="btn_card" id="btnNovoCartão" onclick="deletarCartao(); return false;">Deletar Cartão</button>
                </div>
                <button class="btn_card" id="btnPagamento" runat="server" onserverclick="btnPagamento_ServerClick">Finalizar Pagamento</button>
                <label id="lbMsg" runat="server" style="color: red;"></label>
            </div>

            <div class="footer_card" style="margin-top: 36px;">
                <a class="voltar btn" href="aguardando-pagamento.aspx">&lt;&lt; voltar</a>
            </div>
        </div>

        <!-- Pagar.me Script and Initialization -->
        <script src="https://checkout.pagar.me/v1/tokenizecard.js" data-pagarmecheckout-app-id="pk_test_yYrwmmuREFL5w3X8"></script>
        <script>
            // Called before the form actually submits
            function success(data) {
                console.log('Token gerado (pre-reload):', data);
                // store the entire response
                sessionStorage.setItem('pagarmeResponse', JSON.stringify(data));
                return true;  // allow the form to submit
            }

            function fail(error) {
                console.error('Erro ao gerar token:', error);
            }

            PagarmeCheckout.init(success, fail);

            // On every page load, read back and log (if present)
            document.addEventListener('DOMContentLoaded', function () {
                const stored = sessionStorage.getItem('pagarmeResponse');
                if (stored) {
                    const data = JSON.parse(stored);
                    console.log('Token gerado (after reload):', data);
                    // — or render it somewhere on the page, e.g.:
                    // document.getElementById('someElement').innerText = data.pagarmetoken;
                }
            });
</script>

        <!-- Existing utility scripts and styles -->
        <script>
            function mascaraCartao(input) {
                let valor = input.value.replace(/\D/g, '');
                valor = valor.replace(/(\d{4})(?=\d)/g, '$1 ');
                input.value = valor;
            }
            function deletarCartao() {
                Swal.fire({
                    toast: true,
                    title: 'Deletar?',
                    text: "Você tem certeza que gostaria de deletar esse cartão?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Deletar!'
                }).then((result) => {
                    if (result.value) {
                        window.location.href = "pagamento-cartao.aspx?Id=" + comum.queryString("Id") + "&Deleta=1";
                    }
                });
            }
            function toggleDropdown() {
                var menu = document.getElementById("dropdownMenu");
                menu.style.display = (menu.style.display === "none" || menu.style.display === "") ? "block" : "none";
            }
            window.onclick = function (event) {
                if (!event.target.matches('.dropdown-toggle')) {
                    var dropdowns = document.getElementsByClassName("dropdown-menu");
                    for (var i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.style.display === 'block') {
                            openDropdown.style.display = 'none';
                        }
                    }
                }
            };
            function updateVisibility() {
                if (window.innerWidth < 768) {
                    document.querySelector('.acessos').style.display = 'none';
                    document.querySelector('.acessos-small').style.display = 'flex';
                } else {
                    document.querySelector('.acessos').style.display = 'flex';
                    document.querySelector('.acessos-small').style.display = 'none';
                }
            }
            updateVisibility();
            window.addEventListener('resize', updateVisibility);
        </script>

        <style>
            a.cotacao { background: #f4f3f2; color: #770e18 !important; }
            .swal-wide { font-size: 1.2em; }
            .swal-title { font-size: 1.5em; }
            .swal-text { font-size: 1.2em; }
            @media (max-width: 768px) {
                .conteudo-dash { padding: 0 !important; min-height: 0 !important; }
                .btn_nova_solicitacao { margin-top: 5px; }
                .btn_card { font-size: 14px; width: 44% !important; margin-bottom: 15px; min-width: 170px; }
                .card { padding: 15px !important; }
                .card-cl2 { display: flex; flex-direction: column; }
                .grupo-pg-boleto { display: flex; flex-direction: column; }
                .dropdown-menu { position: absolute; background-color: white; border: 1px solid #ccc; z-index: 1; min-width: 150px; top: calc(100% + 5px); right: 25px; }
                .dropdown-toggle::after { content: none; }
                .dropdown { position: relative; display: inline-flex; justify-content: space-around; }
                .dropdown-item { display: block; padding: 10px; text-decoration: none; color: black; }
                .dropdown-item:hover { background-color: #f1f1f1; }
            }
        </style>

</asp:Content>