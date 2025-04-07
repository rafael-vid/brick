using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class CotacaoFornecedorListaModel
    {
        public int RespostaCotacaoId { get; set; }
        public int ClienteId { get; set; }
        public string Nome { get; set; }
        public string Titulo { get; set; }
        public string Status { get; set; }
        public int FinalizaCliente { get; set; }
        public int FinalizaFornecedor { get; set; }
        public int CotacaoId { get; set; }
        public int CFId { get; set; }
        public int Nota { get; set; }
        public string Mensagens { get; set; }
        public DateTime DataAlteracao { get; set; }
        public double Valor { get; set; }
        public string DataEntrega { get; set; }
        public string StatusNome { get; set; }
    }
}
