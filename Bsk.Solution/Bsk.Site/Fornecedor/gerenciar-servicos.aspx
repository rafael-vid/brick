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
    <div id="adicionados" style="display: none;"></div>
    <div id="removidos" style="display: none;"></div>

    

    <div class="conteudo-dash atuacao">

        <div class="subtitulo_card subtitulo_1" style="position: relative;">
            <img src="../assets/imagens/atuacao.svg" alt="ícone" style="width: 20px;">
            <h2 class="subtitulo_1">Serviços disponíveis</h2>
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
                    <h2><%= item.Nome %></h2>
                    <ul class="nested-list">
                        <% var servicostodos = PegaServicoTodos(item); %> <!-- Keep the function to fetch services -->
                        <% foreach (var j in servicostodos) { %>
                            <% var checkboxId = "checkbox_" + checkboxCounter; %>
                            <% 
                                var checkboxValue = j.IdServico + "; " + item.IdCategoria; // Concatenate service ID with category ID
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
            <a class="btn_card2" id="atualizarDados" onclick="atualizarDados()">Atualizar dados</a> 
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

    </div>
    

</asp:Content>
