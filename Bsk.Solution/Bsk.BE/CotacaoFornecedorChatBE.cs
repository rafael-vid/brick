using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE
{
   public class CotacaoFornecedorChatBE
    {
        public int IdCotacaoFornecedorChat { get; set; }
        public int IdCotacaoFornecedor { get; set; }
        public string Tipo { get; set; }
        public string Valor { get; set; }
        public DateTime DataCriacao { get; set; }
    }
}
