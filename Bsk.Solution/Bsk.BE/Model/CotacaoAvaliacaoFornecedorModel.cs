using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class CotacaoAvaliacaoFornecedorModel
    {
        public int CotacaoId { get; set; }
        public int RespostaCotacaoId { get; set; }
        public double Valor { get; set; }
        public string NomeCliente { get; set; }
        public string Observacao { get; set; }
        public string Titulo { get; set; }
        public string Descricao { get; set; }
        public string NomeFornecedor { get; set; }
        public string DataTermino { get; set; }
        public int Nota { get; set; }
    }
}
