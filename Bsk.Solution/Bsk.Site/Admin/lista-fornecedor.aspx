<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lista-fornecedor.aspx.cs" Inherits="Bsk.Site.Admin.lista_fornecedor"  MasterPageFile="~/Admin/Master/Layout.Master" %>


<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
 <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <h3 class="tableTitle">Meus Fornecedores</h3>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
            <a class="btn btn-brikk pull-right btn-lg">Novo Fornecedor</a>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                <thead>
                    <tr class="linha1">
                        <td>Fornecedor</td>
                        <td>Responsavel</td>
                        <td>Status</td>
                        <td>Ação</td>
                    </tr>
                </thead>
                <tbody>
                  <!-- LOOP -->
                    <%
                        var fornecedores = CarregaFornecedor();
                        foreach (var item in fornecedores)
                        {

                        %>
                    <tr>
                        <td><%Response.Write(item.RazaoSocial);%></td>
                        <td><%Response.Write(item.Responsavel);%></td>
                        <td><%Response.Write((item.Status=="1")?"ATIVO":"INATIVO");%></td>
                        <td><a href="<%Response.Write($"cadastro-fornecedor.aspx?IdFornecedor={item.IdFornecedor}");%>" class="btn btn-success" title="EDITAR"><i class="glyphicon glyphicon-edit"></i></a></td>
                    </tr>
                    <%
                        }
                        %>
                <!--FIM LOOP-->                                  

                </tbody>
            </table>
        </div>

        <div class="col col-lg-1 col-md-1 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

    </asp:Content>