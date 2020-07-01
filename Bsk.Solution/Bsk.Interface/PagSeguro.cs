using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace Bsk.Interface
{
    public class PagSeguro
    {
        public string email { get; set; }
        public string token { get; set; }
        public string currency { get; set; }
        public string reference { get; set; }
        public string senderName { get; set; }
        public string senderEmail { get; set; }
        public string shipingAddressRequired { get; set; }
        public List<PagSeguroItens> ListaItens { get; set; }
    }


}
