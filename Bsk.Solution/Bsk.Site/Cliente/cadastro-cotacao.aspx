<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cadastro-cotacao.aspx.cs" Inherits="Bsk.Site.Cliente.cadastro_cotacao"   MasterPageFile="~/Cliente/Master/Layout.Master" %>



<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server"> 

      <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <div class="col col-lg-10 col-md-10 col-sm-12 col-xs-12">
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <button class="btn btn-upload"><img src="img/video.png" alt="">&nbsp;&nbsp;Gravar um vídeo explicativo</button>
                <!-- <div class="btn record-audio" title='Enviar um áudio'> 🎤 </div>
                <div class="btn start-video" title='Câmera'>Câmera</div>
                <div class="btn stop-video" title='Stop'>Parar</div>
                <div class="btn take-picture" title='Tirar uma foto'> 📷 </div>
                <div class="btn record-video" title='Gravar vídeo'> ⏺ </div>

                <video src="" id="videoFeed" autoplay></video>
                <canvas id="picture-canvas"></canvas> -->

            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Título</h3>
                <input type="text" class="form-control" id="titulo" runat="server">
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Descreva sua necessidade</h3>
                <textarea class="form-control" cols="30" rows="10" id="descricao" runat="server"></textarea>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Arquivos anexos</h3>
                <table id="tabela" class="table table-condensed table-responsive table-striped table-hover">
                    <thead>
                        <tr class="linha1">
                            <td>Tipo de documento</td>
                            <td>Ações</td>
                        </tr>
                    </thead>
                    <tbody>

                        <!--LOOP DOCUMENTO-->
                        <tr>
                            <td>Documento que eu subi</td>
                            <td><button class="btn btn-brikk">Deletar</button>&nbsp;&nbsp;<button class="btn btn-brikk">Visualizar</button></td>
                        </tr>
                        <!-- FIM LOOP DOCUMENTO-->
                    </tbody>
                </table>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <button class="btn btn-brikk btn-lg pull-right" id="btnSalvar" runat="server" onserverclick="btnSalvar_ServerClick">Enviar</button>
                </div>
            </div>
        </div>

        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12">
            <h2 class="tableTitle">
                <p>Cotação </p>
                <button type="button" class="btn btn-upload"><img src="img/upload.png" alt="">&nbsp;&nbsp;Anexar Arquivos</button>
            </h2>
        </div>
    </div>

    <asp:FileUpload ID="flpAnexo" class="upload" runat="server" style="display: none;" />
  
</asp:Content>
