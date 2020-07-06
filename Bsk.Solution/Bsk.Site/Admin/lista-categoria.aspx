<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lista-categoria.aspx.cs" Inherits="Bsk.Site.Admin.lista_categoria"  MasterPageFile="~/Admin/Master/Layout.Master" %>


<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    
 <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h3 class="tableTitle">Minhas Categorias</h3>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <a href="categoria.aspx" class="btn btn-brikk pull-right btn-lg"> Nova Categoria</a>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Categoria</td>
                        <td>Status</td>
                        <td>Ação</td>
                    </tr>
                </thead>
                <tbody>
                   <!-- LOOP -->
                    <%
                        var categoria = Categoria();

                        foreach (var item in categoria)
                        {
                        %>
                    <tr>
                        <td><%Response.Write(item.Nome);%></td>
                        
                        <%
                            var status = "INATIVO";
                            if (item.Status == "1")
                                status = "ATIVO";

                            %>
                        <td><%Response.Write(status);%></td>

                        <td><a href="<%Response.Write($"cadastro-servico.aspx?Categoria={item.Nome}&IdCategoria={item.IdCategoria}");%>" class="btn btn-success" title="ADICIONAR SERVIÇOS"><i class="glyphicon glyphicon-plus-sign"></i></a> &nbsp;&nbsp;&nbsp;<a class="btn btn-info" href="<%Response.Write("categoria.aspx?Categoria="+item.IdCategoria);%>" title="EDITAR"><i class="glyphicon glyphicon-edit"></i></a>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                    <%
                        }
                        %>
                    <!-- FIM LOOP -->     
                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

</asp:Content>
