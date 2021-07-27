<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="finalizar-pagamento.aspx.cs" Inherits="Bsk.Site.Cliente.finalizar_pagamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
     <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Pagamento<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <h3>
                    <asp:Label ID="nrCotacao" runat="server" Text=""></asp:Label>
                </h3>
            </div>
            <h2 class="tableTitle">
                <p>Prestador de Serviço:</p>
                <br>
                <asp:Label ID="prestador" runat="server" Text=""></asp:Label>
            </h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <h3>
                    <asp:Label ID="titulo" runat="server" Text=""></asp:Label>
                </h3>
            </div>
            <h2 class="tableTitle">
                <p>Valor do Serviço:</p>
                <br>
                <asp:Label ID="valor" runat="server" Text=""></asp:Label>
            </h2>
        </div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
            Confira atentamente os valores antes de finalizar o pagamento.
        </div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12">
            <button class="col col-lg-6 col-md-6 col-sm-12 col-xs-12" id="btnLiberar" runat="server" onserverclick="btnLiberar_ServerClick">
                <img src="img/semImagem.jpg" class="img-responsive center-block btn-pagamento" alt="">
            </button>
           
        </div>
        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

    <style>
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }
    </style>

</asp:Content>
