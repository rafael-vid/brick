<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cliente-dashboard.aspx.cs" Inherits="Bsk.Site.Cliente.cliente_dashboard" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash dashboard dash-cliente">

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/dados-icon.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Cotação</h2>
            </div>
            <div class="item_card">
                <div class="subtitulo_card">
                    <h3>Status</h3>
                    <img src="../assets/imagens/sino.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </div>
                <ul class="card_lista">

                    <% 
                        var cotacoes = PegaCotacoes();
                    %>
                                      


                                       <li>
                        <span class="numero_card"><%Response.Write(cotacoes.Where(x => x.Status == "1").ToList().Count().ToString()); %></span>
                        <p><a href="minhas-cotacoes.aspx?status=1">Em cotação</a></p>
                    </li>
                    
                    <li>
                        <span class="numero_card"><%Response.Write(cotacoes.Where(x => x.Status == "2").ToList().Count().ToString()); %></span>
                        <p><a href="minhas-cotacoes.aspx?status=2">Aguardando pagamento</a></p>
                    </li>

                    <li>
                        <span class="numero_card"><%Response.Write(cotacoes.Where(x => x.Status == "3").ToList().Count().ToString()); %></span>
                        <p><a href="minhas-cotacoes.aspx?status=3">Em andamento</a></p>
                    </li>
                    <!--
                    <li>
                        <span class="numero_card"><%Response.Write(cotacoes.Where(x => x.Status == "2").ToList().Count().ToString()); %></span>
                        <p><a href="minhas-cotacoes.aspx?status=4">Aguardando liberação do pagamento</a></p>
                    </li>   
                   
                    <li>
                        <span class="numero_card"><%Response.Write(cotacoes.Where(x => x.Status == "5").ToList().Count().ToString()); %></span>
                        <p><a href="minhas-cotacoes.aspx?status=5">Aguardando aceite</a></p>
                    </li>  
                        --> 
                    <li>
                        <span class="numero_card"><%Response.Write(cotacoes.Where(x => x.Status == "4").ToList().Count().ToString()); %></span>
                        <p><a href="minhas-cotacoes.aspx?status=4">Finalizado</a></p>
                    </li>   

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
