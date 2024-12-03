<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento-cartao.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento_cartao" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="conteudo-dash cotacao cotacoes-cli">

                <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx"><img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Nova Solicitações</a>
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

                <script>
                    function toggleDropdown() {
                        var menu = document.getElementById("dropdownMenu");
                        // Toggle between showing and hiding the dropdown
                        menu.style.display = (menu.style.display === "none" || menu.style.display === "") ? "block" : "none";
                    }

                    // Close the dropdown if the user clicks outside of it
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
                    }
                </script>
            </div>
        </div>
    <div class="row">

    </div>
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
                <h2 class="subtitulo_card_1 subtitulo_1">Nome Completo </h2>
                <p id="nome" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">E-mail </h2>
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

            <div class="item_content_card   ">
                <div class="area_comentario boleto_ca">
                    <div class="item_content_card">
                        <h2 class="subtitulo_card_1 subtitulo_1">Nome do Cartão</h2>
                        <input type="text" class="card-input-add" id="nomeCartao" runat="server">
                    </div>
                    <div class="item_content_card">
                        <h2 class="subtitulo_card_1 subtitulo_1">Número do Cartão</h2>
                        <input type="text" class="card-input-add" id="numeroCartao" runat="server">
                    </div>
                </div>
            </div>
            <div class="item_content_card   ">
                <div class="area_comentario_g3">
                    <div class="item_content_card">
                        <h2 class="subtitulo_card_1 subtitulo_1">Mês</h2>
                        <input type="text" class="card-input-add" id="mes" runat="server">
                    </div>
                    <div class="item_content_card">
                        <h2 class="subtitulo_card_1 subtitulo_1">Ano</h2>
                        <input type="text" class="card-input-add" id="ano" runat="server">
                    </div>
                    <div class="item_content_card">
                        <h2 class="subtitulo_card_1 subtitulo_1">CVV</h2>
                        <input type="text" class="card-input-add" id="codigo" runat="server">
                    </div>
                </div>
            </div>

            <div class="item_content_card card_boleto_valor  ">
                <span class="valor_" id="valor" runat="server">
                </span>
                <div id="divCartao" runat="server">
                    <button class="btn_card" id="btnNovoCartão" onclick="deletarCartao();">Deletar Cartão</button>
                </div>
                <button class="btn_card" id="btnPagamento" runat="server" onserverclick="btnPagamento_ServerClick">Finalizar Pagamento</button>
           <label id="lbMsg" runat="server" style="color: red;"></label>
                </div>

            <div class="footer_card" style="margin-top: 36p;">
                <a class="voltar btn" href="aguardando-pagamento.aspx"><< voltar
                </a>
                <!--
                <a href="" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                -->
            </div>
        </div>
    </div>

    <style>
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }
        .swal-wide {
    font-size: 1.2em; /* Adjust the size as needed */
}

.swal-title {
    font-size: 1.5em; /* Adjust the size as needed */
}

.swal-text {
    font-size: 1.2em; /* Adjust the size as needed */
}
@media (max-width: 768px) {
    .conteudo-dash{
        padding: 0px 0px 0px 0px !important;
    }
    .btn_nova_solicitacao{
        margin-top: 5px;
    }
    .conteudo-dash{
        min-height: 0px !important;
    }
    .card-cotacao-dados {
        width: 400px !important;
    }
    .cotacoes-cli .acessos {
        flex-wrap: unset;
    }
    .acessos-small {
        display: flex; /* Exibe para telas pequenas */
        padding: 5px 15px 15px 15px;
        flex-direction: column;
    }
    .btn_card {
        font-size: 14px;
        width: 44% !important;
        margin-bottom: 15px;
        min-width: 170px;
    }
    btn_alterar_dados{
        margin-left:80px !important;
    }
    .card {
        padding: 15px !important;
    }
    .card-cotacao-dados {
        width: 100% !important;
        max-width: 388px; /* Mantenha esse limite, se necessário */
    }
    .card-cl2 {
        display: flex;
        flex-direction: column;
    }
    .grupo-pg-boleto{
     display: flex;
    flex-direction: column;
    }

    .dataTables_length label select{
        left: 15px !important;
    }
    .total_a_receber p {
        font-size: 25px;
    }
    .grid {
        flex-direction: column;
        margin-left: 15px !important;
    }    
    .media-cotacoes {
        min-width: 80% !important;
         
    }
    .divAceitar2{
        bottom: 0px; 
        right: 0px; 
        position: absolute; 
        z-index: 1000; 
        border: 0px;
    }
}
   

/* Estilos para dispositivos móveis */
    @media (max-width: 768px) {

        acessos-small {
            display: flex;
            flex-direction: column; /* Empilha verticalmente */
        }

        .dropdown-menu {
            position: absolute; /* Permite o posicionamento em relação ao botão */
            background-color: white;
            border: 1px solid #ccc;
            z-index: 1;
            min-width: 150px; /* Largura do dropdown */
            top: calc(100% + 5px); /* O menu aparece logo abaixo do botão */
            right: 25px; /* Alinha o menu com a borda esquerda do botão */
        }

        .dropdown-toggle::after {
            content: none; /* Remove a setinha */
        }

        .dropdown {
            position: relative; /* Necessário para a posição do dropdown */
            display: inline-flex;
            justify-content: space-around;
        }

        .dropdown-item {
            display: block;
            padding: 10px;
            text-decoration: none;
            color: black;
            margin-right: 0px;
        }

        .dropdown-item:hover {
            background-color: #f1f1f1; /* Muda a cor ao passar o mouse */
        }
    }
    </style>

    <script>
        function deletarCartao() {
            Swal.fire({
                toast: true,
                title: 'Deletar?',
                text: "Você tem certeza que gostaria de deletar esse cartão?",
                type: 'warning',
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
    </script>
    <script>
        function updateVisibility() {
            if (window.innerWidth < 768) {
                document.querySelector('.acessos').style.display = 'none';
                document.querySelector('.acessos-small').style.display = 'flex';
            } else {
                document.querySelector('.acessos').style.display = 'flex';
                document.querySelector('.acessos-small').style.display = 'none';
            }
        }

        // Chama a função ao carregar a página
        updateVisibility();

        // Adiciona evento para redimensionamento da janela
        window.addEventListener('resize', updateVisibility);
        function toggleDropdown() {
            var menu = document.getElementById("dropdownMenu");
            if (menu.style.display === "none") {
                menu.style.display = "block";
            } else {
                menu.style.display = "none";
            }
        }

        // Fecha o dropdown se o usuário clicar fora dele
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
        }
    </script>

</asp:Content>
