<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gerenciar-servicos.aspx.cs" Inherits="Bsk.Site.Fornecedor.gerenciar_servicos" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

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
    <style>
    .category-header {
        display: flex;
        align-items: center; /* This aligns the children (SVG and text) vertically in the center */
        cursor: pointer;
    }

    .arrow-icon {
        transition: transform .3s ease;
        fill: #000; /* Adjust the fill color as needed */
        /* No need for margin-right here if you want the SVG to be close to the text, adjust as needed */
    }

    h2 {
        margin: 0; /* Removes default margin from h2 to help with alignment, adjust as needed */
        padding: 0; /* Adjust padding as needed for your design */
        /* Add any other styles for your h2 here */
    }

    .nested-list {
        display: none;
        list-style-type: none;
        padding-left: 0;
    }
</style>
    


        <div class="conteudo-dash atuacao">
        
     <div class="subtitulo_card subtitulo_1" style="position: relative;">
    <img src="../assets/imagens/atuacao.svg" alt="ícone" style="width: 20px;">
    <h2 class="subtitulo_1">Serviços prestados</h2>
    <div class="buttons_container" style="margin-top: -30px;">
        <a id="exibir/esconder" class="btn_card2" style="float: right;" onclick="toggleAllCategories(event);">Exibir/esconder todos</a>
    </div>
</div>
        
        <%var areas = BuscaAreas(); %>
        <%List<string> servicoslista = new List<string>(); %>
        <%foreach (var item in areas)
    {%>
        <%var servicos = PegaServico(item);%>
        <%foreach (var j in servicos)
                servicoslista.Add(j.IdServico+"; "+item.IdCategoria);
            {%>
        <% } %>
<% } %>
        <script>
            var servicoslista = <%= new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(servicoslista) %>;
        </script>

        <%var categorias = BuscaCategoria(); %>

        <div class="servicos_atuacao">
            <div class="servico_item">
                <div>
    <% var checkboxCounter = 0; %>
<div class="servicos_atuacao">
    <div class="servico_item">
        <div class="faq-itens"> <!-- Added container for the grid -->
            <% foreach (var item in categorias) { %> <!-- Change 'areas' to 'categorias' to match your variable name -->
                <div>
                    <div class="category-header" onclick="toggleServices(this)">
                        <span class="category-toggle">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" class="arrow-icon">
                    <path d="M8.59 16.59L13.17 12 8.59 7.41 10 6l6 6-6 6z"/>
                </svg>
            </span>
                        <h2 id ="category-name"><%= item.Nome %></h2>
                    </div>
                    <ul class="nested-list">
                        <% var servicostodos = PegaServicoTodos(item); %>
                        <% foreach (var j in servicostodos) { %>
                            <% var checkboxId = "checkbox_" + checkboxCounter; %>
                            <% 
                                var checkboxValue = j.IdServico + "; " + item.IdCategoria;
                                if (servicoslista.Contains(checkboxValue)) { 
                                    %><li><input type='checkbox' name='servico' value='<%= checkboxValue %>' id='<%= checkboxId %>' checked>
                                    <label for="<%= checkboxId %>"><%= j.Nome %></label></li><%
                                } else {
                                    %><li><input type='checkbox' name='servico' value='<%= checkboxValue %>' id='<%= checkboxId %>'>
                                    <label for="<%= checkboxId %>"><%= j.Nome %></label></li><%
                                }
                            %>
                            <% checkboxCounter++; %>
                        <% } %>
                    </ul>
                </div>
            <% } %>
        </div>
    </div>
</div>



</div>

            </div>
        </div>
        <div class="footer_card">
            <a class="voltar btn" href="minhas-areas.aspx"><< voltar </a>
            <button class="btn_card" onclick="event.preventDefault(); paginateCategories('prev')" style="width: auto;">Anterior</button>
            <button  class="btn_card" onclick="event.preventDefault(); paginateCategories('next')" style="width: auto;">Próxima</button>
            <a class="btn_card" id="atualizarDados" onclick="atualizarDados()" style="width: auto;">Atualizar dados</a>
        </div>

        <script>

            function atualizarDados() {
                var servicosSelecionados = [];
                var servicos = "";
                var checkboxes = document.querySelectorAll('input[type="checkbox"][name="servico"]');
                checkboxes.forEach(function (checkbox) {
                    if (checkbox.checked) {
                        servicos += checkbox.value + ',';
                        servicosSelecionados.push(checkbox.value);
                    }
                });
                
                var parametro = {
                    service: servicos
                }
                comum.post("Fornecedor/AdicionarServico", parametro, redireciona);
                
            }
            function redireciona() {
                 window.location.href = "minhas-areas.aspx";
            }
        </script>
        <script>
            function toggleServices(element) {
                var arrow = element.querySelector('.arrow-icon');
                var nextElement = element.nextElementSibling;
                if (nextElement.style.display === "none" || nextElement.style.display === "") {
                    nextElement.style.display = "block";
                    arrow.style.transform = "rotate(90deg)";
                } else {
                    nextElement.style.display = "none";
                    arrow.style.transform = "rotate(0deg)";
                }
            }
        </script>
        <script>
            let currentPage = 0;
            const itemsPerPage = 9;

            function paginateCategories(direction) {
                // Calculate total number of pages
                const totalPages = Math.ceil(document.querySelectorAll('.category-header').length / itemsPerPage);

                // Adjust current page based on the direction ('next' or 'prev')
                if (direction === 'next' && currentPage < totalPages - 1) {
                    currentPage++;
                } else if (direction === 'prev' && currentPage > 0) {
                    currentPage--;
                }

                // Hide all categories
                document.querySelectorAll('.category-header').forEach((element, index) => {
                    element.parentNode.style.display = 'none'; // Adjust according to your HTML structure
                });

                // Show the current set of categories
                const start = currentPage * itemsPerPage;
                const end = start + itemsPerPage;
                document.querySelectorAll('.category-header').forEach((element, index) => {
                    if (index >= start && index < end) {
                        element.parentNode.style.display = ''; // Adjust according to your HTML structure
                    }
                });
            }

            window.onload = function () {
                paginateCategories();
                // Find all category headers
                var categoryHeaders = document.querySelectorAll('.category-header');
                categoryHeaders.forEach(function (header) {
                    // Check if the next sibling (the service list) contains any checked checkboxes
                    var servicesList = header.nextElementSibling;
                    var selectedServices = servicesList.querySelectorAll('input[type="checkbox"]:checked');
                    if (selectedServices.length > 0) {
                        // If there are selected services, expand this category
                        toggleServices(header);
                    }
                });
            };

            function toggleServices(element) {
                var arrow = element.querySelector('.arrow-icon');
                var nextElement = element.nextElementSibling;
                // Toggle visibility
                if (nextElement.style.display === "none" || nextElement.style.display === "") {
                    nextElement.style.display = "block";
                    // Assuming arrow rotation is desired upon toggling
                    arrow.style.transform = "rotate(90deg)";
                } else {
                    nextElement.style.display = "none";
                    arrow.style.transform = "rotate(0deg)";
                }
            }
        </script>
        <script>
            function toggleAllCategories(event) {
                // Prevent default action if this function was triggered by an event
                if (event) event.preventDefault();

                var allCategories = document.querySelectorAll('.category-header');
                var allLists = document.querySelectorAll('.nested-list');

                // Determine the action based on the first category's state
                var shouldExpand = allLists[0].style.display === "none" || allLists[0].style.display === "";

                allCategories.forEach(function (header, index) {
                    var arrow = header.querySelector('.arrow-icon');
                    var nextElement = header.nextElementSibling;

                    if (shouldExpand) {
                        nextElement.style.display = "block";
                        arrow.style.transform = "rotate(90deg)";
                    } else {
                        nextElement.style.display = "none";
                        arrow.style.transform = "rotate(0deg)";
                    }
                });
                console.log("botao clicado")
            }

        </script>







    </div>
    

</asp:Content>
