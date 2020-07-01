using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Comtele.Sdk.Services;
using System.Configuration;

namespace Bsk.Util
{
    public class Sms
    {

        private string API_KEY = "946a3942-e9b5-46ae-942a-3d973d85817a";

        public bool EnviaSms (string msg, string telefone)
        {
            var textMessageService = new TextMessageService(API_KEY);
            var result = textMessageService.Send(
             "",                        // Sender: Id de requisicao da sua aplicacao para ser retornado no relatorio, pode ser passado em branco.
             msg,                 // Content: Conteudo da mensagem a ser enviada.
             new string[] { telefone }  // Receivers: Numero de telefone que vai ser enviado o SMS.
            );

            if (result.Success)
            {
                Console.WriteLine("A mensagem foi enviada com sucesso.");
                return true;
            }
            else
            {
                Console.WriteLine("A mensagem não pode ser enviada. Detalhes: " + result.Message);
                return false;
            }
        }

    }

}
