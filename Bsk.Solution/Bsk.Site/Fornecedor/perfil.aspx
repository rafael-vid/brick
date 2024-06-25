<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perfil.aspx.cs" Inherits="Bsk.Site.Fornecedor.perfil" ValidateRequest="false" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<div class="conteudo-dash cotacao cotacoes-cli">

    <div class="acessos">
        <a href="cotacao-lista.aspx" class="btn_card">
            <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
            Buscar nova cotação
        </a>
        <a href="em-andamento.aspx" class="btn_card">Cotações em negociação
        </a>
        <a href="minhas-areas.aspx" class="btn_card">Minhas áreas de atuação
        </a>
    </div>

    <div class="card">
        <div class="titulo_card">
            <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
            <h2 class="subtitulo_1">Dados Cadastrais</h2>
        </div>

        <div style="display:grid;grid-template-columns: 50% 1fr;  grid-gap: 20px;">

            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Nome</label>
                <input type="text" class="card-input-add" id="nome" runat="server" required>
                <label id="msgnome" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Sobrenome</label>
                <input type="text" class="card-input-add" id="sobrenome" runat="server" required>
                <label id="msgsobrenome" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">E-mail</label>
                <input type="text" class="card-input-add" id="email" runat="server" required>
                <label id="msgemail" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">CPF</label>
                <input type="text" class="card-input-add" id="cpf" runat="server" required>
                <label id="msgcpf" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Telefone</label>
                <input type="text" class="card-input-add" id="telefone" runat="server" required>
                <label id="msgtelefone" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card que bra">
                <label class="subtitulo_card_1 subtitulo_1">Endereço</label>
                <input type="text" class="card-input-add" id="rua" runat="server" required>
                <label id="msgrua" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Bairro</label>
                <input type="text" class="card-input-add" id="bairro" runat="server" required>
                <label id="msgbairro" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Número</label>
                <input type="number" class="card-input-add" id="numero" runat="server" required>
                <label id="msgnumero" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">CEP</label>
                <input type="text" class="card-input-add" id="cep" runat="server" required>
                <label id="msgcep" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Complemento</label>
                <input type="text" class="card-input-add" id="complemento" runat="server">
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Cidade</label>
                <input type="text" class="card-input-add" id="cidade" runat="server" required>
                <label id="msgcidade" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Estado</label>
                <input type="text" class="card-input-add" id="uf" runat="server" required>
                <label id="msguf" runat="server" class="card_erro subtitulo_3"></label>
            </div>
            <div class="item_content_card">
                <label class="subtitulo_card_1 subtitulo_1">Presta Serviços</label>
                <input type="checkbox" id="prestaServicos" runat="server">
            </div>
        </div>
        <div class="footer_card" style="margin-top: 36px;">
            <button id="btnAlterar" runat="server" onserverclick="btnAlterar_ServerClick" class="voltar btn">salvar
            </button>
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
    /*sweet alert style*/

    div:where(.swal2-container).swal2-center > .swal2-popup {
        border-radius: 40px !important;
        font-size: 16px !important;
    }

    div:where(.swal2-container) button:where(.swal2-styled).swal2-cancel {
        border-radius: 20px !important;
        background-color: #770e18 !important;
    }

    div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
        border-radius: 20px !important;
        background-color: #f08f00 !important;
    }

    div:where(.swal2-container) button:where(.swal2-styled).swal2-deny {
        border-radius: 20px !important;
        background-color: #f08f00 !important;
    }

    div:where(.swal2-icon).swal2-info {
        border-color: #770e18 !important;
        color: #770e18 !important;
    }

    .swal2-icon.swal2-error {
        border-color: #770e18 !important;
        color: #770e18 !important;
    }

    /*sweet alert style*/

</style>
</asp:Content>
