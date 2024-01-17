using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE.Model
{
    public class NotificacaoModel
    {
        public int idnotificacao { get; set; }
        public int idcliente { get; set; }
        public string titulo { get; set; }
        public string mensagem { get; set; }
        public string link { get; set; }
        public string visualizado { get; set; }
        public DateTime data { get; set; }
    }
}
