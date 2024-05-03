using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE
{
   public class CotacaoBE
    {
        public int IdCotacao { get; set; }
        public int IdCliente { get; set; }
        public int IdCategoria { get; set; }
        public string Status { get; set; }
        public string DataCriacao { get; set; }
        public string DataTermino { get; set; }
        public int IdCotacaoFornecedor { get; set; }
        public string Titulo { get; set; }
        public string Observacao { get; set; }
        public string Descricao { get; set; }
        public string Depoimento { get; set; }
        public int Nota { get; set; }
        public int FinalizaCliente { get; set; }
        public int FinalizaFornecedor { get; set; }
        public int NotaFornecedor { get; set; }
        public DateTime DataAlteracao { get; set; }

        public DateTime DataAvaliacao { get; set; }
    }
}
