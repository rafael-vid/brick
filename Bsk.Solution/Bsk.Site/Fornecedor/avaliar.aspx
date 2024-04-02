<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="avaliar.aspx.cs" Inherits="Bsk.Site.Fornecedor.avaliar" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">

    <style>
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

        .estrelas{
          margin-top: 10px;
        }
        .estrelas input[type=radio] {
          display: none;
        }
        .estrelas label i.fa{
          font-size: 2.5em;
          cursor: pointer;
        }
        .estrelas label i.fa:before {
          content:'\f005';
          color: #FC0;
        }
        .estrelas input[type=radio]:checked ~ label i.fa:before {
          color: #CCC;
        }
        a.cotacao{
            background: #f4f3f2;
            color: #770e18 !important;
        }
    </style>
    <div class="conteudo-dash atuacao">
        <%var cot = PegaCotacao(); %>
          <div class="acessos">
             <a href="cotacao-lista.aspx" class="btn_card">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Buscar nova cotação
            </a>
            <a href="em-andamento.aspx" class="btn_card">Cotações em negociação
            </a>
            <a href="minhas-areas.aspx" class="btn_card">Minhas áreas de atuação
            </a>
           
        </div>

        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/estrela.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">Avaliação</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Cliente </h2>
                <p><%Response.Write(cot.NomeCliente); %></p>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Título </h2>
                <p><%Response.Write(cot.Titulo); %></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição do serviço </h2>
                <p><%Response.Write(cot.Descricao); %></p>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Avalie o Prestador de Serviço </h2>
                <div class="avaliacao-estrelas">
                    <%if (cot.Nota == 0)
                        {%>
                    <div class="estrelas">
                        <input type="radio" id="cm_star-empty" name="fb" value="" checked="">
                        <label for="cm_star-1"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-1" name="fb" value="1">
                        <label for="cm_star-2"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-2" name="fb" value="2">
                        <label for="cm_star-3"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-3" name="fb" value="3">
                        <label for="cm_star-4"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-4" name="fb" value="4">
                        <label for="cm_star-5"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-5" name="fb" value="5">
                    </div>
                    <%}
                        else
                        {
                            string check1 = "";
                            string check2 = "";
                            string check3 = "";
                            string check4 = "";
                            string check5 = "";

                            if (cot.Nota == 1)
                            {
                                check1 = "checked";
                            }
                            else if (cot.Nota == 2)
                            {
                                check2 = "checked";
                            }
                            else if (cot.Nota == 3)
                            {
                                check3 = "checked";
                            }
                            else if (cot.Nota == 4)
                            {
                                check4 = "checked";
                            }
                            else if (cot.Nota == 5)
                            {
                                check5 = "checked";
                            }
                    %>

                    <div class="estrelas">
                        <input type="radio" id="cm_star-empty" name="fb" disabled value="" />
                        <label for="cm_star-1"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-1" name="fb" value="1" disabled <%Response.Write(check1); %> />
                        <label for="cm_star-2"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-2" name="fb" value="2" disabled <%Response.Write(check2); %> />
                        <label for="cm_star-3"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-3" name="fb" value="3" disabled <%Response.Write(check3); %> />
                        <label for="cm_star-4"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-4" name="fb" value="4" disabled <%Response.Write(check4); %> />
                        <label for="cm_star-5"><i class="fa"></i></label>
                        <input type="radio" id="cm_star-5" name="fb" value="5" disabled <%Response.Write(check5); %> />
                    </div>
                    <%} %>
                </div>
            </div>
            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Depoimento </h2>
                <div class="area_comentario">
                    <div class="comentarios_area">
                        <textarea name="comentario" id="depoimentoFornecedor" runat="server" placeholder="Digite aqui seu depoimento" cols="30"
                            rows="10"></textarea>
                    </div>
                    <div class="percent">
                        <div class="porcentagem">
                            <%-- <div class="chart" id="graph" data-percent="100"></div>--%>
                            <div>
                                <p class="titulo_percent">Data do término do serviço</p>
                                <span class="data_percent"><%Response.Write(DateTime.Parse(cot.DataTermino).ToString("dd/MM/yyyy")); %></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <div class="footer_card">
                <a class="voltar btn" href="andamento.html"><< voltar </a>
                <button class="btn" runat="server" id="btnDepoimento" onserverclick="btnDepoimento_ServerClick">Enviar</button>
                
                <!--
                    <a href="/" class="item_notifica">
                    <img src="../assets/imagens/chat-notifica.svg" alt="notificação" style="width: 43px;">
                    <span class="notificacao">02</span>
                </a>
                    -->
            </div>

        </div>
    </div>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Outros scripts -->
    <script src="js/jquery.mask.js"></script>
    <script src="js/datatables.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="js/wow.js"></script>
    <script src="js/rating.js"></script>
    <script src="js/master.js"></script>
    <script src="js/comum.js"></script>
    <script>

        function atribuirNota(valor) {
            var parametros = {
                nota: valor,
                id: comum.queryString("Id")
            };

            comum.postAsync("Comum/NotaCotacaoFornecedor", parametros, function (data) {
            });
        }

        var el = document.getElementById('graph'); // get canvas

        var options = {
            percent: el.getAttribute('data-percent') || 25,
            size: el.getAttribute('data-size') || 150,
            lineWidth: el.getAttribute('data-line') || 15,
            rotate: el.getAttribute('data-rotate') || 0
        }

        var canvas = document.createElement('canvas');
        var span = document.createElement('span');
        span.classList.add('marcacao')
        span.textContent = options.percent + '% ';

        if (typeof (G_vmlCanvasManager) !== 'undefined') {
            G_vmlCanvasManager.initElement(canvas);
        }

        var ctx = canvas.getContext('2d');
        canvas.width = canvas.height = options.size;

        el.appendChild(span);
        el.appendChild(canvas);

        ctx.translate(options.size / 2, options.size / 2); // change center
        ctx.rotate((-1 / 2 + options.rotate / 180) * Math.PI); // rotate -90 deg

        //imd = ctx.getImageData(0, 0, 240, 24a0);
        var radius = (options.size - options.lineWidth) / 2;

        var drawCircle = function (color, lineWidth, percent) {
            percent = Math.min(Math.max(0, percent || 1), 1);
            ctx.beginPath();
            ctx.arc(0, 0, radius, 0, Math.PI * 2 * percent, false);
            ctx.strokeStyle = color;
            ctx.lineCap = 'round'; // butt, round or square
            ctx.lineWidth = lineWidth
            ctx.stroke();
        };

        drawCircle('#efefef', options.lineWidth, 100 / 100);
        drawCircle('#770e18', options.lineWidth, options.percent / 100);

        $(document).ready(function () {
            $('#tabela').DataTable({
                "language": {
                    "url": "//cdn.datatables.net/plug-ins/1.10.20/i18n/Portuguese-Brasil.json"
                }
            });

            $('.liberarPagamento').click(function () {
                swal({
                    title: "Tem certeza que podemos liberar o pagamento?",
                    text: "Após o aceite a quantia acordada será liberada para o prestador de serviço!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                    .then((willDelete) => {
                        if (willDelete) {
                            swal("Pagamento liberado com sucesso!", {
                                icon: "success",
                            });
                        } else {
                            swal("Ok, vamos aguardar mais um pouco para liberar o pagamento!");
                        }
                    });
            });

        });
    </script>
</asp:Content>
