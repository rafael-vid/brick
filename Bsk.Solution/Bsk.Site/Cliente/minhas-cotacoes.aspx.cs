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

namespace Bsk.Site.Cliente
{
    public partial class minhas_cotacoes : System.Web.UI.Page
    {
        core _core = new core();
        CotacaoBE _CotacaoBE = new CotacaoBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public List<CotacaoListaClienteModel> PegaCotacoes()
        {
            var login = Funcoes.PegaLoginCliente(Request.Cookies["Login"].Value);
            var cotCliente = _core.CotacaoClienteGet($" CT.IdCliente=" + login.IdCliente + " order by DataAlteracao desc");
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
                else if (item.Status == StatusCotacao.Avaliado)
                {
                    item.Status = "Avaliado";
                }
            }
            return cotCliente;
        }
    }
}