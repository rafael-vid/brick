<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12 corpo-site">
        <div id="divPagamento" runat="server">
            <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Pagamento<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 mensagem alert alert-success bg-success text-center" style="width: 100%;">
                    <span class="tableTitle"><small>Mensagem do sistema:</small><br />
                        <strong>Legal!</strong> Ficamos felizes que tudo deu certo entre você e nosso Parceiro<br />
                        Agora falta pouco. Confira atentamente o valor descrito abaixo e escolha a forma de pagamento<br />
                        Esperamos que use nossos serviços novamente.<br />
                        Muito Obrigado!
                    </span>
                </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 col-lg-offset-2 col-md-offset-2">
                <h2 style="margin-top: 0;">Resumo da cotação</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 notaFiscal">                
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <img src="img/logo.png" class="img-responsive center-block" />
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <strong class="pull-right">Cotação nº <asp:Label ID="nrCotacao" runat="server" Text=""></asp:Label></strong>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <span class="pull-left">Prestador de Serviços:</span> <strong id="fornecedorNome" class="pull-right" runat="server" text=""></strong>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                   Serviço Prestado: <strong id="tituloServ" runat="server" class="pull-right" Text=""></strong>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <h4 style="color:#b8272c;"><strong class="pull-left">Valor do Serviço:</strong> <strong id="valorServ" runat="server" class="pull-right" text=""></strong></h4>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            </div>
            </div>           
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <h2 style="margin-top: 0;">Pagar com:</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" style="width: 100%;" id="btnBoleto" href="pagamento-boleto.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">
                    <img src="img/boleto.jpg" class="img-responsive center-block btn-pagamento" alt="">
                </a>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" style="width: 100%;" id="btnCartao" href="pagamento-cartao.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">
                    <img src="img/cartao.jpg" class="img-responsive center-block btn-pagamento" alt="">
                </a>
                </div>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        </div>
        <div>
            <asp:Literal ID="ltBoleto" runat="server"></asp:Literal>
        </div>

        <div>
            <asp:Literal ID="ltRecibo" runat="server"></asp:Literal>
        </div>
    </div>
    <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>


</asp:Content>
