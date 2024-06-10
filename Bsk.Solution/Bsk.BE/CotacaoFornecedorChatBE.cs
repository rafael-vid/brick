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
        public int IdCliente { get; set; }
        public int IdParticipante { get; set; }
        public int IdFornecedor { get; set; }
        public string Mensagem { get; set; }
        public string Arquivo { get; set; }
        public string Video { get; set; }
        public string DataCriacao { get; set; }

        public string Status { get; set; }
        public int LidaFornecedor { get; set; }
        public int LidaCliente { get; set; }
    }
}
