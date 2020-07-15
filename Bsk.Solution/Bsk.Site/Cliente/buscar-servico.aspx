<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="buscar-servico.aspx.cs" Inherits="Bsk.Site.Cliente.buscar_servico" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">


    <!-- BUSCAR -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 banner-site pd-0">
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <h2>Procure por serviços.</h2>
                </div>
                <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12 mobile-pd-0">
                        <input type="text" class="form-control" id="servico" runat="server" placeholder="O que você precisa?">
                    </div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 pd-0">
                        <button class="btn btn-brikk l100" id="btnBuscar" runat="server" onserverclick="btnBuscar_ServerClick">Buscar</button>
                    </div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                </div>
            </div>
        </div>
    </div>


    <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Serviços<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12">
            <%var categorias = BuscaCategoria();

                foreach (var item in categorias)
                {%>
            <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                <a href="cadastro-cotacao.aspx?Id=<%Response.Write(item.IdCategoria); %>">
                    <img src="img/<%Response.Write(item.Imagem); %>" class="img-responsive" width="100%" alt="">
                    <h3><%Response.Write(item.Nome); %></h3>
                </a>
            </div>
            <%}
            %>
        </div>
        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

</asp:Content>
