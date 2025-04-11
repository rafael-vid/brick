<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="minhas-cotacoes.aspx.cs" Inherits="Bsk.Site.Fornecedor.minhas_cotacoes" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <div class="conteudo-dash cotacao">
        <div class="acessos">
            <a href="minhas-cotacoes.aspx" class="btn_card">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">Buscar nova cotação
            </a>
            <a href="em-andamento.aspx" class="btn_card">Cotações em negociação</a>
            <a href="minhas-areas.aspx" class="btn_card">Minhas áreas de atuação</a>
            <div class="total_a_receber total_a_receber-new">
                <span>Total a receber</span>
                <p>
                    <span id="totalReceber" runat="server"></span>
                </p>
                <div class="eleva_sifra eleva_sifra-new">
                    <svg width="16" height="24" viewBox="0 0 16 21" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path
                            d="M2.32003 19.05C3.39875 19.8816 4.66035 20.4439 6.00003 20.69V21.8C6.00266 22.1324 6.13657 22.4503 6.37258 22.6844C6.60859 22.9186 6.92759 23.05 7.26004 23.05H8.82003C8.98502 23.0513 9.14863 23.0199 9.30145 22.9577C9.45426 22.8955 9.59325 22.8036 9.71038 22.6874C9.82752 22.5712 9.92047 22.4329 9.98391 22.2806C10.0474 22.1283 10.08 21.9649 10.08 21.8V20.69C11.1751 20.5061 12.2224 20.1049 13.16 19.51C13.9004 19.0616 14.5118 18.4287 14.9342 17.6732C15.3567 16.9177 15.5758 16.0655 15.57 15.1999C15.6258 14.1098 15.2688 13.0386 14.57 12.1999C13.3873 10.9185 11.7828 10.1057 10.05 9.90995V8.03996C10.1898 8.13104 10.3235 8.23125 10.45 8.33995C10.7268 8.58046 11.0835 8.70886 11.45 8.69995C11.6973 8.6867 11.9392 8.622 12.16 8.50996H12.21L13.96 7.40995C14.128 7.32534 14.2687 7.19508 14.366 7.03411C14.4633 6.87315 14.5132 6.688 14.51 6.49995C14.5157 6.35127 14.4881 6.20321 14.4293 6.06654C14.3705 5.92987 14.2819 5.80805 14.17 5.70996C13.0984 4.49587 11.6581 3.66682 10.07 3.34995V2.03996C10.0714 1.87412 10.0397 1.70966 9.97683 1.55619C9.91398 1.40272 9.82121 1.26329 9.70394 1.14602C9.58668 1.02875 9.44726 0.935997 9.29379 0.873148C9.14032 0.810299 8.97586 0.778615 8.81002 0.779948H7.25003C6.91585 0.779948 6.59536 0.912701 6.35906 1.149C6.12277 1.38529 5.99002 1.70578 5.99002 2.03996V3.29995C5.32019 3.41035 4.66789 3.60873 4.05001 3.88995C1.80001 4.88995 0.680026 6.47995 0.720026 8.54995C0.727931 9.52861 1.0505 10.4788 1.64004 11.26C2.72883 12.5981 4.28926 13.4678 6.00003 13.69V16.3899C5.33113 16.0325 4.72895 15.5623 4.22003 14.9999C4.10419 14.8448 3.95309 14.7194 3.7792 14.6342C3.60531 14.549 3.41363 14.5064 3.22003 14.51C3.00158 14.5286 2.78822 14.5862 2.59002 14.68V14.68L1.00003 15.6099C0.814799 15.7017 0.659817 15.8448 0.553461 16.022C0.447106 16.1993 0.393838 16.4033 0.400019 16.6099C0.406865 16.8674 0.502238 17.1146 0.670038 17.3099C1.13357 17.9662 1.68928 18.5523 2.32003 19.05V19.05ZM1.32003 16.35L2.89004 15.43C2.98284 15.3863 3.08005 15.3528 3.18002 15.33C3.2503 15.3274 3.32009 15.3426 3.38299 15.374C3.44589 15.4055 3.49989 15.4522 3.54003 15.51C4.26398 16.3372 5.18116 16.9727 6.21002 17.3599C6.26658 17.3915 6.33026 17.408 6.39501 17.408C6.45977 17.408 6.52345 17.3915 6.58001 17.3599C6.63291 17.3228 6.67602 17.2733 6.70562 17.2159C6.73523 17.1584 6.75047 17.0946 6.75003 17.0299V13.3599C6.7487 13.2626 6.71275 13.1689 6.64862 13.0956C6.58449 13.0223 6.49636 12.9742 6.40002 12.96C4.78022 12.8235 3.28063 12.0504 2.23004 10.8099C1.74067 10.166 1.47709 9.37875 1.48004 8.56996C1.48004 6.82996 2.38001 5.56995 4.33001 4.66995C4.98844 4.37782 5.68566 4.18246 6.40002 4.08995C6.49806 4.07545 6.58754 4.02593 6.65188 3.95056C6.71623 3.87518 6.75109 3.77906 6.75003 3.67996V2.07995C6.75 1.96232 6.79602 1.84935 6.87826 1.76524C6.9605 1.68113 7.07242 1.63257 7.19003 1.62995H8.75002C8.86937 1.62995 8.98384 1.67737 9.06823 1.76176C9.15262 1.84615 9.20004 1.9606 9.20004 2.07995V3.68995C9.19857 3.78495 9.23097 3.87737 9.29144 3.95066C9.3519 4.02395 9.43647 4.07333 9.53002 4.08995C11.0793 4.32052 12.4966 5.09296 13.53 6.26995V6.26995C13.5595 6.29012 13.5839 6.31689 13.6013 6.34814C13.6186 6.37938 13.6285 6.41424 13.63 6.44995C13.63 6.44995 13.63 6.57995 13.45 6.68995L11.72 7.77995C11.6153 7.82874 11.5042 7.86241 11.39 7.87995V7.87995C11.2192 7.88492 11.0523 7.82811 10.92 7.71995C10.5746 7.41348 10.1874 7.1576 9.77001 6.95996C9.71012 6.92757 9.64313 6.91061 9.57504 6.91061C9.50695 6.91061 9.43992 6.92757 9.38003 6.95996C9.32187 6.99802 9.27406 7.04992 9.2409 7.111C9.20774 7.17209 9.19026 7.24044 9.19003 7.30995V10.24C9.18896 10.3391 9.22383 10.4352 9.28817 10.5106C9.35252 10.5859 9.44199 10.6355 9.54003 10.65C11.1969 10.7675 12.7493 11.5026 13.89 12.71C14.4463 13.3858 14.7282 14.246 14.68 15.1199C14.6846 15.8526 14.4979 16.5738 14.1384 17.2122C13.7788 17.8506 13.2589 18.3841 12.63 18.76C11.6925 19.3585 10.6336 19.7411 9.53002 19.88C9.4329 19.8946 9.34456 19.9445 9.28185 20.0201C9.21915 20.0957 9.18647 20.1918 9.19003 20.29V21.74C9.18741 21.8576 9.13885 21.9695 9.05474 22.0517C8.97063 22.1339 8.85765 22.18 8.74002 22.18H7.18002C7.06332 22.18 6.95141 22.1336 6.86889 22.0511C6.78638 21.9686 6.74002 21.8566 6.74002 21.74V20.29C6.73908 20.194 6.70457 20.1015 6.64245 20.0284C6.58033 19.9553 6.49453 19.9063 6.40002 19.8899C5.08305 19.683 3.8387 19.1502 2.78002 18.3399C2.17612 17.8966 1.64334 17.3639 1.20004 16.76V16.76C1.14929 16.7097 1.12051 16.6414 1.12002 16.57C1.12002 16.57 1.12003 16.46 1.32003 16.35V16.35Z"
                            fill="#770e18" />
                        <path
                            d="M6.77998 7.29999C6.77923 7.23307 6.76252 7.16731 6.73121 7.10817C6.6999 7.04903 6.65491 6.99823 6.59999 6.95999C6.54161 6.92848 6.47632 6.91199 6.40998 6.91199C6.34365 6.91199 6.27836 6.92848 6.21998 6.95999H6.09999C5.76854 7.07407 5.48075 7.28838 5.2765 7.57326C5.07225 7.85813 4.96163 8.19946 4.95997 8.54999V8.54999C4.95859 8.93682 5.08397 9.31345 5.31694 9.62227C5.5499 9.93109 5.87764 10.1551 6.24998 10.26C6.29608 10.2703 6.3439 10.2703 6.39 10.26C6.47136 10.2565 6.55049 10.2325 6.61998 10.19C6.67432 10.1512 6.71889 10.1003 6.75013 10.0412C6.78138 9.98223 6.79843 9.91675 6.79997 9.84999L6.77998 7.29999ZM5.95997 9.15999C5.81831 8.9967 5.74334 8.78606 5.74998 8.56999C5.74593 8.36932 5.82141 8.17519 5.95997 8.02998V9.15999Z"
                            fill="#770e18" />
                        <path
                            d="M9.40997 17.29C9.47427 17.3356 9.55116 17.3601 9.62997 17.36C9.68567 17.3749 9.74426 17.3749 9.79996 17.36C9.93483 17.3033 10.0652 17.2365 10.19 17.16C10.5298 16.971 10.8123 16.6938 11.0076 16.3576C11.203 16.0215 11.304 15.6388 11.3 15.25C11.3049 14.8068 11.1531 14.3761 10.8713 14.0339C10.5895 13.6917 10.1959 13.4602 9.75998 13.38C9.69769 13.3622 9.63223 13.3583 9.56827 13.3687C9.50431 13.379 9.44343 13.4034 9.38998 13.44C9.3401 13.4793 9.29975 13.5295 9.27203 13.5866C9.24432 13.6438 9.22996 13.7065 9.22998 13.77V16.99C9.2353 17.0504 9.25425 17.1088 9.28543 17.1607C9.31661 17.2127 9.3592 17.2569 9.40997 17.29V17.29ZM10.04 14.37C10.1853 14.4547 10.3043 14.5781 10.3837 14.7264C10.4632 14.8747 10.4999 15.0421 10.49 15.21C10.4904 15.3991 10.4504 15.5861 10.3728 15.7586C10.2952 15.931 10.1818 16.0849 10.04 16.21V14.37Z"
                            fill="#770e18" />
                    </svg>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/dados-icon.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotações</h2>
            </div>
            <div class="filtros_card">

                <div class="select-card">
                    <select onchange="filtraTabela();" id="slcStatus">
                        <option value="0">Selecione um status</option>
                        <% 
                            var itens = GetDashboardParticipante();

                            foreach(var i in itens)
                            {
                                %>
                                    <option value="<% Response.Write(i.id); %>" <% if (Request.QueryString["status"] != null && Request.QueryString["status"] == i.id.ToString()) { Response.Write("selected"); }  %> ><% Response.Write(i.nome); %></option>
                                <%
                            }

                            %>


                    </select>
                </div>
            </div>

            <onload >

            <div class="card-tabela " style="overflow-x: auto;">
                <table id="tabela" data-order='[[ 4, "asc" ]]' class="table table-condensed table-responsive table-striped table-hover">
                    <thead id="cabecalho-tabela">
                        <tr>
                            <td>Nº Cotação</td>
                            <td>Título</td>
                            <td>Nome cliente</td>
                            <td>Última atualização</td>
                            <td>Status</td>
                        </tr>
                    </thead>

                     <tbody>
                    <%var cotacoes = PegaCotacoes();
                        foreach (var item in cotacoes)
                        {
                            string link = "";

                                link = "cotacao.aspx?Cotacao=" + item.CotacaoId;
                            
                            if(item.Status == "2")
                            {
                                link = "negociar-cotacao.aspx?Id=" + item.IdFornecedorDB;
                            }

                            if (item.IdFornecedorDB != 0)
                            {
                                link = "negociar-cotacao.aspx?Id=" + item.IdFornecedorDB;
                            }

                    %>
                    <tr class="cursor" onclick="redirecionar('<%Response.Write(link); %>')">
                        <td><%Response.Write(item.CotacaoId); %><span style="color: red;"><%Response.Write(item.Mensagens); %></span></td>
                        <td><%Response.Write(item.Titulo); %></td>
                        <td><%Response.Write(item.Nome); %></td>
                        <td><%Response.Write(item.DataAlteracao); %></td>
                        <td>
                            <%Response.Write(item.StatusNome); %>
                            
                        </td>
                        <%-- <td>
                            <%if (item.Status == "Recusado")
                                {%>
                            <center>-</center>
                            <%}
                                else if (item.Status == "Aberto")
                                {%>
                            <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdFornecedorDB); %>">Negociar</a>
                            <%}
                                else if (item.Status == "Aguardando pagamento")
                                {%>
                            <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdFornecedorDB); %>">Mensagens</a>

                            <%}
                                else if (item.Status == "Em andamento")
                                {%>
                            <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdFornecedorDB); %>">Mensagens</a>

                            <%}
                                else if (item.Status == "Pendente de finalização do cliente")
                                {%>
                            <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdFornecedorDB); %>">Mensagens</a>

                            <%}
                                else if (item.Status == "Finalizado")
                                {%>
                            <a class="btn btn-brikk" href="cotacao.aspx?Cotacao=<%Response.Write(item.CotacaoId); %>">Visualizar</a>
                            <a class="btn btn-brikk" href="negociar-cotacao.aspx?Id=<%Response.Write(item.IdFornecedorDB); %>">Mensagens</a>
                            <a class="btn btn-brikk" href="avaliar.aspx?Id=<%Response.Write(item.IdFornecedorDB); %>">Avaliação</a>
                            <%} %>                              
                        </td>--%>
                    </tr>
                    <%  }
                    %>
                </tbody>
                </table>
            </div>

         

            <div class="footer_card">
                <a href="dashboard.aspx" class="voltar btn"><< voltar
                </a>
                <!--
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                -->
            </div>

        </div>
    </div>

    <style>
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }

        div#tabela_paginate > span {
            display: flex
        }

        .total_a_receber-new {
            width: 185px;
            padding-top: 10px;
        }

        .eleva_sifra-new {
            top: 4px;
            left: 5px;
        }
        @media (max-width: 768px) {
            div#tabela_filter {
                /* position: relative; */
                display: flex;
                /* right: 0; */
                /* margin-top: 30px; */
                margin-bottom: 40px;
            }
            div#tabela_filter::before {
                content: '🔍︎';
                z-index: 400;
                position: absolute;
                display:flex;
                bottom: 10px;
                top: -30px;
                /* display: block; */
            }
            .conteudo-dash {
                padding: 15px 0px;
            }
            div#tabela_filter input[type="search"], .dataTables_length label {
                width: 100% !important;
            }
            div#tabela_filter input[type="search"] {
                height: 40px;
                margin: -40px 40px 30px -10px !important;
            }
        }

    </style>

    <script>
        function redirecionar(valor) {
            window.location.href = valor;
        }

        function filtraTabela() {
            var table = $('#tabela').DataTable();

            if ($("#slcStatus").val() == "0") {
                table.search("").draw();
            } else if ($("#slcStatus").val() == "1") {
                table.search("Aguardando Cotação").draw();
            } else if ($("#slcStatus").val() == "2") {
                table.search("Em cotação").draw();
            } else if ($("#slcStatus").val() == "3") {
                table.search("Aguardando pagamento").draw();
            } else if ($("#slcStatus").val() == "4") {
                table.search("Em andamento").draw();
            } else if ($("#slcStatus").val() == "5") {
                table.search("Pendente de finalização do cliente").draw();
            } else if ($("#slcStatus").val() == "6") {
                table.search("Finalizado").draw();
            }
        }
    </script>
    <body onload="filtraTabela()">
</asp:Content>

