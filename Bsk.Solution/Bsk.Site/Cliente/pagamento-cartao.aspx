<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento-cartao.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento_cartao" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="conteudo-dash cotacao cotacoes-cli">

        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Nova Cotação
            </a>
            <a href="minhas-cotacoes.aspx" class="btn_card">Minhas Cotações
            </a>
            <a href="aguardando-pagamento.aspx" class="btn_card">Pagamentos
            </a>
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

            <button id="btnAlterar" runat="server" onserverclick="btnAlterar_ServerClick" class="btn_card" style="width: 140px; margin-top: 30px;">Alterar Dados</button>

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
</asp:Content>
