<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-areas.aspx.cs" Inherits="Bsk.Site.Fornecedor.minhas_areas" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

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
                display: none;
            }

        .servico-nome {
            display: block !important;
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
    
    <div class="conteudo-dash atuacao">
        
     <div class="subtitulo_card subtitulo_1" style="position: relative;">
    <img src="../assets/imagens/atuacao.svg" alt="ícone" style="width: 20px;">
    <h2 class="subtitulo_1">Serviços prestados</h2>
    <div class="buttons_container">
        <a href="gerenciar-servicos.aspx" class="btn_card2">Gerenciar serviços prestados</a>
    </div>
</div>




            <%var areas = BuscaAreas(); %>
            
            <div class="servicos_atuacao">
                <div class="servico_item">
                    
                        <%foreach (var item in areas)
                            {%>
                            <p><%Response.Write(item.Nome); %></p>
                            <%var servicos = PegaServico(item);%>
                            <ul class="nested-list">
                                <%foreach (var j in servicos)
                                    {%>
                                    <li><%Response.Write(j.Nome); %></li>
                                <% } %>
                            </ul>
                        <% } %>
                    
                </div>
            </div>
               <div class="footer_card">
    <a class="voltar btn" href="minhas-cotacoes.aspx"><< voltar </a> 
        </div>

        
            <!--
            <a href="/" class="item_notifica">
                <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                <span class="notificacao">02</span>
            </a>
            -->
        </div>

    </div>

</asp:Content>
