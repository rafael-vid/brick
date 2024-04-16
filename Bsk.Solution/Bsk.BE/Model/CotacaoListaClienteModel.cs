using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class CotacaoListaClienteModel
    {
        public int IdCotacao { get; set; }
        public string Titulo { get; set; }
        public string DataCriacao { get; set; }
        public DateTime DataAlteracao { get; set; }
        public string Status { get; set; }
        public string nome { get; set; }
        public string Mensagens { get; set; }
        public int FinalizaFornecedor { get; set; }
        public int FinalizaCliente { get; set; }    
        public int IdCotacaoFornecedor { get; set; }
        public int EnviarProposta { get; set; }
    }
}
