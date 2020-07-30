<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="perfil.aspx.cs" Inherits="Bsk.Site.Cliente.perfil" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;Pagamento Boleto&nbsp;<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h2>Dados Pessoais</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="nome" placeholder="Nome" runat="server">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="email" placeholder="E-mail" runat="server">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="cpf" placeholder="CPF" runat="server">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 dadosResponsavel">
                    <input type="text" class="form-control" id="telefone" placeholder="Telefone" runat="server">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-3 col-md-3 col-sm-3 col-xs-3 dadosResponsavel">
                    <input type="text" class="form-control" id="cep" placeholder="CEP" runat="server">
                </div>
                <div class="col col-lg-9 col-md-9 col-sm-9 col-xs-9 dadosResponsavel">
                    <input type="text" class="form-control" id="rua" placeholder="Rua" runat="server">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4 dadosResponsavel">
                    <input type="text" class="form-control" id="numero" placeholder="Número" runat="server">
                </div>
                <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4 dadosResponsavel">
                    <input type="text" class="form-control" id="complemento" placeholder="Complemento" runat="server">
                </div>
                <div class="col col-lg-4 col-md-4 col-sm-4 col-xs-4 dadosResponsavel">
                    <input type="text" class="form-control" id="bairro" placeholder="Bairro" runat="server">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 dadosResponsavel">
                    <input type="text" class="form-control" id="cidade" placeholder="Cidade" runat="server">
                </div>
                <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 dadosResponsavel">
                    <input type="text" class="form-control" id="uf" placeholder="UF" runat="server">
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <button class="btn btn-brikk btn-lg center-block" style="float: right;" id="btnAlterar" runat="server" onserverclick="btnAlterar_ServerClick">Alterar dados</button>

            </div>

        </div>
        <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>
</asp:Content>
