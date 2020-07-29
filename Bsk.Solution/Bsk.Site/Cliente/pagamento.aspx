<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <div id="divPagamento" runat="server">
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
                    <p id="fornecedorNome" runat="server" text=""></p>
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
                <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" id="btnBoleto" href="pagamento-boleto.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">
                    <img src="img/boleto.jpg" class="img-responsive center-block btn-pagamento" alt="">
                </a>
                <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" id="btnCartao" href="pagamento-cartao.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">
                    <img src="img/cartao.jpg" class="img-responsive center-block btn-pagamento" alt="">
                </a>
            </div>
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        </div>
    </div>

    <div>
        <asp:Literal ID="ltBoleto" runat="server"></asp:Literal>
    </div>

    <div>
        <asp:Literal ID="ltRecibo" runat="server"></asp:Literal>
    </div>

</asp:Content>
