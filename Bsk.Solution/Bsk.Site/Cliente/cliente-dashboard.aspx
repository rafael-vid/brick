<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cliente-dashboard.aspx.cs" Inherits="Bsk.Site.Cliente.cliente_dashboard" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash dashboard dash-cliente">
         <a class="btn_card" href="buscar-servico.aspx" style="margin-left: 50px;">
             <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
             Nova Solicitação
         </a>
        <div class="acessos">
        </div>
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/dados-icon.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotação</h2>
            </div>
            <div class="item_card">
                <div class="subtitulo_1">
                    <h2>Status</h2>
                   
                </div>
                <ul class="card_lista">

                    <% 


                        var dash = GetDashboardCliente();
                        foreach(var d in dash)
                        {
                            var cot = PegaCotacoes(d.id);
                            if (d.id == 8 ||d.id == 1 || d.id == 2 || d.id == 3)
                            {
                                %>
                                    <li>
                                        <a href="minhas-cotacoes.aspx?status=<% Response.Write(d.id); %>"><span class="numero_card"><% Response.Write(cot.Count); %></span>
                                        <p><% Response.Write(d.nome); %> </a> </p>
                                    </li>
                                <%
                            }else if(d.id == 4 || d.id == 5 || d.id == 6)
                            {
                                %>
                                    <li>
                                        <a href="em-andamento.aspx"><span class="numero_card"><% Response.Write(cot.Count); %></span>
                                        <p><% Response.Write(d.nome); %> </a> </p>
                                    </li>
                                <%
                            }else if(d.id == 7)
                            {
                                %>
                                    <li>
                                        <a href="finalizadas.aspx"><span class="numero_card"><% Response.Write(cot.Count); %></span>
                                        <p><% Response.Write(d.nome); %> </a> </p>
                                    </li>
                                <%
                            }
                        }
                    %>
                                

                    <!-- Deixar apenas os 3 primeiros 
                    

                    <li>
                        <span class="numero_card">10%</span>
                        <p style="display: flex; gap: 3px;">
                            Economia Média
                            <img src="../assets/imagens/i.svg" alt="ícone"
                                style="width: 15px;">
                        </p>
                    </li>
                </ul>
            </div>

            <div class="item_card">
                <div class="subtitulo_card">
                    <h3>Áreas de Atuação</h3>
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                </div>
                <ul class="card_lista">
                    <li>
                        <span class="numero_card">01</span>
                        <p>Elétrica</p>
                    </li>
                    <li>
                        <span class="numero_card">05</span>
                        <p>Hidraulica</p>
                    </li>

                </ul>
            </div>

            <div class="item_card">
                <div class="subtitulo_card">
                    <h3>Orçamentos Recentes</h3>
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </div>
                <ul class="card_lista orcamento_lista">
                    <li>
                        <span class="numero_card orcamento">LA</span>
                        <div class="orcamento-empresa">
                            <p>Elétrica</p>
                            <span>Limpa Ar</span>
                        </div>

                        <div class="reais">
                            <span>R$</span>
                            <p>80</p>
                        </div>
                    </li>
                    <li>
                        <span class="numero_card orcamento">MJ</span>
                        <div class="orcamento-empresa">
                            <p>Portas</p>
                            <span>Marceneiro João</span>
                        </div>
                        <div class="reais">
                            <span>R$</span>
                            <p>78</p>
                        </div>
                    </li>
                    <li>
                        <span class="numero_card orcamento">MG</span>
                        <div class="orcamento-empresa">
                            <p>Portas</p>
                            <span>Marceneiro Gomes</span>
                        </div>
                        <div class="reais">
                            <span>R$</span>
                            <p>66</p>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="item_card">
                <a href="#" class="vertodos">ver todos</a>
            </div>

            <div class="item_card">
                <a class="btn_card" href="cadastro-cotacao.aspx">
                    <img src="../assets/imagens/lupa.png" alt="botão" style="width: 15px;">
                    Realizar nova cotação
                </a>
            </div>
        </div>

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/andamento.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Em Andamento</h2>
            </div>
            <div class="item_card">
                <div class="subtitulo_card">
                    <h3>Status</h3>
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </div>
                <ul class="card_lista">
                    <li>
                        <span class="numero_card">10</span>
                        <p>Aguardando início</p>
                    </li>
                    <li>
                        <span class="numero_card">02</span>
                        <p>Iniciado</p>
                    </li>
                    <li>
                        <span class="numero_card">05</span>
                        <p>Aguardando Pagamento</p>
                    </li>
                    <li>
                        <span class="numero_card">10</span>
                        <p>Aguardando Informação</p>
                    </li>
                </ul>
            </div>

            <div class="item_card">
                <div class="subtitulo_card">
                    <h3>Áreas de Atuação</h3>
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </div>
                <ul class="card_lista">
                    <li>
                        <span class="numero_card">01</span>
                        <p>Elétrica</p>
                    </li>
                    <li>
                        <span class="numero_card">05</span>
                        <p>Hidraulica</p>
                    </li>
                    <li>
                        <span class="numero_card">05</span>
                        <p>Limpeza</p>
                    </li>
                    <li>
                        <span class="numero_card">05</span>
                        <p>Marcenaria</p>
                    </li>
                </ul>
            </div>

            <div class="item_card">
                <a href="#" class="vertodos">ver todos</a>
            </div>

            <div class="item_card">
                <div class="subtitulo_card">
                    <h3>Seguro</h3>
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </div>
                <ul class="card_lista">
                    <li>
                        <span class="numero_card">01</span>
                        <p>Sem Seguro</p>
                    </li>
                    <li>
                        <span class="numero_card">05</span>
                        <p>Com Seguro</p>
                    </li>
                </ul>
            </div>

        </div>

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/financeiro.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Financeiro</h2>
            </div>
            <div class="item_card">
                <ul class="card_lista">
                    <li>
                        <span class="numero_card">10</span>
                        <p>Contas a pagar</p>
                    </li>
                    <li>
                        <span class="numero_card">02</span>
                        <p>Próximo Pagamento</p>
                    </li>
                    <li>
                        <span class="numero_card">05</span>
                        <p>Total a vencer nos próximos 60 dias</p>
                    </li>
                    <li>
                        <span class="numero_card">10%</span>
                        <p style="display: flex; gap: 3px;">
                            Economia Média
                            <img src="../assets/imagens/i.svg" alt="ícone"
                                style="width: 15px;">
                        </p>
                    </li>
                </ul>
            </div>

            <div class="item_card item_btn">
                <a class="btn_card" href="cadastro-cotacao.aspx">
                    <img src="../assets/imagens/financeiro-branco.svg" alt="botão" style="width: 15px;">
                    Quero Financiar
                </a>
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
            </div>
        </div>

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/documentacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Documentação</h2>
            </div>
            <div class="item_card">
                <ul class="card_lista no-grid">
                    <li>
                        <p>Dados Cadastrais</p>
                    </li>
                    <li>
                        <p>Histórico de Negociação</p>
                    </li>
                    <li>
                        <p>Acompanhamento do Serviços</p>
                    </li>
                    <li>
                        <p>Contratos</p>
                    </li>
                </ul>
            </div>

            <div class="item_card item_btn">
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                <a href="/" class="item_notifica">
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
            </div>
        </div>
                        </div>
    </section>
                        -->

    <style>
        a.dash {
            background: #f4f3f2;
            color: #770e18 !important;
        }
    </style>
</asp:Content>
