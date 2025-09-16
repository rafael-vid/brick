<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="buscar-servico.aspx.cs" Inherits="Bsk.Site.Cliente.buscar_servico" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <style>
        body {
            font-family: Rajdhani-semi, sans-serif;
        }

        .ordenador{
            padding: 30px;
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
        /*sweet alert style*/

        div:where(.swal2-container).swal2-center > .swal2-popup {
            border-radius: 40px !important;
            font-size: 16px !important;
            flex-direction: column !important;
        }

        .swal2-actions {
            flex-direction: column !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-cancel {
            border-radius: 20px !important;
            background-color: #770e18 !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
            border-radius: 20px !important;
            background-color: #f08f00 !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-deny {
            border-radius: 20px !important;
            background-color: #f08f00 !important;
        }

        div:where(.swal2-icon).swal2-info {
            border-color: #770e18 !important;
            color: #770e18 !important;
        }

        .swal2-icon.swal2-error {
            border-color: #770e18 !important;
            color: #770e18 !important;
        }

        /*sweet alert style*/


    </style>
    <style>
        .card {
            margin: 0px 30px 30px 30px;
        }
        .conteudo-dash {
            min-height: 0vh !important;
        }
        div.chart {
            position: relative;
            width: 150px;
            height: 150px;
        }

        canvas {
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            border-radius: 50%;
        }

        span.marcacao {
            color: #770e18;
            display: block;
            line-height: 150px;
            text-align: center;
            width: 150px;
            font-family: sans-serif;
            font-size: 40px;
            font-weight: 100;
            margin-left: 5px;
        }

        .estrelas {
            margin-top: 10px;
        }

        .estrelas input[type=radio] {
            display: none;
        }

        .estrelas label i.fa {
            font-size: 2.5em;
            cursor: pointer;
        }

        .estrelas label i.fa:before {
            content: '\f005';
            color: #FC0;
        }

        .estrelas input[type=radio]:checked ~ label i.fa:before {
            color: #CCC;
        }
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }
        .acessos{
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .subtitulo_card {
                margin-top: 35px !important;
            }
            .area_comentario {
                grid-gap: 15px !important;
            }
            .card {
                margin: 0px 0px 0px 0px !important;
            }
            .conteudo-dash{
                padding: 0px 0px 0px 0px !important;
            }
            .btn_nova_solicitacao{
                margin-top: 5px;
            }
            .conteudo-dash{
                min-height: 0px !important;
            }
            .card-cotacao-dados {
                width: 400px !important;
            }
            .cotacoes-cli .acessos {
                flex-wrap: unset;
            }
            .acessos-small {
                display: flex; /* Exibe para telas pequenas */
                padding: 2px 15px 15px 15px;
                flex-direction: column;
            }
            .btn_card {
                font-size: 14px;
                width: 44% !important;
                margin-bottom: 15px;
                min-width: 170px;
            }
            btn_alterar_dados{
                margin-left:80px !important;
            }
            .card {
                z-index: 1;
                padding: 15px !important;
            }
            .card-cotacao-dados {
                width: 100% !important;
                max-width: 388px; /* Mantenha esse limite, se necessário */
            }
            .card-cl2 {
                display: flex;
                flex-direction: column;
            }
            .grupo-pg-boleto{
                 display: flex;
                flex-direction: column;
            }

            .dataTables_length label select{
                left: 15px !important;
            }
            .total_a_receber p {
                font-size: 25px;
            }
            .grid {
                flex-direction: column;
                margin-left: 15px !important;
            }    
            .media-cotacoes {
                min-width: 80% !important;
         
            }
            .divAceitar2{
                bottom: 0px; 
                right: 0px; 
                position: absolute; 
                z-index: 1000; 
                border: 0px;
            }
        }
   

/* Estilos para dispositivos móveis */
        @media (max-width: 768px) {

            acessos-small {
                display: flex;
                flex-direction: column; /* Empilha verticalmente */
            }

            .dropdown-menu {
                position: absolute; /* Permite o posicionamento em relação ao botão */
                background-color: white;
                border: 1px solid #ccc;
                z-index: 10;
                min-width: 150px; /* Largura do dropdown */
                top: calc(100% + 5px); /* O menu aparece logo abaixo do botão */
                right: 25px; /* Alinha o menu com a borda esquerda do botão */
            }

            .dropdown-toggle::after {
                content: none; /* Remove a setinha */
            }

            .dropdown {
                position: relative; /* Necessário para a posição do dropdown */
                display: inline-flex;
                justify-content: space-around;
            }

            .dropdown-item {
                display: block;
                padding: 10px;
                text-decoration: none;
                color: black;
                margin-right: 0px;
            }

            .dropdown-item:hover {
                background-color: #f1f1f1; /* Muda a cor ao passar o mouse */
            }
        }
    </style>

  
    <!-- Corpo Site -->
    <div class="conteudo-dash atuacao">
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Nova Solicitação</h2>
            </div>

            <h2 class="subtitulo_card subtitulo_1">Qual serviço você precisa? </h2>

            <div class="ordenador">
                <label for="sortOrder">Organizar por:</label>
                <select id="sortOrder">
                    <option value="relevance" selected>Padrão</option>
                    <option value="alphabetical">Ordem Alfabética</option>
                </select>
            </div>

           <div class="faq-itens">
                <% var categorias = BuscaCategoria(); 
                foreach (var item in categorias) {%>
                    <div class="item-faq" data-nome="<% Response.Write(item.Nome.ToLower()); %>">
                        <!-- Radio button for the category -->
                        <input type="radio" name="categoria" value="<% Response.Write(item.IdCategoria); %>" id="cat<% Response.Write(item.IdCategoria); %>" onchange="toggleServicesDisplay(this.value)" />
                        <label for="cat<% Response.Write(item.IdCategoria); %>" class="category-label"><% Response.Write(item.Nome); %></label>

                        <!-- Services wrapped in a div -->
                        <div class="services" id="services<% Response.Write(item.IdCategoria); %>" style="display: none;">
                            <% var servicos = PegaServicoTodos(item); %>
                            <% foreach (var j in servicos) {%>
                                <div class="service-item">
                                    <input type="checkbox" name="service<% Response.Write(item.IdCategoria); %>" value="<% Response.Write(j.IdServico); %>" id="service<% Response.Write(j.IdServico); %>" />
                                    <label for="service<% Response.Write(j.IdServico); %>"><% Response.Write(j.Nome); %></label>
                                </div>
                            <% } %>
                        </div>
                    </div>
                <% } %>
            </div>




            <div class="footer_card">
                <input type="hidden" id="selectedCategory" />
                <input type="hidden" id="selectedServices" />
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
                    function updateSelectedServicesField(shouldPersist) {
                        if (typeof shouldPersist === 'undefined') {
                            shouldPersist = true;
                        }

                        var selectedCategory = $('input[name="categoria"]:checked').val();
                        if (!selectedCategory) {
                            if (shouldPersist) {
                                sessionStorage.removeItem('buscarServicoCategoria');
                                sessionStorage.removeItem('buscarServicoServicos');
                            }

                            $('#selectedCategory').val('');
                            $('#selectedServices').val('');
                            return [];
                        }

                        var selectedServices = $('#services' + selectedCategory + ' input[type="checkbox"]:checked').map(function () {
                            return $(this).val();
                        }).get();

                        $('#selectedCategory').val(selectedCategory);
                        $('#selectedServices').val(selectedServices.join(','));

                        if (shouldPersist) {
                            sessionStorage.setItem('buscarServicoCategoria', selectedCategory);
                            sessionStorage.setItem('buscarServicoServicos', selectedServices.join(','));
                        }

                        return selectedServices;
                    }

                    function toggleServicesDisplay(selectedCategoryId, shouldPersist) {
                        if (typeof shouldPersist === 'undefined') {
                            shouldPersist = true;
                        }

                        $('.services').hide();
                        $('#services' + selectedCategoryId).show();
                        $('.services').not('#services' + selectedCategoryId).find('input[type=checkbox]').prop('checked', false);

                        if (shouldPersist) {
                            sessionStorage.setItem('buscarServicoCategoria', selectedCategoryId);
                            sessionStorage.removeItem('buscarServicoServicos');
                        }

                        updateSelectedServicesField(shouldPersist);
                    }

                    $(document).ready(function () {
                        var storedCategory = sessionStorage.getItem('buscarServicoCategoria');
                        var storedServicesRaw = sessionStorage.getItem('buscarServicoServicos');

                        if (storedCategory) {
                            var categoryRadio = $('input[name="categoria"][value="' + storedCategory + '"]');
                            if (categoryRadio.length) {
                                categoryRadio.prop('checked', true);
                                toggleServicesDisplay(storedCategory, false);

                                if (storedServicesRaw) {
                                    storedServicesRaw.split(',').forEach(function (serviceId) {
                                        if (serviceId) {
                                            $('#services' + storedCategory + ' input[value="' + serviceId + '"]').prop('checked', true);
                                        }
                                    });
                                }

                                updateSelectedServicesField(false);
                            } else {
                                sessionStorage.removeItem('buscarServicoCategoria');
                                sessionStorage.removeItem('buscarServicoServicos');
                            }
                        }

                        $('input[name="categoria"]').on('change', function () {
                            toggleServicesDisplay(this.value);
                        });

                        $('.services input[type="checkbox"]').on('change', function () {
                            updateSelectedServicesField();
                        });

                        $('#btnProximo').click(function (e) {
                            e.preventDefault();

                            var selectedCategory = $('input[name="categoria"]:checked').val();
                            if (!selectedCategory) {
                                Swal.fire({
                                    toast: true,
                                    text: 'Por favor selecione uma categoria antes de continuar',
                                    icon: 'info',
                                    confirmButtonColor: '#f08f00',
                                    confirmButtonText: 'Ok'
                                });
                                return;
                            }

                            var selectedServices = $('#services' + selectedCategory + ' input[type="checkbox"]:checked').map(function () {
                                return $(this).val();
                            }).get();

                            if (selectedServices.length === 0) {
                                Swal.fire({
                                    toast: true,
                                    text: 'Por favor selecione pelo menos um serviço antes de continuar',
                                    icon: 'info',
                                    confirmButtonColor: '#f08f00',
                                    confirmButtonText: 'Ok'
                                });
                                return;
                            }

                            updateSelectedServicesField();

                            var servicesParam = encodeURIComponent(selectedServices.join(','));
                            window.location.href = 'cadastro-solicitacao.aspx?Id=' + selectedCategory + '&Servicos=' + servicesParam;
                        });
                    });
                </script>
                <script>
                    let originalCategories = [];

                    function storeOriginalOrder() {
                        const faqItens = document.querySelector('.faq-itens');
                        originalCategories = Array.from(faqItens.children).map(category => category.outerHTML);
                    }

                    function sortCategories() {
                        const selectedOrder = document.getElementById('sortOrder').value;
                        const faqItens = document.querySelector('.faq-itens');
                        const categories = Array.from(faqItens.children);

                        console.log("Categorias antes da ordenação:", categories.map(category => category.querySelector('.category-label').textContent));

                        if (selectedOrder === 'alphabetical') {
                            categories.sort((a, b) => {
                                const nameA = a.querySelector('.category-label').textContent.toLowerCase();
                                const nameB = b.querySelector('.category-label').textContent.toLowerCase();
                                return nameA.localeCompare(nameB);
                            });
                            console.log("Categorias ordenadas alfabeticamente:", categories.map(category => category.querySelector('.category-label').textContent));
                        } else {
                            // Se "Relevância" for escolhido, retorna à ordem original
                            faqItens.innerHTML = ''; // Limpa o contêiner
                            originalCategories.forEach(originalCategory => {
                                faqItens.innerHTML += originalCategory; // Restaura a ordem original
                            });
                            return; // Sai da função após restaurar a ordem original
                        }

                        // Remove todas as categorias do contêiner e reapresenta na nova ordem
                        faqItens.innerHTML = '';
                        categories.forEach(category => {
                            faqItens.appendChild(category);
                        });
                    }

                    // Adicionar ouvinte de evento após o DOM ser carregado
                    document.addEventListener('DOMContentLoaded', function () {
                        storeOriginalOrder(); // Armazena a ordem original das categorias
                        const sortOrderDropdown = document.getElementById('sortOrder');
                        sortOrderDropdown.addEventListener('change', sortCategories);
                    });
                </script>


            </div>

        </div>
    </div>
  
</asp:Content>
