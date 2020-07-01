using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.Util
{
    public static class Funcoes
    {
        public static string FormataData(string data)
        {
            DateTime time = DateTime.Parse(data);
            return time.ToString("dd/MM/yyyy");
        }
        public static int geraNumeroRandomico(int minimo, int maximo)
        {
            Random random = new Random();
            return random.Next(minimo, maximo);
        }
    }
}
