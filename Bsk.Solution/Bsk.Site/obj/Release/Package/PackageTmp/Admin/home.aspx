<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="Bsk.Site.Admin.home" MasterPageFile="~/Admin/Master/Layout.Master" %>


<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    
   <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
            
            <h2><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> Home <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
            <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12">
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="lista-categoria.aspx"><img src="img/categoria.jpg" class="img-responsive categoria" width="100%" alt=""></a>
                </div>
                <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="lista-fornecedor.aspx"><img src="img/fornacedor.jpg" class="img-responsive fornecedor" width="100%" alt=""></a>
                </div>         
                 <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                <div class="col col-lg-3 col-md-3 col-sm-12 col-xs-12">
                    <a href="pagamento-transacao.aspx"><img src="img/pagamentos.jpg" class="img-responsive fornecedor" width="100%" alt=""></a>
                </div>    
            </div>
            <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        </div>

</asp:Content>
