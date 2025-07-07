using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.BE
{
    public class CartaoBE
    {
        public int Id { get; set; }
        public int IdParticipante { get; set; }
        public string NomeCartao { get; set; }
        public string NomeTitular { get; set; }
        public string NumeroCartao { get; set; }
        public int MesExpiracao { get; set; }
        public int AnoExpiracao { get; set; }
        public string CVV { get; set; }
    }
}
