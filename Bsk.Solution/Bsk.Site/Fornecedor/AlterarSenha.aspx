<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AlterarSenha.aspx.cs" Inherits="Bsk.Site.Fornecedor.AlterarSenha" MasterPageFile="~/Fornecedor/Master/Layout.Master" %>

<asp:Content ContentPlaceHolderID="conteudo" ID="hd" runat="server">
    <div class="conteudo-dash cotacao cotacoes-cli">
        <div class="acessos">
            <a class="btn_card" href="buscar-servico.aspx">
                <img src="../assets/imagens/lupa.png" style="width: 15px;" alt="buscar">
                Nova Cotação
            </a>
            <button class="btn_card">
                Minhas Cotações
            </button>
            <button class="btn_card">
                Pagamentos
            </button>
        </div>

        <div class="card">
            <h2>Alterar Senha</h2>

            <!-- Formulário já está incluído no form do MasterPage -->
            <div id="formAlterarSenha">
                <!-- Senha Atual -->
                <div class="form-group">
                    <label for="txtOldPassword">Senha Atual</label>
                    <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvOldPassword" runat="server" ControlToValidate="txtOldPassword" 
                        ErrorMessage="A senha atual é obrigatória" ForeColor="Red" Display="Dynamic" />
                </div>

                <!-- Nova Senha -->
                <div class="form-group">
                    <label for="txtNewPassword">Nova Senha</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" 
                        ErrorMessage="A nova senha é obrigatória" ForeColor="Red" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revNewPassword" runat="server" ControlToValidate="txtNewPassword" 
                        ValidationExpression="^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d@$!%*?&]{8,}$" 
                        ErrorMessage="A senha deve ter no mínimo 8 caracteres, incluindo uma letra, um número e um caractere especial" 
                        ForeColor="Red" Display="Dynamic" />
                </div>

                <!-- Confirmar Nova Senha -->
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirmar Nova Senha</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                        ErrorMessage="A confirmação da nova senha é obrigatória" ForeColor="Red" Display="Dynamic" />
                    <asp:CompareValidator ID="cvComparePassword" runat="server" ControlToValidate="txtConfirmPassword" 
                        ControlToCompare="txtNewPassword" ErrorMessage="As senhas não coincidem" ForeColor="Red" Display="Dynamic" />
                </div>

                <!-- Botão de Envio -->
                <div class="form-group">
                    <asp:Button ID="btnChangePassword" runat="server" Text="Alterar Senha" CssClass="btn btn-primary" OnClick="btnChangePassword_Click" />
                </div>
            </div>

            <!-- Label para exibir mensagens -->
            <div class="form-group">
                <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false" />
            </div>
        </div>
    </div>
</asp:Content>
