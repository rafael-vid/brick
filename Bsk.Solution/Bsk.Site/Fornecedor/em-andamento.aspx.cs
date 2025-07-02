using Bsk.BE;
using Bsk.BE.Model;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    public partial class em_andamento : System.Web.UI.Page
    {
        core _core = new core();
        SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public List<CotacaoFornecedorListaModel> PegaCotacoes()
        {
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cotacoes = _core.CotacaoFornecedorListaStatusGet(login.IdParticipante, "(4,5,6)");
            List<CotacaoFornecedorListaModel> lista = new List<CotacaoFornecedorListaModel>();
            foreach (var item in cotacoes)
            {
                Console.WriteLine($"Cotação ID: {item.CotacaoId}, Status: {item.Status}, CFId: {item.CFId}, IdFornecedorDB: {item.IdFornecedorDB}");

                bool adciona = true;

                if (item.Status == StatusCotacao.Aberto)
                {
                    item.Status = "Aberto";
                }
                else if (item.Status == StatusCotacao.AguardandoAvaliacao)
                {
                    item.Status = "Aguardando Avaliação";
                }
                else if (item.Status == StatusCotacao.EmAndamento)
                {
                    item.Status = "Em andamento";

                    if (item.FinalizaCliente == 0 && item.FinalizaFornecedor == 1)
                    {
                        item.Status = "Pendente de finalização do cliente";
                    }
                }
                else if (item.Status == StatusCotacao.AguardandoPagamento)
                {
                    item.Status = "Aguardando pagamento";
                }
                else if (item.Status == StatusCotacao.Finalizado)
                {
                    item.Status = "Finalizado";
                }
                // **IF FALTANTE ADICIONADO AQUI**
                else if (item.Status == StatusCotacao.AguardandoAceite)
                {
                    item.Status = "Aguardando Aceite";
                }

                if (adciona)
                {
                    lista.Add(item);
                }
            }
            return lista;
        }
    }
}