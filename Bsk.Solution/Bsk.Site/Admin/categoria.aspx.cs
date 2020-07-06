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

    public partial class categoria : System.Web.UI.Page
    {
        core _core = new core();
        CategoriaBE _CategoriaBE = new CategoriaBE();
        ServicoBE _ServicoBE = new ServicoBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if(!IsPostBack)
            {
                CarregaCategoria();
            }

        }


        public void CarregaCategoria()
        {
            
            if (!String.IsNullOrEmpty(Request.QueryString["Categoria"]))
            {
                _CategoriaBE = _core.Categoria_Get(_CategoriaBE, $" IdCategoria={Request.QueryString["Categoria"]}").FirstOrDefault();
                if (_CategoriaBE != null)
                {
                    titulo.Value = _CategoriaBE.Nome;
                    chkStatus.Checked = (_CategoriaBE.Status =="1") ? true : false;
                    imgRep.ImageUrl = "../RepositoryImg/"+ _CategoriaBE.Imagem;
                }
            }
        }


        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            
            if(!String.IsNullOrEmpty(titulo.Value))
            { 
            if (!String.IsNullOrEmpty(Request.QueryString["Categoria"]))
            {  
                _CategoriaBE = _core.Categoria_Get(_CategoriaBE, $" IdCategoria={Request.QueryString["Categoria"]}").FirstOrDefault();
                _CategoriaBE.Nome = titulo.Value;
                _CategoriaBE.Status = (chkStatus.Checked) ?"1" : "0";
                _CategoriaBE.Imagem = GravarArquivo(flpImg, _CategoriaBE.Imagem);
                _core.Categoria_Update(_CategoriaBE, $" IdCategoria={Request.QueryString["Categoria"]}");
                Response.Redirect("msg.aspx?Chave=AtualizaCategoria");
            }
            else
            {

                _CategoriaBE.Nome = titulo.Value;
                _CategoriaBE.Imagem = GravarArquivo(flpImg, "");
                _core.Categoria_Insert(_CategoriaBE);
                Response.Redirect("msg.aspx?Chave=InserirCategoria");

            }
            }
            else
            {
                lb.Text = "Campo obrigatorio.";
            }

        }



        public string GravarArquivo(FileUpload _flpImg, string imagem)
        {
            var _imagem="";

            if (!String.IsNullOrEmpty(_flpImg.FileName))
            {
                if((!String.IsNullOrEmpty(_flpImg.FileName))&&(imagem != "0.png") && (imagem != ""))
                { 
                    System.IO.File.Delete(Server.MapPath($"~/RepositoryImg")+"\\"+imagem);
                }

                _imagem = Guid.NewGuid().ToString() + flpImg.FileName;
                var path = Server.MapPath("~/RepositoryImg") + "\\" + _imagem;
                _flpImg.SaveAs(path);

            }
            else if (imagem != "0.png" && String.IsNullOrEmpty(_flpImg.FileName))
            {
                _imagem = imagem;
            }
            else
            {
                _imagem = "0.png";
            }


            return _imagem;
        }

        protected void btnDel_ServerClick(object sender, EventArgs e)
        {
            if(!String.IsNullOrEmpty(Request.QueryString["Categoria"]))
            {
                var cat = _core.Categoria_Get(_CategoriaBE, $" IdCategoria={Request.QueryString["Categoria"]}").FirstOrDefault();
                if(cat != null)
                {
                    var servico = _core.Servico_Get(_ServicoBE, $" IdCategoria={cat.IdCategoria}");
                    foreach (var item in servico)
                    {
                        _core.Servico_Delete(item);
                    }
                    _core.Categoria_Delete(cat);
                }
                Response.Redirect("msg.aspx?Chave=DeletarCategoria");
            }
        }
    }
}