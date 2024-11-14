using Bsk.Util.APIObjects;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace Bsk.Util
{
    public class API
    {


        /***********************************************************************************/
        /** METODOS COM CHAMADA GET ********************************************************/
        /***********************************************************************************/
        
        
        public String GetLogin(String email, String senha)
        {
            String MetodoPath = "Login?email="+email+"&senha="+senha;
            return CallGET(MetodoPath); 
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Participante"></param>
        /// <returns></returns>
        public String GetEmCotacao(int Participante)
        {
            String MetodoPath = "EmCotacao?Participante="+ Participante;
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Participante"></param>
        /// <returns></returns>
        public String GetEmAndamento(int Participante)
        {
            String MetodoPath = "EmAndamento?Participante="+ Participante;
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <param name="Participante"></param>
        /// <returns></returns>
        public String GetFinalizados(int Participante)
        {
            String MetodoPath = "Finalizados?Participante="+Participante;
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetPagamentos()
        {
            String MetodoPath = "Pagamentos?Participante=36";
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetPagamento()
        {
            String MetodoPath = "Pagamento?Participante=36&Pagamento=118";
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetNotificacao()
        {
            String MetodoPath = "Pagamento?Participante=36&Pagamento=118";
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetFornecedor()
        {
            String MetodoPath = "Fornecedor?Cotacao=117";
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetCategoria()
        {
            String MetodoPath = "Categoria";
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetAnexo()
        {
            String MetodoPath = "Anexo?Cotacao=117";
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetStatus()
        {
            String MetodoPath = "Status";
            return CallGET(MetodoPath);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public String GetChat()
        {
            String MetodoPath = "Chat?CotacaoFornecedor=117";
            return CallGET(MetodoPath);
        }





        /***********************************************************************************/
        /** METODOS COM CHAMADA POST *******************************************************/
        /***********************************************************************************/
        
        
        public String PostCadastro(Bsk.Util.APIObjects.Cadastro cadastro)
        {
            String MetodoPath = "Cadastro";
            return CallPOST(MetodoPath, cadastro);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <param name="cadastro"></param>
        /// <returns></returns>
        public String PostCriarRascunho(Bsk.Util.APIObjects.Cadastro cadastro)
        {
            String MetodoPath = "CriarRascunho";
            return CallPOST(MetodoPath, cadastro);
        }

        /***********************************************************************************/
        /// <summary>
        /// 
        /// </summary>
        /// <param name="cadastro"></param>
        /// <returns></returns>
        public String PostSalvarSolicitacao(Bsk.Util.APIObjects.Cadastro cadastro)
        {
            String MetodoPath = "SalvarSolicitacao";
            return CallPOST(MetodoPath, cadastro);
        }

        /***********************************************************************************/









        public string CallGET(string method)
        {
            try
            {
                var httpWebRequest = (HttpWebRequest)WebRequest.Create(WebConfigurationManager.AppSettings["ApiUrl"] + method);
                httpWebRequest.ContentType = "application/json";
                httpWebRequest.Method = "GET";
                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    var retorno = streamReader.ReadToEnd();
                    return retorno;
                }
            }
            catch (Exception e)
            {
                return "";
            }
        }

        public string CallPOST(string method, Object obj)
        {
            try
            {
                var httpWebRequest = (HttpWebRequest)WebRequest.Create(WebConfigurationManager.AppSettings["ApiUrl"] + method);
                httpWebRequest.ContentType = "application/json";
                httpWebRequest.Method = "POST";
                var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
                using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
                {
                    var retorno = streamReader.ReadToEnd();
                    return retorno;
                }
            }
            catch (Exception e)
            {
                return "";
            }
        }
    }
}
