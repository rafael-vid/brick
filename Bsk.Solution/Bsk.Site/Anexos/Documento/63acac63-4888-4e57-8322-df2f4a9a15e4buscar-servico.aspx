

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="TUDO EM SUAS MÃOS! MANUTENÇÃO RÁPIDA, SEGURA E SEM DOR DE CABEÇA " />
    <meta name="keywords" content="plataforma de contratação, manutenção, serviços, equipamentos" />

    <title>BRIKK </title>
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/dashboard.css">
    
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    

    
     <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
    />


    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Bootstrap JavaScript 
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>-->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <!-- Outros scripts -->

    <script src="js/jquery.mask.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="sweetalert2.all.min.js"></script>
    <script src="js/rating.js"></script>
    <script src="js/wow.js"></script>
    <script src="js/master.js"></script>
    <script src="js/comum.js"></script>

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.3/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    <style>

        .acessos{
            display:flex;
            justify-content:space-evenly;
            flex-wrap:wrap;
            grid-gap:30px !important;
        }
        .acessos .btn_card{
            width:250px;
        }
        .menu-topo {
            display: flex;
            align-items: center;
            justify-content: space-between !important;
        }
        .menu{
            flex:0 !important;
            position:absolute;
            right:70px;
        }
        .menu-topo > a{
            position:absolute;
            left:70px;
        }
        .perfil > img{
            width:57px;
            height:57px;
            object-fit:cover;
        }
        a{
            text-decoration:none !important;
        }
        .lupa {
            right: 40px;
        }
        footer{
            display:flex !important;
        }
        .btn{
            border-radius:20px !important;
        }
        .btn {
            display: inline-flex;
        }
      
        @media (max-width: 1151px){
            #nav.active ul {
                height: calc(100vh - 120px);
                visibility: visible;
                overflow-y: auto;
            }
            .menu ul {
                display: block !important;
                position: absolute !important;
                width: 100% !important;
                top: 120px !important;
                right: 0 !important;
                background: #770e18;
                z-index: 100;
                transition: 0.3s !important;
                visibility: hidden;
                overflow-y: hidden;
            }
        }
        

        /*------------------*/

div#tabela_filter {
    position: absolute;
    right: 300px;
    top: -20px;
}

    div#tabela_filter input[type="search"] {
        height: 55px;
        width: 340px;
        position: absolute;
        margin-left: -78px;
        background: #d7d7d7;
        border-radius: 30px;
        border: 0;
        outline: none;
        top:-20px !important;
        box-shadow: 4px 4px 6px rgb(0 0 0 / 30%);
        padding: 15px 35px;
        color: #3c3c3b;
        font-family: Rajdhani-semi, sans-serif;
        font-size: 16px;
    }

    div#tabela_filter::before {
        content: '🔍︎';
        z-index: 400;
        position: absolute;
        top: 0;
        display: block;
        left: 10px;
    }


.dataTables_wrapper {
    position: relative;
}

.dataTables_length {
    margin-top: 50px;
    position: relative;
}

.dataTables_length label {
    width: 250px !important;
    background: #d7d7d7;
    font-family: Rajdhani-semi, sans-serif;
    border-radius: 15px;
    font-size: 16px;
    display: flex !important;
    height: 30px;
    align-items: center !important;
    justify-content: space-around;
}

.dataTables_length label select {
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    color: #fff;
    background: #f08f00;
    position: absolute;
    z-index: 200;
    left: 0px;
    border-radius: 50%;
    outline: none;
    text-align: center;
    border: none;
}

.dataTables_info {
    font-size: 13px;
    color: #770e18;
    font-family: Rajdhani-semi, sans-serif;
    display: flex;
    justify-content: flex-start;
}

div#tabela_paginate {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    font-family: Rajdhani-semi, sans-serif;
    font-size: 13px;
    margin-top:-20px;
}

a#tabela_previous, a#tabela_next {
    color: #770e18 !important;
    background: #efefef;
    padding: 1px 10px;
    cursor: pointer;
    transition: filter .4s
}

a#tabela_previous:hover, a#tabela_next:hover {
    filter: brightness(80%)
}

div#tabela_paginate span a {
    font-size: 18px;
    color: #fff !important;
    font-weight: bold;
    background: #f08f00;
    border-radius: 50%;
    width: 35px;
    justify-content: center;
    display: flex;
    align-items: center;
    height: 35px;
    margin: 0 10px;
}

@media (max-width:1000px){
    .dataTables_length{
        display:flex;
        flex-direction:column;
        position:static;
    }
    div#tabela_filter {
        position: relative;
        right:0;
        margin-top: 30px;
        margin-left: 20px;
        margin-bottom:20px
    }
    div#tabela_filter input[type="search"], .dataTables_length label{
        width:50%;
    }
}

@media (max-width:780px) {
    div#tabela_filter input[type="search"], .dataTables_length label{
        width:100% !important;
    }
    div#tabela_paginate {
        justify-content: flex-start;
        margin-top: 20px;
    }
}
/* CAPITALIZAÇÃO DO NOME PRÓPRIO*/
 .uppercase {
     text-transform: capitalize;

        }
/*---------------*/

    </style>

</head>
<body>

    <header>
        <div class="menu-topo container">
            <a href="cliente-dashboard.aspx" >
                <img src="../assets/imagens/logo.png" alt="BRIKK logomarca" class="logo">
            </a>
            <nav class="menu" id="nav">
                <button id="btn-mobile">
                    Menu
          <span id="hamburger"></span>
                </button>
                <ul class="menu-itens">

                    <li data-dropdow-perfil class="data-dropdow-perfil">
                        <div class="perfil">
                            <img src="../assets/imagens/avatar.png" alt="avatar">
                            
                            <span class="uppercase">Olá, Harry.</span>
                        </div>
                        <ul class="dropdown-perfil">
                            <li>
                                <a href="perfil.aspx">
                                    <img style="width: 15px;" src="../assets/imagens/cotacao.svg" alt="ícone">
                                    Meus Dados
                                </a>
                            </li>
                            <!--<li>
                                <a href="configuracao.aspx">
                                    <img style="width: 15px;" src="../assets/imagens/cotacao.svg" alt="ícone">
                                    Configurações
                                </a>
                            </li>-->
                            <li>
                                <a href="/Geral/logout.aspx">
                                    <img style="width: 15px;" src="../assets/imagens/cotacao.svg" alt="ícone">
                                    Sair
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>

            </nav>


        </div>

        <div class="filtro">
            <div class="container" style="display:none">
                <input type="text" id="catSelBusca" placeholder="Qual serviço você precisa?      ">
                <img src="../assets/imagens/lupa.png" alt="lupa" class="lupa" style="width: 20px; height: 20px;" onclick="buscaCats();">
            </div>
        </div>
    </header>

    <section class="app">

        <nav class="menu-dashboard">
            <a class="open-menu"><img src="../assets/imagens/seta-esquerda.png" style="width: 20px; margin-right: 6px;" alt="ícone"> 
            </a>
            <ul class="menu-dash">
                <li>
                    <a href="cliente-dashboard.aspx" class="dash">
                        <img src="../assets/imagens/dashboard.svg" style="width: 20px;" alt="ícone">
                        <span>Dashboard</span>
                    </a>
                </li>
                <!--
                <li><a href="builts.html" class="asbuilt">
                    <img src="../assets/imagens/oportunidades.svg" style="width: 20px;" alt="ícone"><span>As Built</span></a>
                </li>
                -->
                <li style="display:none"><a href="manutencao.html" class="plano_manutencao">
                    <img src="../assets/imagens/meubrikk.svg" style="width: 20px;" alt="ícone"><span>Plano
                  Manutenção</span></a>
                </li>
                <li><a href="minhas-cotacoes.aspx" class="cotacao">
                    <img src="../assets/imagens/cotacao.svg" style="width: 20px;" alt="ícone"><span>Em Cotação</span></a>
                </li>
                <li><a href="em-andamento.aspx" class="andamento">
                    <img src="../assets/imagens/andamento.svg" style="width: 20px;" alt="ícone"><span>Em Andamento</span></a>
                </li>
                <li><a href="finalizadas.aspx" class="finalizada">
                    <img src="../assets/imagens/andamento.svg" style="width: 20px;" alt="ícone"><span>Finalizado</span></a>
                </li>
                <!--
                <li><a href="financeiro.html" class="financeiro">
                    <img src="../assets/imagens/financeiro.svg" style="width: 20px;" alt="ícone"><span>Financeiro</span></a>
                </li>
                    -->
                <li style=""><a href="notificacoes.aspx" class="notificacoes">
                    <img src="../assets/imagens/documentacao.svg" style="width: 20px;" alt="ícone"><span>Notificações</span></a>
                </li>

                <li style="display:none"><a href="documentacao.html" class="documentacao">
                    <img src="../assets/imagens/documentacao.svg" style="width: 20px;"
                        alt="ícone"><span>Documentação</span></a>
                </li>
            </ul>

            <!--
            <ul class="infos-dash">
                <li>
                    <a href="#">
                        <img src="../assets/imagens/calendario.svg" alt="ícone" style="width: 20px;">
                        <span>Calendário</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="../assets/imagens/central.svg" alt="ícone" style="width: 20px;">
                        <span>Central de Comunicação</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <img src="../assets/imagens/notifica.svg" alt="ícone" style="width: 20px;">
                        <span>Notificação</span>
                    </a>
                </li>
            </ul> -->
        </nav>



        <form method="post" action="./buscar-servico.aspx" id="form1">
<div class="aspNetHidden">
<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="ealF9Q/6hLDrtwmluHWCVDSrLGcjuDIK0x1VPyksrOX0hbz0kKN5R0i6kXiG3MweUSCX3WPJEJLWZS0dt/KjtXPUTgyzD23JV2qyCQLGrHs=" />
</div>

<div class="aspNetHidden">

	<input type="hidden" name="__VIEWSTATEGENERATOR" id="__VIEWSTATEGENERATOR" value="69E89C4D" />
</div>
            
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
            .item-faq label {
                font-size: 17px;
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

        .categoria-nome {
            display: block !important;
            font-size: 24px;
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
                
                <div class="item-faq">
                    <span class="categoria-nome">Elétrica</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="1" />Iluminação interna
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="1" />Fiação e tomadas
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="1" />Quadro e disjuntores
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="1" />Iluminação externa
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Hidráulica</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="2" />Torneiras, registros e válvulas
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="2" />Vazamentos e infiltrações
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="2" />Caça-vazamentos
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="2" />Vasos e banheiras
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Informática</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="3" />Redes, cabeamento e WiFi
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="3" />Computadores
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="3" />Videogames
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Estacionamento</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="4" />Manobrista e valet
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="4" />Gestão e Administração
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Jardim</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="5" />Manutenção de áreas verdes
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="5" />Paisagismo - projeto e execução
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Limpeza</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="6" />Faxina
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="6" />Limpeza de vidros
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="6" />Limpeza pós-obras
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Piscina</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="7" />Manutenção
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="7" />Limpeza pesada
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Segurança</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="8" />Portaria e Recepção
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="8" />Vigia
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="8" />Controle de Acesso
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="8" />Instalação de CFTV
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="8" />Manutenção de CFTV
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Ar-condicionado</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="9" />Instalação
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="9" />Limpeza
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="9" />Manutenção
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Civil</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="10" />Pequenos reparos
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="10" />Gesso
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Decoração</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="11" />Projeto e execução
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Linha branca</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="12" />Manutenção e consertos
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="12" />Instalação
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Telhados</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="13" />Limpeza de calhas e rufos
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="13" />Conserto
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="13" />Reforma
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Organização</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="14" />Closet
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="14" />Outros
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Esquadrias e Vidros</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="15" />Portas
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="15" />Janelas
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="15" />Box
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="15" />Espelhos
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Pisos e tampos</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="16" />Madeira
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="16" />Porcelanato
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="16" />Pedras
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="16" />Carpetes
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Chaveiro</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="17" />Instalação
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="17" />Abertura e conserto
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Marcenaria</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="18" />Projeto e execução
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="18" />Manutenção e consertos
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Pintura</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="19" />Interna
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="19" />Externa
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
                <div class="item-faq">
                    <span class="categoria-nome">Serralheria</span>
                    <div class="checkbox-wrapper">
                        
                               <div>
                                   <input type="radio" name="rdo" value="20" />Projeto e execução
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="20" />Manutenção e consertos
                               </div> 
                                
                           
                               <div>
                                   <input type="radio" name="rdo" value="20" />Portões automáticos
                               </div> 
                                
                           
                        
                    </div>
                </div>
                
                
           
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
                    $('#btnProximo').click(function () {
                        window.location.href = "cadastro-cotacao.aspx?Id=" + $('input[name=rdo]:checked').val();
                    })
</script>
            </div>

        </div>
    </div>
  

        </form>
    </section>

    <footer>
        <a href="/">
            <img src="../assets/imagens/logo-footer.png" alt="logomarca" style="width: 152px;"></a>
        <div>
            <a href="#">
                <img src="../assets/imagens/facebook.png" alt="facebook " style="width: 42px;">
            </a>
            <a href="#">
                <img src="../assets/imagens/instagram.png" alt="instagram" style="width: 42px;"></a>
            <a href="#">
                <img src="../assets/imagens/whatsapp.png" alt="whatsapp" style="width: 42px;"></a>
        </div>
    </footer>

     <script>

         function menuActive() {
             const links = document.querySelectorAll(".menu-dash li a");

             const handleLink = (event) => {
                 links.forEach((link) => {
                     link.classList.remove("dash-ativo");
                 });
                 event.currentTarget.classList.add("dash-ativo");
             };

             links.forEach((link) => {
                 link.addEventListener("click", handleLink);
             });
         }
         menuActive();
     </script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <script>
        AOS.init();
    </script>

   

    <script async src="../assets/js/script.js"></script>
    <script>

        function buscaCats() {
            window.location.href = "buscar-servico.aspx?CatSel=" + $("#catSelBusca").val();
        }

        $(function () {

            $('input.logoCliente').change(function () {
                const file = $(this)[0].files[0];
                const fileReader = new FileReader();
                fileReader.onloadend = function () {
                    $('.logoImg').attr('src', fileReader.result);
                }
                fileReader.readAsDataURL(file);
            });

        });
        $(document).ready(function () {


            $('.btn-carrega').click(function () {
                $('input.logoCliente').click();
            });

            $('#tabela').DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json"
                },
                "order": [[3, 'desc']],
            });
        });

        function carregaMinhasCotacoes() {
            var url = window.location.href;

            if (url.includes("cadastro-cotacao.aspx")) {
                salvarCotacaoLink("minhas-cotacoes.aspx");
            } else {
                window.location.href = "minhas-cotacoes.aspx";
            }
        }

        function carregaNovaCotacao() {
            var url = window.location.href;
            if (url.includes("cadastro-cotacao.aspx")) {
                salvarCotacaoLink("buscar-servico.aspx");
            }
            else {
                window.location.href = "buscar-servico.aspx";
            }
        }

        function carregaPerfil() {
            var url = window.location.href;
            if (url.includes("cadastro-cotacao.aspx")) {
                salvarCotacaoLink('perfil.aspx');
            }
            else {
                window.location.href = "perfil.aspx";
            }
        }

        function salvarCotacaoLink(valor) {
            Swal.fire({
                title: 'Salvar?',
                text: "Cuidado, ao sair dessa página você vai perder todo conteúdo não salvo",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Salvar e sair',
                cancelButtonText: 'Sair sem salvar'
            }).then((result) => {
                if (result.value) {
                    document.getElementById("hdLink").value = valor;
                    $("#btnSalvar").click();

                } else {
                    window.location.href = valor;
                }
            })
        }
    </script>


    <!--Start of Tawk.to Script-->
    <script type="text/javascript">
        var Tawk_API = Tawk_API || {}, Tawk_LoadStart = new Date();
        (function () {
            var s1 = document.createElement("script"), s0 = document.getElementsByTagName("script")[0];
            s1.async = true;
            s1.src = 'https://embed.tawk.to/5f5a9b264704467e89edf3c3/default';
            s1.charset = 'UTF-8';
            s1.setAttribute('crossorigin', '*');
            s0.parentNode.insertBefore(s1, s0);
        })();
    </script>

    
    <!--End of Tawk.to Script-->
</body>
</html>







