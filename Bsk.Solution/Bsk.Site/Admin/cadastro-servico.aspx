<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastro-servico.aspx.cs" Inherits="Bsk.Site.Admin.cadastro_servico"  MasterPageFile="~/Admin/Master/Layout.Master" %>


<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server"> 

     <!-- Corpo Site -->
    <div class="col col-lg-4 col-md-4 col-sm-12 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    <div class="col col-lg-4 col-md-4 col-sm-12 col-sm-12 col-xs-12 corpo-site">
        <h3 class="tableTitle">Cadastrar Serviço</h3>
        <h2 class="tableTitle">Categoria: <span id="categoria" runat="server" style="text-decoration:none !important;"></span>  </h2>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
            <asp:Label ID="lb" runat="server" Text="" ForeColor="Red"></asp:Label>
            <input type="text" class="form-control" id="titulo" runat="server" placeholder="Serviço da Categoria"/>
            
        </div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
            <button class="btn btn-lg btn-brikk pull-right" style="width: 100%;" id="btnSalvar" runat="server" onserverclick="btnSalvar_ServerClick" >Salvar</button>
        </div>           
        
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
            <button class="btn btn-lg btn-brikk pull-right" style="width: 100%;" id="btnDeletar" runat="server" onserverclick="btnDeletar_ServerClick">Deletar</button>
        </div>           
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Serviço</td>
                        <td>Ação</td>
                    </tr>
                </thead>
                <tbody>
                    <!-- LOOP -->
                    <%
                        var servicos = CarregaServico();
                        var url = $"cadastro-servico.aspx?Categoria={Request.QueryString["Categoria"]}&IdCategoria={Request.QueryString["IdCategoria"]}";
                        foreach (var item in servicos)
                        {

                        %>
                    <tr>
                        <td><%Response.Write(item.Nome);%></td>
                        <td><a href="<%Response.Write(url+$"&IdServico={item.IdServico}");%>" class="btn btn-brikk" title="DELETAR"><i class="glyphicon glyphicon-edit"></i></a></td>
                    </tr>     
                    <%
                        }
                        %>
                    <!-- FIM LOOP -->
                </tbody>
            </table>
        </div>            
    </div>
    <div class="col col-lg-4 col-md-4 col-sm-12 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>


</asp:Content>

