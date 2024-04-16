using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Admin
{
    using Bsk.BE;
    using Bsk.Interface;
    using System.Runtime.Remoting.Messaging;
    using M = Bsk.BE.Model;
    public partial class cadastro_servico : System.Web.UI.Page
    {
        core _core = new core();
        CategoriaBE _CategoriaBE = new CategoriaBE();
        ServicoBE _ServicoBE = new ServicoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                categoria.InnerText = Request.QueryString["Categoria"];
                
                if (!String.IsNullOrEmpty(Request.QueryString["IdServico"]))
                {
                    var servico =  _core.Servico_Get(_ServicoBE, $" IdServico={Request.QueryString["IdServico"]}").FirstOrDefault();
                    if(servico!=null)
                    {
                        titulo.Value = servico.Nome;
                    }
                }
            }
        }

        public List<ServicoBE> CarregaServico()
        {
            return _core.Servico_Get(_ServicoBE, $" IdCategoria={Request.QueryString["IdCategoria"]}");
        }

        protected void btnDeletar_ServerClick(object sender, EventArgs e)
        {

            if (!String.IsNullOrEmpty(Request.QueryString["IdServico"]))
            {
                var url = $"cadastro-servico.aspx?Categoria={Request.QueryString["Categoria"]}&IdCategoria={Request.QueryString["IdCategoria"]}";
                var servico = _core.Servico_Get(_ServicoBE, $" IdServico={Request.QueryString["IdServico"]}").FirstOrDefault();
                if (servico != null)
                {
                    _core.Servico_Delete(servico);
                    Response.Redirect(url);
                }
            }
        }

        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["Categoria"]))
            {
                if (!String.IsNullOrEmpty(titulo.Value))
                {
                    var url = $"cadastro-servico.aspx?Categoria={Request.QueryString["Categoria"]}&IdCategoria={Request.QueryString["IdCategoria"]}";
                    _ServicoBE.Nome = titulo.Value;
                    _ServicoBE.Status = "1";
                    _ServicoBE.IdCategoria = Convert.ToInt32(Request.QueryString["IdCategoria"]);

                    if (!String.IsNullOrEmpty(Request.QueryString["IdServico"]))
                    {
                        _ServicoBE.IdServico = Convert.ToInt32(Request.QueryString["IdServico"]);
                        _core.Servico_Update(_ServicoBE, $" IdServico={Request.QueryString["IdServico"]}");
                        Response.Redirect(url);
                    }
                    else
                    {
                        _core.Servico_Insert(_ServicoBE);
                        Response.Redirect(url);
                    }
                }
                else
                {
                    lb.Text = "Campo obrigatório.";
                }
            }
        }
    }
}