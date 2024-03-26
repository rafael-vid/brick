using Bsk.BE;
using Bsk.Interface;
using Bsk.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Fornecedor
{
    public partial class minhas_areas : System.Web.UI.Page
    {
        core _core = new core();
        CategoriaBE CategoriaBE = new CategoriaBE();
        ServicoBE ServicoBE = new ServicoBE();
        AreaFornecedorBE AreaFornecedorBE = new AreaFornecedorBE();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public List<ServicoBE> PegaServico(CategoriaBE categoria)
        {
            List<ServicoBE> servicos = new List<ServicoBE>();
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var cat = _core.AreaFornecedor_Get(AreaFornecedorBE, $"IdCategoria={categoria.IdCategoria} AND IdFornecedor={login.IdFornecedor}").FirstOrDefault();
            if (cat != null)
            {
                servicos = _core.Servico_Get(ServicoBE, $"IdServico in ({cat.IdServico}0)");
            }
            return servicos;
        }

        public List<CategoriaBE> BuscaAreas()
        {
            FornecedorBE login = Funcoes.PegaLoginFornecedor(Request.Cookies["LoginFornecedor"].Value);
            var af = _core.AreaFornecedor_Get(AreaFornecedorBE, "IdFornecedor="+login.IdFornecedor);
            string filtro = "";
            foreach (var item in af)
            {
                filtro += item.IdCategoria+",";
            }
            return _core.Categoria_Get(CategoriaBE, $" IdCategoria in ({filtro}0)");
        }

        public List<CategoriaBE> BuscaCategoria()
        {
            if (Request.QueryString["Cat"] != null)
            {
                return _core.Categoria_Get(CategoriaBE, $" IdCategoria in ({Request.QueryString["Cat"]})");
            }
            else
            {
                return _core.Categoria_Get(CategoriaBE, "1=1");
            }

        }       
    }
}