<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastra-atuacao.aspx.cs" Inherits="Bsk.Site.Fornecedor.cadastra_atuacao" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3 id="categoria">Minha Área</h3>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-4 col-md-4 col-sm-12 col-xs-12">
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0">
                    <%var cat = PegaCategoria(); %>
                    <img src="img/<%Response.Write(cat.Imagem); %>" class="img-responsive" width="100%" alt="">
                    <h3><%Response.Write(cat.Nome); %></h3>
                </div>
            </div>
            <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12 pd-0">
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                        <select name="" id="slcAtu" runat="server" class="form-control">
                            <option value="">Selecione um serviço</option>                           
                        </select>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                        <button class="btn btn-brikk pull-right" id="btnAdicionar" runat="server" onserverclick="btnAdicionar_ServerClick">Adcionar</button>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Meus serviços nesta área</h3>
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
                        <%var servicos = PegaServico();
                            foreach (var item in servicos)
                            {%>
                        <tr>
                            <td><%Response.Write(item.Nome); %></td>
                            <td>
                                <a href="cadastra-atuacao.aspx?Id=<%Response.Write(item.IdCategoria); %>&Del=<%Response.Write(item.IdServico); %>" class="btn btn-brikk">Deletar</a>
                            </td>
                        </tr>
                        <% }
                        %>
                    </tbody>
                </table>
            </div>
                </div>
            </div>
            
            
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        </div>
    </div>
</asp:Content>
