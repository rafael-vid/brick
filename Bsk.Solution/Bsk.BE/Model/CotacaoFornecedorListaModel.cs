using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class CotacaoFornecedorListaModel
    {
        public int CotacaoFornecedorId { get; set; }
        public int ClienteId { get; set; }
         public string Nome { get; set; }
        public string Titulo { get; set; }
        public string Status { get; set; }
        public int FinalizaCliente { get; set; }
        public int FinalizaFornecedor { get; set; }      
        public int CotacaoId { get; set; }
        public int CFId { get; set; }
        public int Nota { get; set; }
    }
}
