using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE
{
   public class CotacaoFornecedorBE
    {
        public int IdCotacaoFornecedor { get; set; }
        public int IdCotacao { get; set; }
        public int IdFornecedor { get; set; }
        public double Valor { get; set; }
        public string DataCriacao { get; set; }
        public string DataEntrega { get; set; }
        public int Ativo { get; set; }
        public int Novo { get; set; }
    }
}
