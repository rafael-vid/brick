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
        public int IdServico { get; set; }
        public string Status { get; set; }
        public DateTime DataCriacao { get; set; }
    }
}
