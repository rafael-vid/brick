<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="pagamento-boleto.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento_boleto" MasterPageFile="~/Cliente/Master/Layout.Master" %>

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
                <h2 class="subtitulo_1">Cotações/ Cod.<span id="nrcotacao" runat="server"></span> / Gerar Boleto</h2>
            </div>
            <div class="titulo_card" style="margin-top: 30px;">
                <h2 class="subtitulo_1">Confira seus Dados Cadastrais</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Nome Completo </h2>
                <p id="nomeBol" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">E-mail </h2>
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
                    <h2 class="subtitulo_1">Valor do Boleto</h2>
                </div>
            </div>



            <div class="item_content_card card_boleto_valor  ">
                <span class="valor_" id="valor" runat="server"></span>
                <button class="btn_card" id="btnGerar" runat="server" onserverclick="btnGerar_ServerClick">Baixar Boleto</button>
                <asp:HiddenField ID="hfBoletoUrl" runat="server" />
                <label id="lbMsg" runat="server" style="color: red;"></label>
            </div>

            <asp:Label ID="lblApiResponse" runat="server" CssClass="api-response" ForeColor="Green"></asp:Label>

            <script type="text/javascript">
function openBoletoWindow() {
    var url = document.getElementById('<%= hfBoletoUrl.ClientID %>').value;
    if (url) {
        window.open(url, '_blank');
    }
}
</script>


            <div class="footer_card" style="margin-top: 36p;">
              
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
    </style>

</asp:Content>
