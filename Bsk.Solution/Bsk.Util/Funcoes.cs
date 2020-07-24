using Bsk.BE;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.AccessControl;
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

        public static FornecedorBE PegaLoginFornecedor(string json)
        {
            var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(json);
            FornecedorBE fornecedorBE = new FornecedorBE()
            {
                IdFornecedor = ret["IdFornecedor"],
                Bairro = ret["Bairro"],
                Cep = ret["Cep"],
                Cnpj = ret["Cnpj"],
                Complemento = ret["Complemento"],
                DataCriacao = ret["DataCriacao"],
                Email = ret["Email"],
                Logradouro = ret["Logradouro"],
                Municipio = ret["Municipio"],
                RazaoSocial = ret["RazaoSocial"],
                Numero = ret["Numero"],
                Senha = ret["Senha"],
                Situacao = ret["Situacao"],
                Status = ret["Status"],
                Telefone = ret["Telefone"],
                Uf = ret["Uf"],
                WhatsApp = ret["WhatsApp"],
                Abertura = ret["Abertura"],
                NomeFantasia = ret["NomeFantasia"],
                Responsavel = ret["Responsavel"],
                Tipo = ret["Tipo"]
            };
            return fornecedorBE;
        }

        public static ClienteBE PegaLoginCliente(string json)
        {
            var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(json);
            ClienteBE clienteBE = new ClienteBE()
            {
                IdCliente = ret["IdCliente"],
                Bairro = ret["Bairro"],
                Cep = ret["Cep"],
                Cnpj = ret["Cnpj"],
                Complemento = ret["Complemento"],
                DataCriacao = ret["DataCriacao"],
                Email = ret["Email"],
                Logradouro = ret["Logradouro"],
                Municipio = ret["Municipio"],
                Nome= ret["Nome"],
                Numero= ret["Numero"],
                Senha= ret["Senha"],
                Situacao= ret["Situacao"],
                Status= ret["Status"],
                Telefone= ret["Telefone"],
                Uf= ret["Uf"],
                WhatsApp= ret["WhatsApp"],
                ZoopID = ret["ZoopID"]
            };
            return clienteBE;
        }

    }
}
