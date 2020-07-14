using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class CotacaoAvaliacaoModel
    {
        public int CotacaoId { get; set; }
        public int CotacaoFornecedorId { get; set; }
        public double Valor { get; set; }
        public string NomeFornecedor { get; set; }
        public string Depoimento { get; set; }
        public string Titulo { get; set; }
        public string Descricao { get; set; }
        public int Nota { get; set; }

    }
}
