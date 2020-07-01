<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="proposta.aspx.cs" Inherits="Bsk.Site.Admin.proposta"  MasterPageFile="~/Admin/Master/Layout.Master" ValidateRequest="false" %>


<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">


    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">

        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0 fundoCinza" style="height: 100%; display: inline; align-items: center; align-content: center;">
            
            <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12  col-lg-offset-2 col-md-offset-2 corpoInner" style="display: grid; align-items: center; align-content: center;">
                
                
                
                <div class="col col-lg-12 col-md-12 col-sm-8 col-xs-12">&nbsp;</div>
                <div id="load">
                    <%--<img class="center-block" src="../img/load.gif" />--%>
                </div>
                <div id="pagina" class="boxResumo">

                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>


                    <div class="col col-lg-3 col-md-3 col-sm-3 col-xs-3">
                            <button class="btn btn-lg btn-info btn-continuar" id="BtnVisualizar" runat="server" onserverclick="BtnVisualizar_ServerClick" >Visualizar</button>
                        </div>
                    <div class="col col-lg-3 col-md-3 col-sm-3 col-xs-3">
                            <button class="btn btn-lg btn-info btn-continuar" id="BtnVisualizarCliente" runat="server" onserverclick="BtnVisualizarCliente_ServerClick" >Link Cliente</button>
                        </div>

                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <button class="btn btn-lg btn-info btn-continuar" id="BtnDeletar" runat="server" onserverclick="BtnDeletar_ServerClick" >Deletar</button>
                        </div>
                        

                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12"> &nbsp;</div>

                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <input type="text" class=" form-control" id="tituloInterno" placeholder="Titulo Interno" runat="server" />
                        </div>

                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                        <input type="text" class=" form-control" id="emailContato" placeholder="E-mail Contato" runat="server" />
                        </div>

                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>

                     <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <span>Data Criação: &nbsp;<asp:Label ID="lbDtCriacao" runat="server" Text=""></asp:Label> </span>
                        </div>

                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <span>Data Ultima Alteração:&nbsp; <asp:Label ID="dtUltimaAlteracao" runat="server" Text=""></asp:Label></span>
                        </div>
                        
                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>

                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <input type="text" class=" form-control" id="Empresa" placeholder="Empresa" runat="server" />
                        </div>

                        <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <input type="text" class=" form-control" id="Responsavel"  placeholder="Responsavel"  runat="server" />
                        </div>

                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                       <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <textarea name="resumo" id="Resumo" runat="server"  placeholder="Resumo"  class="form-control" style="height: 200px;"></textarea>
                    </div>


                    <div class="col col-lg-12 col-md-12 col-sm-8 col-xs-12">&nbsp;</div>

                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                      <textarea name="descricao" id="Servicos" runat="server"  placeholder="Descrição de Serviços"  class="form-control" style="height: 200px;"></textarea>
                    </div>

                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>

                      <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <input type="text" class=" form-control" id="Total"  placeholder="Total"  runat="server" />
                      </div>

                    
                      <div class="col col-lg-6 col-md-6 col-sm-6 col-xs-6">
                            <input type="text" class=" form-control" id="Validade"  placeholder="Validade"  runat="server" />
                      </div>


                        <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                       <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <textarea name="pagamento" id="Pagamento" runat="server"  placeholder="Forma de pagamento"  class="form-control" style="height: 200px;"></textarea>
                    </div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                      <textarea name="Condicao" id="Condicao" runat="server"  placeholder="Condições"  class="form-control" style="height: 200px;"></textarea>
                    </div>

                    <div class="col col-lg-12 col-md-12 col-sm-8 col-xs-12">&nbsp;</div>
                    
                    <div class="col col-lg-12 col-md-12 col-sm-8 col-xs-12">
                        <button class="btn btn-lg btn-info btn-continuar pull-left" id="btnSalvar" style="width: 100%;" runat="server" onserverclick="btnSalvar_ServerClick">Salvar</button>
                    </div>

        
                    </div>


            </div>
        </div>
    </div>

   

</asp:Content>
