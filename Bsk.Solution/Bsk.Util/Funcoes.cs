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

            byte[] bytes = Encoding.Default.GetBytes(json);
            json = Encoding.UTF8.GetString(bytes);
            var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(json);
            FornecedorBE fornecedorBE = new FornecedorBE();

            
            fornecedorBE.Bairro = ret["Bairro"];
            fornecedorBE.IdFornecedor = ret["IdFornecedor"];
            fornecedorBE.Cep = ret["Cep"];
            fornecedorBE.Cnpj = ret["Cnpj"];
            fornecedorBE.Complemento = ret["Complemento"];
            fornecedorBE.DataCriacao = ret["DataCriacao"];
            fornecedorBE.Email = ret["Email"];
            fornecedorBE.Logradouro = ret["Logradouro"];
            fornecedorBE.Municipio = ret["Municipio"];
            fornecedorBE.RazaoSocial = ret["RazaoSocial"];
            fornecedorBE.Numero = ret["Numero"];
            fornecedorBE.Senha = ret["Senha"];
            fornecedorBE.Situacao = ret["Situacao"];
            fornecedorBE.Status = ret["Status"];
            fornecedorBE.Telefone = ret["Telefone"];
            fornecedorBE.Uf = ret["Uf"];
            fornecedorBE.WhatsApp = ret["WhatsApp"];
            fornecedorBE.Abertura = ret["Abertura"];
            fornecedorBE.NomeFantasia = ret["NomeFantasia"];
            fornecedorBE.SobreNome = ret["SobreNome"];
            fornecedorBE.Responsavel = ret["Responsavel"];
            //fornecedorBE.Tipo = ret["Tipo"];
            
            return fornecedorBE;
        }

        public static ClienteBE PegaLoginCliente(string json)
        {
            byte[] bytes = Encoding.Default.GetBytes(json);
            json = Encoding.UTF8.GetString(bytes);
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
                Nome = ret["Nome"],
                Sobrenome = ret["Sobrenome"],
                Numero = ret["Numero"],
                Senha = ret["Senha"],
                Situacao = ret["Situacao"],
                Status = ret["Status"],
                Telefone = ret["Telefone"],
                Uf = ret["Uf"],
                WhatsApp = ret["WhatsApp"],
                ZoopID = ret["ZoopID"]
            };
            return clienteBE;
        }
        public static ParticipanteBE PegaLoginParticipante(string json)
        {
            byte[] bytes = Encoding.Default.GetBytes(json);
            json = Encoding.UTF8.GetString(bytes);
            var ret = Newtonsoft.Json.JsonConvert.DeserializeObject<dynamic>(json);
            ParticipanteBE participanteBE = new ParticipanteBE()
            {
                IdParticipante = ret["IdParticipante"],
                Bairro = ret["Bairro"],
                Cep = ret["Cep"],
                Documento = ret["Documento"],
                Complemento = ret["Complemento"],
                data = ret["data"],
                Email = ret["Email"],
                Logradouro = ret["Logradouro"],
                cidade = ret["cidade"],
                Nome = ret["Nome"],
                Sobrenome = ret["Sobrenome"],
                Numero = ret["Numero"],
                Senha = ret["Senha"],
                Matriz = ret["Matriz"],
                Telefone = ret["Telefone"],
                Uf = ret["Uf"],
            };
            return participanteBE;
        }

    }
}
