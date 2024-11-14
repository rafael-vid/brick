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
    .footer_card {
    display: flex;
    justify-content: space-between; /* Adjust this line */
    align-items: center;
    gap: 10px; /* Adjust gap between buttons */
}


.btn_card {
    margin: 0 5px; /* Adjust side margins to bring buttons closer */
    padding: 5px 10px; /* Adjust padding as per design */
    background-color: #f08f00; /* Example background color */
    color: white; /* Text color */
    border: none; /* Remove border */
    cursor: pointer; /* Change cursor on hover */
}
.paginate_button {
    outline:none;
    border: none;
}
.paginacao_card{
    display: flex;
    justify-content: right;
    color: #770e18;
}
.dynamic-page-btn {
    margin: 0 5px; /* Adjust side margins to bring buttons closer */
    padding: 5px 10px; /* Adjust padding as per design */
    background-color: #f08f00; /* Example background color */
    color: white; /* Text color */
    border: none; /* Remove border */
    cursor: pointer; /* Change cursor on hover */
    border-radius: 50%; /* Make the buttons round */
    width: 30px; /* Equal width and height to ensure circular shape */
    height: 30px;
    display: inline-flex; /* Use flex to center the text inside the button */
    align-items: center;
    justify-content: center;
}


</style>
    


        <div class="conteudo-dash atuacao">
        
     <div class="subtitulo_card subtitulo_1" style="position: relative;">
    <img src="../assets/imagens/atuacao.svg" alt="ícone" style="width: 20px;">
    <h2 class="subtitulo_1">Serviços prestados</h2>
    <div class="buttons_container" style="margin-top: -30px;">
        <!--<a id="exibir/esconder" class="btn_card2" style="float: right;" onclick="toggleAllCategories(event);">Exibir/esconder todos</a>-->
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

        <div class="paginacao_card">
    <button class="paginate_button" onclick="event.preventDefault(); paginateCategories('prev')" style="width: auto; font-size: 13px;">Anterior</button>
    <!-- Page buttons container -->
    <div class="page-buttons-container"></div>
    <button  class="paginate_button" onclick="event.preventDefault(); paginateCategories('next')" style="width: auto; font-size: 13px;">Próximo</button>
</div>

        <div class="footer_card">
            <a class="voltar btn" href="minhas-areas.aspx"><< voltar </a>
            
            <a class="btn_card2" id="atualizarDados" onclick="atualizarDados()" style="width: auto;">Atualizar dados</a>
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

            function paginateCategories(direction, specificPage) {
                const totalPages = Math.ceil(document.querySelectorAll('.category-header').length / itemsPerPage);
                if (specificPage !== undefined) {
                    currentPage = specificPage;
                } else {
                    if (direction === 'next' && currentPage < totalPages - 1) {
                        currentPage++;
                    } else if (direction === 'prev' && currentPage > 0) {
                        currentPage--;
                    }
                }
                updateCategoryDisplay();
                renderPageButtons(); // Re-render page buttons after pagination
            }


            function updateCategoryDisplay() {
                const start = currentPage * itemsPerPage;
                const end = start + itemsPerPage;
                document.querySelectorAll('.category-header').forEach((element, index) => {
                    element.parentNode.style.display = 'none';
                    if (index >= start && index < end) {
                        element.parentNode.style.display = '';
                    }
                });
            }

            function renderPageButtons() {
                const totalPages = Math.ceil(document.querySelectorAll('.category-header').length / itemsPerPage);
                const navigationContainer = document.querySelector('.page-buttons-container');

                // Clear existing dynamically added buttons to avoid duplicates
                const existingButtons = navigationContainer.querySelectorAll('.dynamic-page-btn');
                existingButtons.forEach(btn => btn.remove());

                // Calculate the range of buttons to display
                let startPage, endPage;
                if (totalPages <= 5) {
                    startPage = 0;
                    endPage = totalPages - 1;
                } else {
                    if (currentPage <= 2) {
                        startPage = 0;
                        endPage = 4;
                    } else if (currentPage >= totalPages - 3) {
                        startPage = totalPages - 5;
                        endPage = totalPages - 1;
                    } else {
                        startPage = currentPage - 2;
                        endPage = currentPage + 2;
                    }
                }

                for (let i = startPage; i <= endPage; i++) {
                    const button = document.createElement('button');
                    button.textContent = i + 1;
                    button.className = 'dynamic-page-btn';
                    button.type = 'button';
                    button.addEventListener('click', function (event) {
                        event.preventDefault();
                        paginateCategories(null, i);
                        renderPageButtons(); // Re-render page buttons after clicking
                    });

                    if (i === currentPage) {
                        button.classList.add('active'); // Add 'active' class to current page button
                    }

                    navigationContainer.appendChild(button);
                }
            }




            window.onload = function () {
                paginateCategories();
                renderPageButtons();
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



            window.mobileCheck = function () {
                let check = false;
                (function (a) { if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) check = true; })(navigator.userAgent || navigator.vendor || window.opera);
                return check;
            };

            if (window.mobileCheck) {
                $('.app').addClass('mini-menu')
                $("#exibir/esconder").hide();
            }
        </script>







    </div>
    

</asp:Content>
