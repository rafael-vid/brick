using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class CotacaoListaModel
    {
        public int CotacaoFornecedorId { get; set; }
        public string Mensagens { get; set; }
        public decimal Valor { get; set; }
        public string DataUltimaResposta { get; set; }
        public string NomeFornecedor { get; set; }
        public int CotacaoId { get; set; }
        public int Ativo { get; set; }
        public int Novo { get; set; }
    }
}
