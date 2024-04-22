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
            margin-top: 0px;
            padding-bottom: 0px;
            position: relative;
        }

            .item-faq:last-child {
                border: none;
            }

            .item-faq form {
                display: none;
            }
            .item-faq label {
                font-size: 16px;
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

        .category-label {
        font-size: 30px !important;

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
        .services input[type="checkbox"] {
    margin-left: 30px; /* Adjust the value as needed */
}
            div:where(.swal2-container).swal2-center > .swal2-popup {
                border-radius: 40px !important;
                font-size: 14px !important;
            }

            div:where(.swal2-container) button:where(.swal2-styled).swal2-cancel {
                border-radius: 20px !important;
                background-color: #770e18 !important;
            }

            div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
                border-radius: 20px !important;
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
<div class="item-faq">
    <!-- Radio button for the category -->
    <input type="radio" name="categoria" value="<%Response.Write(item.IdCategoria); %>" id="cat<%Response.Write(item.IdCategoria); %>" onchange="toggleServicesDisplay(this.value)" />
    <label for="cat<%Response.Write(item.IdCategoria); %>" class="category-label"><%Response.Write(item.Nome); %></label>


    <!-- Services are wrapped in a div with a class for hiding/showing, each service has a checkbox -->
    <div class="services" id="services<%Response.Write(item.IdCategoria); %>" style="display: none;">
        <%var servicos = PegaServicoTodos(item); %>
        <%foreach (var j in servicos)
        {%>
            <div>
                <!-- Checkbox for each service within the category -->
                <input type="checkbox" name="service<%Response.Write(item.IdCategoria); %>" value="<%Response.Write(j.IdServico); %>" id="service<%Response.Write(j.IdServico); %>" />
                <label for="service<%Response.Write(j.IdServico); %>"><%Response.Write(j.Nome); %></label>
            </div>
        <% } %>
    </div>
</div>
<%} %>



           
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
                    $('#btnProximo').click(function (e) {
                        // Prevent the default action if no checkboxes are selected
                        var selectedCategory = $('input[name="categoria"]:checked').val();
                        var servicesChecked = $('#services' + selectedCategory + ' input[type="checkbox"]:checked').length;

                        if (servicesChecked === 0) {
                            Swal.fire('Por favor selecione pelo menos um serviço antes de continuar');
                            e.preventDefault();  // Stop the navigation to "cadastro-cotacao.aspx"
                        } else {
                            // If services are selected, proceed with navigation
                            window.location.href = "cadastro-cotacao.aspx?Id=" + selectedCategory;
                        }
                    });
                </script>

                <script>
                    function toggleServicesDisplay(selectedCategoryId) {
                        // Hide all services
                        $('.services').hide();

                        // Show the services under the selected category
                        $('#services' + selectedCategoryId).show();

                        // Optionally, reset checkboxes in hidden service divs
                        $('.services').not('#services' + selectedCategoryId).find('input[type=checkbox]').prop('checked', false);
                    }
                </script>


            </div>

        </div>
    </div>
  
</asp:Content>
