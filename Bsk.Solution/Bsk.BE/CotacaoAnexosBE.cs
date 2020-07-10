using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE
{
   public class CotacaoAnexosBE
    {
        public int IdCotacaoAnexos { get; set; }
        public int IdCotacao { get; set; }
        public string Tipo { get; set; }
        public string Anexo { get; set; }
        public DateTime DataCriacao { get; set; }
    }
}
