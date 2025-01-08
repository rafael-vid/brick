using Bsk.BE.Pag;
using Bsk.Interface;
using Bsk.Site.Geral;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    public partial class AlterarSenha : System.Web.UI.Page
    {
        core _core = new core();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

               


            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {

            // Pega os valores dos campos
            string oldPassword = txtOldPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // Lógica para validar a senha atual
            if (IsValidOldPassword(oldPassword)) // Você pode implementar essa lógica para validar a senha atual
            {
                if (newPassword == confirmPassword)
                {
                    // Atualize a senha no banco de dados aqui (imagine que você tem uma função UpdatePassword)
                    UpdatePassword(newPassword);

                    // Exibe uma mensagem de sucesso
                    lblMessage.Text = "Senha alterada com sucesso!";
                    lblMessage.CssClass = "alert alert-success"; // Estilo para a mensagem de sucesso
                    lblMessage.Visible = true;
                }
                else
                {
                    // Exibe uma mensagem de erro se as senhas não coincidirem
                    lblMessage.Text = "As senhas não coincidem.";
                    lblMessage.CssClass = "alert alert-danger"; // Estilo para a mensagem de erro
                    lblMessage.Visible = true;
                }
            }
            else
            {
                // Exibe uma mensagem de erro se a senha atual estiver incorreta
                lblMessage.Text = "Senha atual incorreta.";
                lblMessage.CssClass = "alert alert-danger"; // Estilo para a mensagem de erro
                lblMessage.Visible = true;
            }
        }

        // Função para validar a senha atual
        private bool IsValidOldPassword(string oldPassword)
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);

            string senha = _core.ConsultaSenha(login.IdParticipante);
            if (senha == oldPassword)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private void UpdatePassword(string newPassword)
        {
            var login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);

            _core.AlterarSenha(newPassword, login.IdParticipante);
        }
    }
}