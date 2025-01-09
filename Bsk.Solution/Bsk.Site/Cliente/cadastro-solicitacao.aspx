<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="cadastro-solicitacao.aspx.cs" Inherits="Bsk.Site.Cliente.cadastro_cotacao" MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cli-cotacao">
        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Nova Solicitação
            </a>
            <a href="minhas-cotacoes.aspx" class="btn_card">Minhas Solicitações</a>
            <a href="aguardando-pagamento.aspx" class="btn_card">Pagamentos</a>
        </div>
        <div class="card">
            <div class="titulo_card">
                <img src="../assets/imagens/cotacao.svg" alt="ícone" style="width: 20px;">
                <h2 class="subtitulo_1">solicitações/Nova solicitação</h2>
            </div>

            <div class="item_content_card">
                <h2 class="subtitulo_card_1 subtitulo_1">Descrição </h2>
                <input type="text" placeholder="Digite aqui uma descrição para o serviço a ser realizado" class="card-input-add" id="titulo" runat="server">
            </div>

            <input type="hidden" id="hdLink" clientidmode="static" runat="server" value="" />

            <div class="item_content_card card-line">

                <div class="area_comentario">
                    <div class="comentarios_area">
                        <h2 class="subtitulo_card_1 subtitulo_1">Detalhamento </h2>
                        <asp:TextBox ID="descricao" runat="server" placeholder="Digite aqui seu depoimento" TextMode="MultiLine"></asp:TextBox>

                        <button type="button" class="btn enviar-cotacao" id="btnSalvar" onserverclick="btnSalvar_ServerClick" runat="server">
                            Salvar dados da cotação
                        </button>
                    </div>
                    <div>
                        <asp:FileUpload ID="flpAnexo" CssClass="flpAnexo" runat="server" Style="display: none;" onchange="$('#btnEnviarAnexo').click()" />
                        <asp:FileUpload ID="flpVideo" CssClass="flpVideo" runat="server" Style="display: none;" onchange="$('#btnEnviarAnexo').click()" />

                        <div class="item_content_card" style="display: flex; align-items: center;">
                            <div>
                                <h2 class="subtitulo_card_1 subtitulo_1">Frequência</h2>
                                <asp:DropDownList ID="ddlFrequencia" runat="server" CssClass="card-input-add" AutoPostBack="false" onchange="updateCalendar()" style="width:250px;">
                                    <asp:ListItem Text="Uma única vez" Value="" />
                                    <asp:ListItem Text="Semanal" Value="Semanal" />
                                    <asp:ListItem Text="Mensal" Value="Mensal" />
                                    <asp:ListItem Text="Anual" Value="Anual" />
                                </asp:DropDownList>
                            </div>
                            <div id="calendarContainer" style="margin-left: 20px;">
                                <!-- Calendário será inserido aqui -->
                            </div>
                            
                        </div>
                        <div id="aCadaContainer" style="width:250px;">
</div>
                        <script>
                            function updateCalendar() {
                                var selectedFrequency = document.getElementById('<%= ddlFrequencia.ClientID %>').value;
                                var calendarContainer = document.getElementById('calendarContainer');
                                var aCadaContainer = document.getElementById('aCadaContainer');

                                // Clear existing content
                                calendarContainer.innerHTML = '';
                                aCadaContainer.innerHTML = '';

                                if (selectedFrequency === 'Semanal') {
                                    calendarContainer.innerHTML = `
                <h2 class="subtitulo_card_1 subtitulo_1" style="width: 200px;">Dias da Semana</h2>
                <div id="daysOfWeek" style="display: flex; gap: 5px;">
                    <div class="day-box" data-day="Domingo">D</div>
                    <div class="day-box" data-day="Segunda-feira">S</div>
                    <div class="day-box" data-day="Terça-feira">T</div>
                    <div class="day-box" data-day="Quarta-feira">Q</div>
                    <div class="day-box" data-day="Quinta-feira">Q</div>
                    <div class="day-box" data-day="Sexta-feira">S</div>
                    <div class="day-box" data-day="Sábado">S</div>
                </div>
            `;
                                    aCadaContainer.innerHTML = `
                <h2 class="subtitulo_card_1 subtitulo_1" style="width: 200px;">A Cada</h2>
                <select class="card-input-add">
                    <option value="1 semana">1 semana</option>
                    <option value="2 semanas">2 semanas</option>
                    <option value="3 semanas">3 semanas</option>
                    <option value="4 semanas">4 semanas</option>
                    <option value="5 semanas">5 semanas</option>
                    <option value="6 semanas">6 semanas</option>
                </select>
            `;
                                } else if (selectedFrequency === 'Mensal') {
                                    calendarContainer.innerHTML = `
                <h2 class="subtitulo_card_1 subtitulo_1" style="width: 200px;">Data</h2>
                <select class="card-input-add">
                    ${Array.from({ length: 31 }, (_, i) => `<option value="${i + 1}">${i + 1}</option>`).join('')}
                </select>
            `;
                                    aCadaContainer.innerHTML = `
                <h2 class="subtitulo_card_1 subtitulo_1" style="width: 200px;">A Cada</h2>
                <select class="card-input-add">
                    <option value="1 mês">1 mês</option>
                    <option value="2 meses">2 meses</option>
                    <option value="3 meses">3 meses</option>
                    <option value="4 meses">4 meses</option>
                    <option value="5 meses">5 meses</option>
                    <option value="6 meses">6 meses</option>
                    <option value="7 meses">7 meses</option>
                    <option value="8 meses">8 meses</option>
                    <option value="9 meses">9 meses</option>
                    <option value="10 meses">10 meses</option>
                    <option value="11 meses">11 meses</option>
                    <option value="12 meses">12 meses</option>
                </select>
            `;
                                } else if (selectedFrequency === 'Anual') {
                                    calendarContainer.innerHTML = `
                <h2 class="subtitulo_card_1 subtitulo_1" style="width: 200px;">Data</h2>
                <asp:TextBox ID="txtDataAnual" runat="server" CssClass="card-input-add" TextMode="Date"></asp:TextBox>
            `;
                                    aCadaContainer.innerHTML = `
    <h2 class="subtitulo_card_1 subtitulo_1" style="width: 200px;">A Cada</h2>
    <select class="card-input-add">
        <option value="1 semana">1 ano</option>
        <option value="2 semanas">2 anos</option>
        <option value="3 semanas">3 anos</option>
        <option value="4 semanas">4 anos</option>
        <option value="5 semanas">5 anos</option>
    </select>
`;
                                }

                                // Add event listeners for day-box elements
                                var dayBoxes = document.querySelectorAll('.day-box');
                                dayBoxes.forEach(function (dayBox) {
                                    dayBox.addEventListener('click', function () {
                                        // Toggle the selected class
                                        this.classList.toggle('selected');
                                    });
                                });
                            }

                            $(document).ready(function () {
                                // Initialize the calendar update based on the selected frequency
                                updateCalendar();

                                $("#btnAnexo").click(function () {
                                    $(".flpAnexo").click();
                                });

                                $("#btnVideo").click(function () {
                                    $(".flpVideo").click();
                                });

                                if (comum.queryString("Cotacao") != undefined && comum.queryString("Cotacao") != "") {
                                    $('.alert').slideToggle('slow');
                                }
                            });
                        </script>



<style>
    .day-box {
        width: 30px; /* Adjust width as needed */
        height: 30px; /* Adjust height as needed */
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #ccc;
        border-radius: 5px;
        cursor: pointer;
        background-color: #f9f9f9;
        font-size: 14px;
        font-weight: bold;
        text-align: center;
    }

    .day-box.selected {
        background-color: darkorange;
        color: #fff;
        border-color: #007bff;
    }

    .day-box:hover {
        background-color: #e9ecef;
    }
</style>


                        <div class="item_content_card card-content-desc" style="margin-top: 0 !important;" id="divUpload" runat="server">
                            <div class="subtitulo-com-icone">
                                <img src="../assets/imagens/file.svg" alt="ícone" style="width: 20px;">
                                <h2 class="subtitulo_card_1 subtitulo_1">Enviar imagem ou vídeo sobre o serviço </h2>
                            </div>
                            <div class="files-upload">
                                <div class="file">
                                    <img src="../assets/imagens/anexar.svg" style="width: 30px;" alt="anexar">
                                    <a id="btnAnexo" class="btn-gravar">Anexar arquivos</a>
                                </div>
                            </div>
                        </div>
                        <button type="button" class="btn enviar-cotacao" id="btnEnviarAnexo" ClientIDMode="Static" onserverclick="btnSalvar_ServerClick" runat="server" style="display:none">
                            Enviar anexo
                        </button>

                        <div class="filtros_card cota-info" style="margin-top: 40px;">
                            <div class="dataTables_length" id="tabela_length">
                                <label>
                                    <select name="tabela_length" aria-controls="tabela" class="">
                                        <option value="10">10</option>
                                        <option value="25">25</option>
                                        <option value="50">50</option>
                                        <option value="100">100</option>
                                    </select> resultados por página
                                </label>
                            </div>
                        </div>

                        <div class="card-tabela" style="overflow-x: auto;">
                            <table>
                                <thead id="cabecalho-tabela" class="subtitulo_card_1">
                                    <tr>
                                        <th>
                                            <label>Arquivos anexos</label>
                                        </th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <% var anexos = PegaAnexo();
                                        foreach (var item in anexos)
                                        { %>
                                    <tr>
                                        <td><% Response.Write(item.Anexo); %></td>
                                        <td style="text-align: right">
                                            <a class="btn btn-b rikk" href="cadastro-solicitacao.aspx?Cotacao=<% Response.Write(item.IdCotacao); %>&Del=<% Response.Write(item.IdCotacaoAnexos); %>">Deletar</a>&nbsp;&nbsp;
                                            <% if (item.Tipo == "Anexo")
                                                { %>
                                            <a class="btn btn-bri kk" href='<% Response.Write(ConfigurationManager.AppSettings["host"]);%>Anexos/Documento/<% Response.Write(item.Anexo); %>' target='_blank'>Visualizar</a>
                                            <% } else { %>
                                            <a class="btn btn-br ikk" style="display: inline-block" href='<% Response.Write(ConfigurationManager.AppSettings["host"]);%>Anexos/Video/<% Response.Write(item.Anexo); %>' target='_blank'>Visualizar</a>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer_card">
                <a class="voltar btn" href="minhas-cotacoes.aspx"><< voltar </a>

                <a class="btn enviar-cotacao" id="btnSubmeter" runat="server" onclick="cadastrar();" style="position: absolute; right: 83px; margin-top: -1px;">Enviar Cotação</a>
            </div>
        </div>
    </div>

    <style>
        .card-tabela tr td a.btn {
            width: 90px !important;
            position: relative !important;
        }

        div:where(.swal2-container).swal2-center > .swal2-popup {
            border-radius: 40px !important;
            font-size: 15px !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-cancel {
            border-radius: 20px !important;
        }

        div:where(.swal2-container) button:where(.swal2-styled).swal2-confirm {
            border-radius: 20px !important;
        }

        div:where(.swal2-icon).swal2-info {
            border-color: #770e18;
            color: #770e18;
        }

        .btn.enviar-cotacao {
            border-radius: 30px;
            margin-bottom: 30px;
            font-family: Rajdhani-semi;
            font-size: 16px;
        }

        .btn.enviar-cotacao:hover {
            color: #fff;
        }

        a.cotacao {
            background: #f4f3f2;
            color: #770e18 !important;
        }

        .area_comentario {
            display: grid;
            grid-template-columns: 35% 1fr;
            grid-gap: 50px;
            margin-top: 15px;
        }

        .card-input-add[multiple] {
            height: 150px; /* Ajuste a altura conforme necessário */
            overflow-y: auto;
        }
    </style>

    <script>
        function cadastrar() {
            if ($("#titulo").val() != "" && $("#descricao").val() != "") {
                Swal.fire({
                    toast: true,
                    title: 'Enviar?',
                    text: "Deseja confirmar a publicação desta solicitação?",
                    icon: 'info',
                    showCancelButton: true,
                    confirmButtonColor: '#f08f00',
                    cancelButtonColor: "#770e18",
                    cancelButtonText: 'Cancelar',
                    confirmButtonText: 'Aceitar'
                }).then((result) => {
                    if (result.value) {
                        var parametro = {
                            id: comum.queryString("Cotacao"),
                            descricao: $("#descricao").val(),
                            titulo: $("#titulo").val()
                        };
                        comum.postAsync("Comum/SubmeterCotacao", parametro, function (data) {
                            window.location.href = "minhas-cotacoes.aspx";
                        });
                    }
                });
            } else {
                Swal.fire({
                    toast: true,
                    icon: 'info',
                    text: "Preencha todos os campos."
                })
            }
        }

        $(document).ready(function () {
            $("#btnAnexo").click(function () {
                $(".flpAnexo").click();
            });

            $("#btnVideo").click(function () {
                $(".flpVideo").click();
            });

            if (comum.queryString("Cotacao") != undefined && comum.queryString("Cotacao") != "") {
                $('.alert').slideToggle('slow');
            }
        });
    </script>

</asp:Content>
