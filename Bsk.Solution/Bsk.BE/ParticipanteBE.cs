using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE
{
    public class ParticipanteBE
    {
        public int IdParticipante { get; set; }
        public string Matriz { get; set; }
        public string Pj { get; set; }
        public string Documento { get; set; }
        public string Nome { get; set; }
        public string Sobrenome { get; set; }
        public string RazaoSocial { get; set; }
        public string NomeFantasia { get; set; }
        public string Logradouro { get; set; }
        public string Numero { get; set; }
        public string Complemento { get; set; }
        public string Bairro { get; set; }
        public string cidade { get; set; }
        public string Uf { get; set; }
        public string Cep { get; set; }
        public string Telefone { get; set; }
        public string Email { get; set; }
        public string Senha { get; set; }
        public string data { get; set; }
        public int Confirmado { get; set; }
        public string GuidColumn { get; set; }
        public int EmailConfirmado { get; set; }
        public string Token { get; set; }
        public bool PrestaServico { get; set; }

    }
}
