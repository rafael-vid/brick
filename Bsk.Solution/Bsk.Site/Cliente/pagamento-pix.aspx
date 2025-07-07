<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="pagamento-pix.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento_pix" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao cotacoes-cli">
        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar" />
                Nova Cotação
            </a>
            <a href="minhas-cotacoes.aspx" class="btn_card">Minhas Cotações</a>
            <a href="aguardando-pagamento.aspx" class="btn_card">Pagamentos</a>
        </div>

        <div class="card boleto">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;" />
                <h2 class="subtitulo_1">Cotações / Cod.<span id="nrcotacao" runat="server"></span> / Gerar Pix</h2>
            </div>
            <div class="titulo_card" style="margin-top: 30px;">
                <h2 class="subtitulo_1">Confira seus Dados Cadastrais</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Nome Completo</h2>
                <p id="nomePix" runat="server"></p>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">E-mail</h2>
                <p id="email" runat="server"></p>
            </div>
            <div class="card-cl2">
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Documento</h2>
                    <p id="cpf" runat="server"></p>
                </div>
                <div class="item_content_card">
                    <h2 class="subtitulo_card_1 subtitulo_1">Telefone</h2>
                    <p id="telefone" runat="server"></p>
                </div>
            </div>
            <button id="btnAlterar" runat="server" onserverclick="btnAlterar_ServerClick" class="btn_card" style="width: 140px; margin-top: 30px;">Alterar Dados</button>

            <div class="item_content_card">
                <div class="titulo_card">
                    <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;" />
                    <h2 class="subtitulo_1">Valor do Pix</h2>
                </div>
            </div>
            <div class="item_content_card card_boleto_valor">
                <span class="valor_" id="valor" runat="server"></span>
                <button class="btn_card" id="btnGerarPix" runat="server" onserverclick="btnGerarPix_ServerClick">Gerar Pix</button>
                <label id="lbMsg" runat="server" style="color: red;"></label>
            </div>
            <div class="item_content_card">
                <asp:Label ID="lblApiResponse" runat="server" CssClass="api-response" ForeColor="Green"></asp:Label>
            </div>
            <div class="item_content_card" id="pixQrCodeContainer" runat="server" visible="false">
                <h2 class="subtitulo_card_1 subtitulo_1">QR Code Pix</h2>
                <img id="imgPixQrCode" runat="server" alt="QR Code Pix" style="max-width: 200px;" />
                <p id="pixCopyPaste" runat="server"></p>
            </div>
            <div class="item_content_card">
                <asp:Label ID="lblPixStatus" runat="server" CssClass="api-response" ForeColor="Blue"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
