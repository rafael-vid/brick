<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pagamento.aspx.cs" Inherits="Bsk.Site.Cliente.pagamento" MasterPageFile="~/Cliente/Master/Layout.Master" %>

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

        <div class="card" id="divPagamento" runat="server">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotações/ Cod.<asp:Label ID="nrCotacao" runat="server" Text=""></asp:Label>/ Pagamento</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <p id="tituloServ" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Detalhamento </h2>
                <p id="descricao" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Prestador de Serviço </h2>
                <p id="fornecedorNome" runat="server"></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Resumo da Cotação</h2>
                <p>Cotação nº <span id="nrServico" runat="server"></span></p>
            </div>

            <div class="item_content_card ">
                <div class="card-content-chat">
                    <div>
                        <div class="item_content_card ">
                            <div class="subtitulo-com-icone">
                                <img src="../assets/imagens/calendario.svg" alt="ícone" style="width: 20px;">
                                <h2 class="subtitulo_card_1 subtitulo_1">Data  Entrega</h2>
                            </div>
                            <div class="expo-info-values">
                                <span id="dtEntrega" runat="server"></span>
                            </div>
                        </div>
                       <div class="cli-infos-value">
                    <div class="item_content_card ">
                        <div class="subtitulo-com-icone">
                            <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                            <h2 class="subtitulo_card_1 subtitulo_1">Valor do Serviço</h2>
                        </div>
                        <div class="expo-info-values">
                            <span id="valorServ" runat="server"></span>
                        </div>
                    </div>
                </div>
                     
                    </div>

                    <div class="item_content_card ">
                        <div class="subtitulo-com-icone">
                            <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                            <h2 class="subtitulo_card_1 subtitulo_1">Forma de Pagamento</h2>
                          
                        </div>
                        <div class="files-upload cotacao-dados-upload">
                            <%--<a class="btn_card" id="btnBoleto" href="pagamento-boleto.aspx?Id=<%Response.Write(Request.QueryString["Id"]); %>">Boleto Bancário</a>--%>
                            <a class="btn_card" id="btnCartao" href="pagamento-cartao.aspx?&Id=<%Response.Write(Request.QueryString["Id"]); %>">Cartão de Crédito </a>
                        </div>
                    </div>

                </div>
            </div>

            <div>
                <asp:Literal ID="ltBoleto" runat="server"></asp:Literal>
            </div>

            <div>
                <asp:Literal ID="ltRecibo" runat="server"></asp:Literal>
            </div>

            <div class="footer_card">
                <a class="voltar btn" href="minhas-cotacoes.aspx"><< voltar
                </a>
                <!--
                <a href="/" class="item_notifica">
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



  <%--  <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12 corpo-site">
        <div>
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
                    <strong class="pull-right">Cotação nº </strong>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <span class="pull-left">Prestador de Serviços:</span> <strong text=""></strong>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        Serviço Prestado: <strong class="pull-right" text=""></strong>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 borda">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <h4 style="color: #b8272c;"><strong class="pull-left">Valor do Serviço:</strong> <strong class="pull-right" text=""></strong></h4>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                </div>
            </div>
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <h2 style="margin-top: 0;">Pagar com:</h2>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" style="width: 100%;" >
                        <img src="img/boleto.jpg" class="img-responsive center-block btn-pagamento" alt="">
                    </a>
                </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <a class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 botaoPagamento" style="width: 100%;" >
                        <img src="img/cartao.jpg" class="img-responsive center-block btn-pagamento" alt="">
                    </a>
                </div>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        </div>

    </div>
    <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>--%>


</asp:Content>
