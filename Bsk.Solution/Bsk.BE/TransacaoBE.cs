using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE
{
    public class TransacaoBE
    {
        public int IdTransacao { get; set; }
        public string GuidTransacao { get; set; }
        public string Status { get; set; }
        public int IdSolicitacao { get; set; }
        public string Url { get; set; }
        public string DataVencimento { get; set; }
        public string IdExterno { get; set; }
        public string DataEnvio { get; set; }
        public int Parcelas { get; set; }
        public string TipoPagamento { get; set; }
        public string Observacao { get; set; }
        public string ObservacaoStatus { get; set; }
        public string Boleto { get; set; }
    }
}
