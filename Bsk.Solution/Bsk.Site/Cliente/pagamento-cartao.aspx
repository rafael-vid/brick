<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento-cartao.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento_cartao" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;Pagamento Cartão de Crédito&nbsp;<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">
                <h2>Dados Pessoais</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert alert-success bg-success" style="width: 100%;">
                    Confira seus dados pessoais, dados do cartão de crédito e o valor e se tudo estiver correto clique em "Finalizar Pagamento"
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="nome" runat="server" placeholder="Nome" disabled>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="email" runat="server" placeholder="E-mail" disabled>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="cpf" runat="server" placeholder="CPF" disabled>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="telefone" runat="server" placeholder="Telefone" disabled>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-3 col-md-3 col-sm-3 col-xs-3 dadosResponsavel">
                    <input type="text" class="form-control" id="cep" runat="server" placeholder="CEP" disabled>
                </div>
                <div class="col col-lg-9 col-md-9 col-sm-9 col-xs-9 dadosResponsavel">
                    <input type="text" class="form-control" id="rua" runat="server" placeholder="Rua" disabled>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4 dadosResponsavel">
                    <input type="text" class="form-control" id="numero" runat="server" placeholder="Número" disabled>
                </div>
                <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4 dadosResponsavel">
                    <input type="text" class="form-control" id="complemento" runat="server" placeholder="Complemento" disabled>
                </div>
                <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4 dadosResponsavel">
                    <input type="text" class="form-control" id="bairro" runat="server" placeholder="Bairro" disabled>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 dadosResponsavel">
                    <input type="text" class="form-control" id="cidade" runat="server" placeholder="Cidade" disabled>
                </div>
                <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 dadosResponsavel">
                    <input type="text" class="form-control" id="uf" runat="server" placeholder="UF" disabled>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <button class="btn btn-brikk btn-lg center-block" style="float: right;" id="btnAlterar" runat="server" onserverclick="btnAlterar_ServerClick">Alterar dados</button>

            </div>
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">
                <h2>Dados do cartão</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="nomeCartao" runat="server" placeholder="Nome do Cartão" required>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="numeroCartao" runat="server" placeholder="Número do cartão" required>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="mes" runat="server" placeholder="Mês" maxlength="2" required>
                </div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="ano" runat="server" placeholder="Ano" maxlength="2" required>
                </div>
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="codigo" runat="server" placeholder="CVV" required>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div id="divCartao" runat="server">
                    <button type="button" class="btn btn-brikk btn-lg center-block" id="btnNovoCartão" style="width: 30%; float: left;" onclick="deletarCartao();">Deletar cartão</button>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <h1 class="text-center" id="valor" style="width: 100%;" runat="server"></h1>

                <button class="btn btn-brikk btn-lg center-block" id="btnPagamento" runat="server" onserverclick="btnPagamento_ServerClick" style="width: 100%;">Finalizar Pagamento</button>
                <label id="lbMsg" runat="server" style="color: red;"></label>
            </div>
        </div>
        <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>
    <script>
        function deletarCartao() {
            Swal.fire({
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
