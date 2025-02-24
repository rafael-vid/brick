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
        public int IdSolicitacao { get; set; }
        public int IdParticipanteFornecedor { get; set; }
        public decimal Valor { get; set; }
        public string DataCriacao { get; set; }
        public string DataEntrega { get; set; }
        public int Ativo { get; set; }
        public int Novo { get; set; }
        public int EnviarProposta { get; set; }
    }
}
