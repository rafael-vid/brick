<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="meus-cartoes.aspx.cs" Inherits="Bsk.Site.Cliente.meus_cartoes" MasterPageFile="~/Cliente/Master/Layout.Master" %>

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
    <div class="card-tabela " style="overflow-x: auto;">
    
    <table id="tabela" class="table table-condensed table-responsive table-striped table-hover tabela-mobile">
        <thead id="cabecalho-tabela">
            <tr>
                <th>Nome do Cartão </th>
                <th>Nome do Titular</th>
                <th>Número</th>
                <th>Data de Validade</th>
                <th>CVV</th>
                <th></th>
            </tr>
        </thead>

        <tbody>
            <%var cartoes = PegaCartoes();
            
                
            %>
            <asp:Repeater ID="rptCartoes" runat="server">
    <ItemTemplate>
        <tr>
            <td><%# Eval("NomeCartao") %></td>
            <td><%# Eval("NomeTitular") %></td>
            <td><%# Eval("NumeroCartao") %></td>
            <td><%# Eval("MesExpiracao") %>/<%# Eval("AnoExpiracao") %></td>
            <td><%# Eval("CVV") %></td>
            <td>
                <asp:LinkButton 
                    ID="btnRemover" 
                    runat="server" 
                    CssClass="btn btn-danger btn-sm" 
                    Style="width:70px; line-height:1;" 
                    CommandArgument='<%# Eval("Id") %>' 
                    OnClick="RemoverCartao">Remover</asp:LinkButton>
            </td>
        </tr>
    </ItemTemplate>
</asp:Repeater>

        </tbody>
    </table>


</div>
 <form id="formCartao">

    <div class="item_content_card">
        <h2 class="subtitulo_card_1 subtitulo_1">Nome do Cartão</h2>
        <input type="text" name="holder-name" class="card-input-add" id="nomeCartao" runat="server">
    </div>
    <div class="item_content_card">
        <h2 class="subtitulo_card_1 subtitulo_1">Nome do Titular</h2>
        <input type="text" name="card-name" class="card-input-add" id="nomeTItular" runat="server">
    </div>
    <div class="item_content_card">
        <h2 class="subtitulo_card_1 subtitulo_1">Número do Cartão</h2>
        <input type="text" class="card-input-add" id="numeroCartao" maxlength="19" runat="server" ClientIDMode="Static" oninput="mascaraCartao(this)">
    </div>
    <div class="item_content_card">
        <h2 class="subtitulo_card_1 subtitulo_1">Mês</h2>
        <input type="text" name="card-exp-month" class="card-input-add" id="mes" runat="server">
    </div>
    <div class="item_content_card">
        <h2 class="subtitulo_card_1 subtitulo_1">Ano</h2>
        <input type="text" name="card-exp-year" class="card-input-add" id="ano" runat="server">
    </div>
    <div class="item_content_card">
        <h2 class="subtitulo_card_1 subtitulo_1">CVV</h2>
        <input type="text" name="cvv" class="card-input-add" id="codigo" runat="server">
    </div>
    <button runat="server" type="submit" id="btnAdicionar" class="btn_card" onserverclick="btnAdicionar_ServerClick">Adicionar</button>
</form>
</asp:Content>
