using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class CotacaoPagamentoModel
    {
        public int IdFornecedorDB { get; set; }
        public double Valor { get; set; }
        public string NomeFornecedor { get; set; }
        public int CotacaoId { get; set; }
        public string Status { get; set; }
    }
}
