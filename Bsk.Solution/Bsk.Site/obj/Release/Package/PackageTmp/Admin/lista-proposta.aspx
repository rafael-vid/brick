<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="lista-proposta.aspx.cs" Inherits="Bsk.Site.Admin.lista_proposta"  MasterPageFile="~/Admin/Master/Layout.Master" %>


<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo">
        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0 fundoCinza" style="height: 100%; display: inline; align-items: center; align-content: center;">
            <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12  col-lg-offset-2 col-md-offset-2 corpoInner" style="display: grid; align-items: center; align-content: center;">
                <div id="load">
                    <%--<img class="center-block" src="../img/load.gif" />--%>
                </div>
                <div id="pagina" class="boxResumo">

                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12" style="text-align:right;">
                        <button class="btn btn-lg btn-info btn-continuar" id="BtnNovo" runat="server" onserverclick="BtnNovo_ServerClick" >Nova Proposta</button>
                    </div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>

                      <table class="table table-striped datatable">
                        <thead>
                            <tr>
                                <th>Titulo</th>
                                <th>Data Criação</th>
                                <th>Responsavel</th>
                                <th>Visualizar</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%
                                List<Bsk.BE.PropostaBE> lista = ListarProposta().OrderBy(x=>x.IdProposta).ToList();

                                foreach (var item in lista)
                                {
                            %>
                            <tr>
                                <td><%Response.Write(item.TituloInterno);%></td>
                                <td><%Response.Write(item.DataCriacao);%></td>
                                <td><%Response.Write(item.Responsavel);%></td>
                                <td><a href="<%Response.Write("proposta.aspx?CodigoProposta=" + item.CodigoProposta); %>">Visualizar</a></td>

                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>


                </div>


                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            </div>
        </div>
    </div>



</asp:Content>
