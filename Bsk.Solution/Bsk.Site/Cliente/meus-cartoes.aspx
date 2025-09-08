<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="meus-cartoes.aspx.cs" Inherits="Bsk.Site.Cliente.meus_cartoes"  MasterPageFile="~/Cliente/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="Content1" runat="server">
<style>
        :root{
            --bg:#f2f3f3; --panel:#fff; --muted:#6b7280; --text:#111827; --brand:#6d28d9; --accent:#e5e7eb;
        }
        html,body{height:100%;}
        body{margin:0;background:var(--bg);font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Helvetica,Arial,sans-serif;color:var(--text);}        
        .wrap {
            min-height: calc(100vh - 320px); /* ajuste o 160px conforme a altura combinada do header + footer */
            display: flex;
            flex-direction: column;
        }        .grid{display:grid;grid-template-columns:320px 1fr;gap:16px;align-items:start;}
        .panel{background:var(--panel);border-radius:16px;box-shadow:0 1px 2px rgba(16,24,40,.04),0 1px 3px rgba(16,24,40,.1);}        
        .left{overflow:hidden;}
        .cards{max-height:70vh;overflow:auto;padding:8px;}
        .card-row{display:flex;align-items:center;gap:12px;padding:12px;border-radius:12px;cursor:pointer;border:1px solid transparent;}
        .card-row:hover{background:#fafafa;border-color:#eee;}
        .card-row.active{background:#f4f3ff;border-color:#ddd;}
        .thumb{width:64px;height:40px;border-radius:8px;background:linear-gradient(135deg, #5b21b6, #8b5cf6);position:relative;display:grid;place-items:center;color:#fff;font-weight:700;}
        .thumb:after{content:"\2022\2022\2022\2022";position:absolute;bottom:6px;left:10px;font-size:10px;opacity:.85;letter-spacing:2px}
        .meta{display:flex;flex-direction:column;line-height:1.2}
        .meta .brand{font-weight:600}
        .meta .last4{font-size:12px;color:var(--muted)}
        .actions{margin-top:8px;display:flex;gap:8px}
        .btn{display:inline-flex;align-items:center;gap:8px;padding:10px 14px;border-radius:12px;border:1px solid #e5e7eb;background:#fff;font-weight:600;cursor:pointer}
        .btn.primary{background:#5b21b6;color:#fff;border-color:transparent}
        .btn.danger{border-color:#fecaca;background:#fff0f0;color:#b91c1c}
        .detail{padding:20px 24px}
        .detail-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:16px}
        .detail-head,
        .detail-head .actions { position: relative; z-index: 5; }
        .detail-title{font-size:20px;font-weight:700}
        .bigcard{display:flex;gap:16px;align-items:center;background:linear-gradient(135deg,#5b21b6,#8b5cf6);color:#fff;border-radius:16px;padding:18px 20px}
        .bigchip{width:44px;height:32px;border-radius:6px;background:rgba(255,255,255,.25)}
        .bigmeta{display:flex;flex-direction:column;gap:6px}
        .bigmeta .name{font-weight:700}
        .form{display:grid;grid-template-columns:1fr 1fr;gap:12px;margin-top:20px}
        .form .field{display:flex;flex-direction:column;gap:6px}
        .form label{font-size:12px;color:var(--muted)}
        .form input{border:1px solid #e5e7eb;border-radius:10px;padding:10px 12px;font-size:14px}
        .divider{height:1px;background:var(--accent);margin:18px 0}
        @media (max-width: 960px){.grid{grid-template-columns:1fr}.cards{max-height:none}}
    </style>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function confirmarRemocao() {
        Swal.fire({
            title: 'Tem certeza?',
            text: 'Deseja realmente remover este cartão?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sim, remover',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                __doPostBack('<%= btnRemover.UniqueID %>', '');
            }
        });
        return false;
    }
    </script>
<script>
    function preventDoubleSubmit(btn) {
        if (btn.dataset.clicked) return false;   // blocks 2nd+ clicks
        btn.dataset.clicked = "true";
        btn.disabled = true;
        btn.classList.add("is-loading");
        return true; // allow the postback
    }

</script>
<script>
    function onSalvarClick(btn) {
        // Prevent double submits and bypass HTML5 constraint validation
        if (!preventDoubleSubmit(btn)) return false;
        __doPostBack('<%= btnAdicionar.UniqueID %>', '');
        return false; // stop native submit
    }
</script>
<script>
    function digitsOnly(el) { el.value = el.value.replace(/\D+/g, ''); }
</script>
<script>
    // Formats: "1234567890123456" -> "1234 5678 9012 3456"
    function formatCardNumber(el) {
        const selStart = el.selectionStart;
        const raw = el.value;
        const digits = raw.replace(/\D/g, "").slice(0, 19); // hard limit: 19 digits
        const grouped = digits.replace(/(.{4})/g, "$1 ").trim();

        // Recompute caret: # of digits before old caret -> position with spaces
        const digitsBefore = raw.slice(0, selStart).replace(/\D/g, "").length;
        const newPos = digitsBefore + Math.floor(digitsBefore / 4);

        el.value = grouped;
        // guard in case of end-of-string
        const pos = Math.min(newPos, el.value.length);
        el.setSelectionRange(pos, pos);
    }

    // (Optional) smoother backspace when cursor is right after a space
    function cardBackspaceHandler(e) {
        if (e.key !== "Backspace") return;
        const el = e.target;
        const pos = el.selectionStart;
        if (pos > 0 && el.value[pos - 1] === " ") {
            e.preventDefault();
            // delete the digit before the space
            const before = el.value.slice(0, pos - 1);
            const after = el.value.slice(pos);
            el.value = (before + after);
            formatCardNumber(el);
        }
    }
</script>



<asp:ScriptManager runat="server" EnablePartialRendering="true" />
        <asp:Literal runat="server" ID="litSwal" />
        <div class="wrap">
            <div class="grid">
                <!-- LEFT: list of cards -->
                <asp:UpdatePanel ID="updLeft" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="panel left">
                            <div class="detail">
                                <div class="cards">
                                    <asp:ListView ID="lvCartoes" runat="server" DataKeyNames="Id" OnItemCommand="lvCartoes_ItemCommand">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server"
                                                CommandName="selectCard"
                                                CommandArgument='<%# Eval("Id") %>'
                                                CssClass='<%# (Eval("Id").ToString() == SelectedId ? "card-row active" : "card-row") %>'>
                                                <span class="thumb">nu</span>
                                                <span class="meta">
                                                    <span class="brand"><%# Eval("Brand") %></span>
                                                    <span class="last4">Cartão final •••• <%# Eval("LastFourDigits") %></span>
                                                </span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:ListView>
                                    <asp:PlaceHolder runat="server" ID="phSemCartoes" Visible="false">
                                        <div class="card-row">Nenhum cartão cadastrado</div>
                                    </asp:PlaceHolder>
                                </div>
                                <div class="actions">
                                    <asp:Button runat="server" ID="btnNovo" Text="Adicionar cartão" CssClass="btn primary" OnClick="AbrirModoAdicionar" />
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAdicionar" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRemover" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>


                <!-- RIGHT: selected card details -->
                <asp:UpdatePanel runat="server" ID="upd" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="detail">
                            <div class="detail-head">
                                <div class="detail-title">Detalhes do cartão</div>
                                <div class="actions">
                                    <asp:Button ID="btnRemover" runat="server"
                                        Text="Remover"
                                        CssClass="btn danger"
                                        UseSubmitBehavior="false"
                                        CausesValidation="false"
                                        OnClientClick="return confirmarRemocao();"
                                        OnClick="btnRemoverSelected_Click" />
                                </div>
                            </div>
                            <div class="bigcard">
                                <div class="bigchip"></div>
                                <div class="bigmeta">
                                    <div class="name"><asp:Label runat="server" ID="lblNomeCartao" /></div>
                                    <div class="num"><asp:Label runat="server" ID="lblNumeroMascarado" /></div>
                                    <div class="holder"><asp:Label runat="server" ID="lblTitular" /></div>
                                    <div class="exp"><asp:Label runat="server" ID="lblExp" /></div>
                                </div>
                            </div>

                            <div class="divider"></div>

                            <!-- Add / Edit form (simple add for now) -->
                            <div id="areaAdd" runat="server" visible="false">
                                <div class="form">
                                    <div class="field">
                                        <label>Nome do titular</label>
                                        <input id="nomeTItular" runat="server" type="text" />
                                    </div>
                                    <div class="field">
                                        <label>Número</label>
                                        <input id="numeroCartao" runat="server"
       type="text" inputmode="numeric"
       maxlength="19"
       pattern="^[0-9 ]{19}$"
       title="Apenas números (16 dígitos), com espaço a cada 4."
       oninput="formatCardNumber(this)"
       onkeydown="cardBackspaceHandler(event)" />

                                    </div>
                                    <div class="field">
                                        <label>Mês</label>
                                        <input id="mes" runat="server"
       type="text" inputmode="numeric" 
       maxlength="2" pattern="(0[1-9]|1[0-2])"
       title="Mês no formato 01 a 12."
       oninput="digitsOnly(this)" />
                                    </div>
                                    <div class="field">
                                        <label>Ano</label>
                                        <input id="ano" runat="server"
       type="text" inputmode="numeric" 
       maxlength="4" pattern="\d{4}"
       title="Ano com 4 dígitos (ex.: 2028)."
       oninput="digitsOnly(this)" />
                                    </div>
                                    <div class="field">
                                        <label for="codigo">CVV</label>
                                        <input id="codigo" runat="server"
       type="text" inputmode="numeric" 
       maxlength="4" pattern="\d{3,4}"
       title="Código de segurança com 3 ou 4 dígitos."
       oninput="digitsOnly(this)" />

                                    </div>
                                </div>
                                <div class="actions">
                                    <asp:Button ID="btnAdicionar" runat="server" Text="Salvar cartão" CssClass="btn primary" UseSubmitBehavior="false" CausesValidation="false" OnClick="btnAdicionar_Click" OnClientClick="return onSalvarClick(this);" />
                                    <asp:Button runat="server" ID="btnCancelarAdd" Text="Cancelar" CssClass="btn" OnClick="FecharModoAdicionar" />
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                    <Triggers>
    <asp:AsyncPostBackTrigger ControlID="lvCartoes" EventName="ItemCommand" />
    <asp:AsyncPostBackTrigger ControlID="btnRemover" EventName="Click" />
    <asp:AsyncPostBackTrigger ControlID="btnAdicionar" EventName="Click" />
    <asp:AsyncPostBackTrigger ControlID="btnNovo" EventName="Click" />
  </Triggers>
</asp:UpdatePanel>
            </div>
        </div>
</asp:Content>