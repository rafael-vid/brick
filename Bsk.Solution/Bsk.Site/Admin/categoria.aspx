<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="categoria.aspx.cs" Inherits="Bsk.Site.Admin.categoria"  MasterPageFile="~/Admin/Master/Layout.Master" %>


<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server"> 


     <!-- Corpo Site -->
    <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 corpo-site">
        <h3 class="tableTitle">Cadastrar Categorias</h3>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
            <asp:Label ID="lb" runat="server" Text="" ForeColor="Red"></asp:Label>
            <input type="text" name="" id="titulo" runat="server" class="form-control" placeholder="Título da Categoria">
        </div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0 text-center">
                <asp:FileUpload ID="flpImg" class="logoCliente"  runat="server" />
                
            </div>

            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6 pd-0 text-left">
                <button class="btn btn-brikk" title="DELETAR" runat="server" id="btnDel" onserverclick="btnDel_ServerClick"><i class="glyphicon glyphicon-remove"></i></button>
            </div>
            <div class="col col-lg-5 col-md-5 col-sm-5 col-xs-5 pd-0 text-right">
                <input type="checkbox" id="chkStatus" runat="server" class="form-control" /> 
            </div>

         <div class="col col-lg-1 col-md-1 col-sm-1 col-xs-1 text-left">Ativo</div>

        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 img-perfil pd-0">
                <asp:Image ID="imgRep" CssClass="img-responsive center-block" width="50%" runat="server" />
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <button class="btn btn-lg btn-brikk pull-right" style="width: 100%;" runat="server" id="btnSalvar" onserverclick="btnSalvar_ServerClick">Salvar</button>
            </div>
            
        </div>
    </div>
    <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>


</asp:Content>
    