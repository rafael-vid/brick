using Bsk.BE;
using Bsk.BE.Model;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class recusadas : System.Web.UI.Page
    {
        core _core = new core();
        SolicitacaoBE _SolicitacaoBE = new SolicitacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CotacaoListaClienteModel> PegaCotacoes()
        {
            ParticipanteBE login = Funcoes.PegaLoginParticipante(Request.Cookies["Login"].Value);
            var cotCliente = _core.CotacaoClienteGet($" CT.IdParticipante=" + login.IdParticipante + " and CT.Status = 9 order by DataAlteracao desc");
            if (Request.QueryString["status"] != null)
            {
                cotCliente = cotCliente.Where(x => x.Status == Request.QueryString["status"]).ToList();
            }
            foreach (var item in cotCliente)
            {
                if (item.Status == StatusCotacao.Criacao)
                {
                    item.Status = "Criação";
                }
                else if (item.Status == StatusCotacao.Aberto)
                {
                    item.Status = "Aberto";
                }
                else if (item.Status == StatusCotacao.EmAndamento)
                {
                    item.Status = "Em andamento";

                    if (item.FinalizaFornecedor == 1 && item.FinalizaCliente == 0)
                    {
                        item.Status = "Pendente de aceite do cliente";
                    }
                    else if (item.FinalizaFornecedor == 1 && item.FinalizaCliente == 1)
                    {
                        item.Status = "Aguardando liberação do pagamento";
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
                else if (item.Status == StatusCotacao.AguardandoAvaliacao)
                {
                    item.Status = "Aguardando Avaliação";
                }
                else if (item.Status == StatusCotacao.Recusado)
                {
                    item.Status = "Recusado";
                }
            }
            return cotCliente;
        }
    }
}