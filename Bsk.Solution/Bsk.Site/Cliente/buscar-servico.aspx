<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="buscar-servico.aspx.cs" Inherits="Bsk.Site.Cliente.buscar_servico" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <style>
        body {
            font-family: Rajdhani-semi, sans-serif;
        }

        .faq-itens {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            grid-gap: 20px;
        }

        .item-faq {
            margin-top: 23px;
            padding-bottom: 23px;
            position: relative;
        }

            .item-faq:last-child {
                border: none;
            }

            .item-faq form {
                display: none;
            }
            .item-faq label {
                font-size: 17px;
                color: #771218;
                font-family: Rajdhani-semi, sans-serif;
            }

            .item-faq input:checked + .checkbox-wrapper form {
                display: block;
            }

                .item-faq input:checked + .checkbox-wrapper form > div {
                    display: flex;
                    gap: 10px;
                    color: #3C3C3B;
                    font-size: 15px;
                    align-items: center;
                    height: 35px;
                }

                    .item-faq input:checked + .checkbox-wrapper form > div:nth-child(even) {
                        background: #fff;
                    }

            .item-faq h2 {
                cursor: pointer;
                padding-left: 30px;
                font-size: 17px;
                color: #771218;
                font-family: Rajdhani-semi, sans-serif;
            }

                .item-faq h2::before {
                    content: url(../assets/imagens/escoder.svg);
                    width: 17px;
                    height: 17px;
                    display: inline-block;
                    transform: rotate(180deg);
                    transition: transform .3s ease;
                    position: absolute;
                    left: 0;
                    top: 0;
                }

            .item-faq input {
                margin-right:10px
            }

        .categoria-nome {
            display: block !important;
            font-size: 24px;
        }

        .checkbox-wrapper form {
            margin-top: 10px;
            display: none !important;
        }

        .item-faq input:checked + .checkbox-wrapper form {
            display: block !important;
        }

        .item-faq input:checked + .checkbox-wrapper h2::before {
            transform: rotate(360deg);
            top: 0;
        }
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }

        @media (max-width: 787px) {

            .titulo-faq,
            .faq-itens {
                width: 100%;
            }

            .faq {
                background-position: right;
                height: auto;
            }
        }
    </style>

  
    <!-- Corpo Site -->
    <div class="conteudo-dash atuacao">
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Nova Cotação</h2>
            </div>

            <h2 class="subtitulo_card subtitulo_1">Qual serviço você precisa? </h2>

            <div class="faq-itens">
                <%var categorias = BuscaCategoria();

                    foreach (var item in categorias)
                    {%>
                <%var servicos = PegaServicoTodos(item); %>
                <div class="item-faq">
                    <span class="categoria-nome"><%Response.Write(item.Nome); %></span>
                    <div class="checkbox-wrapper">
                        <%foreach (var j in servicos)
                            {%>
                               <div>
                                   <input type="radio" name="rdo" value="<%Response.Write(item.IdCategoria); %>" /><%Response.Write(j.Nome); %>
                               </div> 
                                
                           <% } %>
                        
                    </div>
                </div>
                
                <%}
                %>
           
            </div>

            <div class="footer_card">
                <a class="voltar btn" href="minhas-cotacoes.aspx"><< voltar </a>
                <!--
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                -->
                <a id="btnProximo" class="btn btn-brikk" href="#">
                    Próximo >>
                </a>
                <script>
                    $('#btnProximo').click(function () {
                        window.location.href = "cadastro-cotacao.aspx?Id=" + $('input[name=rdo]:checked').val();
                    })
</script>
            </div>

        </div>
    </div>
  
</asp:Content>
