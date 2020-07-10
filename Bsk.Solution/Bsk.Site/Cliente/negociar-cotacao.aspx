<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="negociar-cotacao.aspx.cs" Inherits="Bsk.Site.Cliente.negociar_cotacao"  MasterPageFile="~/Cliente/Master/Layout.Master" %>



<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server"> 

     <!-- Corpo Site -->
    <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 corpo-site">
        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
        <div class="col col-lg-8 col-md-8 col-sm-12 col-xs-12">
            <h2 class="tableTitle">
                <p>Prestador de Serviço:</p>
                <br><asp:Label ID="prestador" runat="server" Text=""></asp:Label>
            </h2>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <h3>
                    <asp:Label ID="titulo" runat="server" Text=""></asp:Label> </h3>
            </div>

            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 boxDesc">
                <asp:Label ID="descricao" runat="server" Text=""></asp:Label>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12 pd-0">
                <asp:FileUpload ID="flpArquivo" CssClass="flpArquivo" runat="server" />
                <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" />
                <button type="button" class="btn btn-upload" id="btnArquivo"><img src="img/upload.png" alt="">&nbsp;&nbsp;Anexar Arquivos</button>&nbsp;&nbsp;<button type="button" class="btn btn-upload" id="btnVideo"><img src="img/video.png" alt="">&nbsp;&nbsp;Gravar um vídeo explicativo</button>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 pd-0">
                <textarea name="" id="" class="form-control" cols="30" rows="10"></textarea><br>
                <button class="btn btn-brikk btn-lg pull-right" id="btnEnviar" runat="server" onserverclick="btnEnviar_ServerClick">Enviar</button>
            </div>
            <div class="col col-lg-6 col-md-6 col-sm-12 col-xs-12 valorServico">
                <h2>
                    <strong>
                    <p>Valor do serviço:</p>
                    <br>R$<asp:Label ID="valor" runat="server" Text=""></asp:Label>
                    </strong>
                </h2>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h3>Últimas Perguntas</h3>
            </div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
            <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">

                <!--CLIENTE-->
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="mensagem boxDesc pull-left">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget mauris a eros tincidunt malesuada vel id ipsum. Vivamus tortor augue, malesuada quis volutpat in, vulputate in est. Suspendisse egestas metus eget nibh imperdiet pretium. Praesent ornare,
                    nisi vitae suscipit tempor, enim sem semper nisi, vitae blandit quam erat eu diam. Phasellus malesuada nunc non ornare interdum. Cras enim purus, accumsan at justo ullamcorper, porttitor fringilla ex. Curabitur efficitur, quam eu sodales
                </div>
                <!--FIM CLIENTE-->
               
                <!--FORNECEDOR-->
                <div class="col col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                <div class="mensagem boxDesc pull-right">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget mauris a eros tincidunt malesuada vel id ipsum. Vivamus tortor augue, malesuada quis volutpat in, vulputate in est. Suspendisse egestas metus eget nibh imperdiet pretium. Praesent ornare,
                    nisi vitae suscipit tempor, enim sem semper nisi, vitae blandit quam erat eu diam. Phasellus malesuada nunc non ornare interdum. Cras enim purus, accumsan at justo ullamcorper, porttitor fringilla ex. Curabitur efficitur, quam eu sodales
                </div>
                <!--FIM FORNECEDOR-->
                
            </div>
        </div>


        <div class="col col-lg-2 col-md-2 col-sm-12 col-xs-12 hidden-sm hidden-xs">&nbsp;</div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".flpArquivo").css("display", "none");
            $(".flpVideo").css("display", "none");

            $("#btnArquivo").click(function () {
                $(".flpArquivo").click();
            });

            $("#btnVideo").click(function () {
                $(".flpVideo").click();
            });

        });

    </script>

</asp:Content>
