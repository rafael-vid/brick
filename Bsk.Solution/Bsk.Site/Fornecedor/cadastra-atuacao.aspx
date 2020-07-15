<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastra-atuacao.aspx.cs" Inherits="Bsk.Site.Fornecedor.cadastra_atuacao" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3 id="categoria">Minha Área</h3>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0">
                    <img src="img/imagem.jpg" class="img-responsive" width="100%" alt="">
                    <h3>Ar condicionado</h3>
                </div>
            </div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0">
                <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0">
                    <h3>Ar condicionado</h3>
                    <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12 pdl-0">
                        <select name="" id="" class="form-control">
                            <option value="">Categoria</option>
                        </select>
                    </div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-lg hidden-md">&nbsp;</div>
                    <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 pd-0">
                        <button class="btn btn-brikk">Adcionar</button>
                    </div>
                </div>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Meus serviços nesta área</h3>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12">
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
            <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        </div>
    </div>
</asp:Content>
