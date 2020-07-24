using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Pag
{
    public class Usuario
    {
        
        public int IdUsuario { get; set; }

        public string IdCliente { get; set; }

        public string Nome { get; set; }
        
        public DateTime DataAlteracao { get; set; }
        
        public DateTime DataNascimento { get; set; }
        
        public string Telefone { get; set; }
        
        public string Email { get; set; }
        
        public string Senha { get; set; }
        
        public string CPF { get; set; }
        
        public string Status { get; set; }
        
        public string BskPagID { get; set; }
        
        public string Sobrenome { get; set; }

        
        public List<Endereco> Enderecos { get; set; }
    }
}
