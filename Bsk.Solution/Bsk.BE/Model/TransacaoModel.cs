using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Pag
{
    public class TransacaoModel
    {
        public int IdTransacao { get; set; }

        public int IdSolicitacao { get; set; }

        public string Status { get; set; }

        public string DataCriacao { get; set; }

        public string DataVencimento { get; set; }

        public string Titulo { get; set; }

        public string Cliente { get; set; }

        public string Fornecedor { get; set; }

        public string Categoria { get; set; }
        public string Url { get; set; }

        public double Valor { get; set; }
    }
}
