using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Bsk.Site.Cliente
{
    public partial class negociar_cotacao : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_ServerClick(object sender, EventArgs e)
        {

            var x = flpArquivo.FileName;
            var y = flpVideo.FileName;
            if (!IsPostBack)
            {
               // var x = flpArquivo.FileName;
            }
        }


        public string GravarArquivo(FileUpload _flpImg)
        {
            var nome = "";
            var link = "<a href='"+ConfigurationManager.AppSettings["host"]+ "/Anexos/Documento/{{ARQ}}'> </a>"
            if (!String.IsNullOrEmpty(_flpImg.FileName))
            {
                nome = Guid.NewGuid().ToString() + _flpImg.FileName;
                var path = Server.MapPath("~/Anexos/Documento") + "\\" + nome;
                _flpImg.SaveAs(path);

            }
            
            return nome;
        }
    }
}