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
    using M=Bsk.BE.Model;
    public partial class proposta : System.Web.UI.Page
    {
        core _core = new core();
        PropostaBE _PropostaBE = new PropostaBE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!String.IsNullOrEmpty(Request.QueryString["CodigoProposta"]))
                {
                    CarregaProposta(Request.QueryString["CodigoProposta"]);
                }
                else
                {
                    BtnDeletar.Visible = false;
                    BtnVisualizarCliente.Visible = false;
                    BtnVisualizar.Visible = false;
                }
            }
        }

        protected void btnSalvar_ServerClick(object sender, EventArgs e)
        {

            if(!String.IsNullOrEmpty(Request.QueryString["CodigoProposta"]))
            {
                _PropostaBE = _core.Proposta_Get(_PropostaBE, $" CodigoProposta='{Request.QueryString["CodigoProposta"]}'").FirstOrDefault();
            }


             _PropostaBE.Empresa = Empresa.Value;
            _PropostaBE.Responsavel = Responsavel.Value;
            _PropostaBE.Resumo = Resumo.Value;
            _PropostaBE.Servico = Servicos.Value;
            _PropostaBE.Total = Total.Value;
            _PropostaBE.Validade = Validade.Value;
            _PropostaBE.Condicao = Condicao.Value;
            _PropostaBE.Pagamento = Pagamento.Value;
            _PropostaBE.TituloInterno = tituloInterno.Value;
            _PropostaBE.EmailContato = emailContato.Value;

            if (String.IsNullOrEmpty(Request.QueryString["CodigoProposta"]))
            {
                _PropostaBE.CodigoProposta = DateTime.Now.ToString("yyyyMMddHHmmsm");
                _PropostaBE.HTML = HtmlProposta(_PropostaBE).Replace("'", "\"");
                _core.Proposta_Insert(_PropostaBE);
            }
            else
            {
                _PropostaBE.CodigoProposta = Request.QueryString["CodigoProposta"];
                _PropostaBE.DataAlteracao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");
                _PropostaBE.DataCriacao = lbDtCriacao.Text;
                _PropostaBE.HTML = HtmlProposta(_PropostaBE).Replace("'", "\"");
                _core.Proposta_Update(_PropostaBE, $" CodigoProposta='{_PropostaBE.CodigoProposta}'");
            }

            Response.Redirect($"proposta.aspx?CodigoProposta={_PropostaBE.CodigoProposta}");

        }


        public void CarregaProposta(string CodigoProposta)
        {

            _PropostaBE = _core.Proposta_Get(_PropostaBE, $" CodigoProposta='{CodigoProposta}'").FirstOrDefault();
            if (_PropostaBE != null)
            {
                lbDtCriacao.Text = _PropostaBE.DataCriacao;
                dtUltimaAlteracao.Text = _PropostaBE.DataAlteracao;
                Empresa.Value = _PropostaBE.Empresa;
                Responsavel.Value = _PropostaBE.Responsavel;
                Resumo.Value = _PropostaBE.Resumo;
                Servicos.Value = _PropostaBE.Servico;
                Total.Value = _PropostaBE.Total;
                Validade.Value = _PropostaBE.Validade;
                Condicao.Value = _PropostaBE.Condicao;
                Pagamento.Value = _PropostaBE.Pagamento;
                tituloInterno.Value = _PropostaBE.TituloInterno ;
                emailContato.Value = _PropostaBE.EmailContato ;
            }
            else
            {
                Response.Redirect("proposta.aspx");
            }
        }



        public string HtmlProposta(PropostaBE proposta)
        {
            var html = @" <!-- Save for Web Slices (bg1.png) -->
    <table id='Table_01' width='1188' height='1592' border='0' cellpadding='0' cellspacing='0' style='height: auto;margin: 0 auto;font-family: sans-serif;line-height: 22px;'>
        <tbody style='height: 0;'>
            <tr style='height: 0;'>
                <td style='padding: 0; display: block;'>
                    <img src='http://proposta.studiobrasuka.com.br/images/index_01.png' width='1188' height='198' alt=''></td>
            </tr>
            <tr style='height: 0;'>
                <td>
                    <p style='text-align: right;'>nº  " + proposta.CodigoProposta + @"</p>

                    <h3 style='text-align: center;'>São Paulo, " + DateTime.Now.ToString("dd/MM/yyyy")+ @"</h3>

                    <h2 style='text-align: center;'>Proposta Comercial</h2>

                    <div style='padding: 0 10vw; font-size: 1vw;'>
                        <p>A</p>

                        <p>" + proposta.Empresa + @"</p>

                        <p>Aos cuidados de " + proposta.Responsavel + @" <br> Prezados, apresentamos a vocês, proposta para:</p>
" + proposta.Resumo + @"

                        <p>Desde já agradecemos a oportunidade e nos colocamos à disposição para quaisquer esclarecimentos.</p>

                        <p><strong>1. Valor e serviços:</strong><br>" + proposta.Servico+ @"</p>

<p style='font-size:18px;'><strong>Total: " + proposta.Total + @" válido até "+proposta.Validade+ @"</strong></p>

                        <p><strong>2. Condições do serviço:</strong><br> " + proposta.Condicao + @"</p>

                        <p><strong>3. Condições de pagamento</strong><br>" + proposta.Pagamento + @" </p>

                        <p><strong>4. Termo de confidencialidade</strong><br> • Informações técnicas eventualmente obtidas durante a realização das atividades envolvidas nesta proposta comercial, como especificação, funcionamento, organização ou desempenho
                            da empresa cliente serão tidas como confidenciais e sigilosas sempre que tal condição for solicitada.</p>

                        <p><strong>5. Informações da empresa</strong><br>• O Studio Brasuka, fundado em 2014, é uma startup que atua como um braço tecnológico inovador no mercado e com grande destaque no ramo financeiro.</p>

                        <p style='text-align: center;'>&nbsp;</p>

                        <p style='text-align: center;'>Atenciosamente</p>

                        <p style='text-align: center;'>Felipe Dionisi</p>
                    </div>

                </td>
            </tr>
            <tr style='height: 0px!important;'>
                <td style='display: block;'>
                    <img src='http://proposta.studiobrasuka.com.br/images/index_03.png' width='1188' height='176' alt=''></td>
            </tr>
        </tbody>
    </table>
    <!-- End Save for Web Slices -->";

            return html;
        }

        protected void BtnVisualizar_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["CodigoProposta"]))
            {
                Response.Redirect($"bsk-visualizar-proposta.aspx?CodigoProposta={Request.QueryString["CodigoProposta"]}");
            }
        }

        protected void BtnVisualizarCliente_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["CodigoProposta"]))
            {
                Response.Redirect($"cliente-visualizar-proposta.aspx?CodigoProposta={Request.QueryString["CodigoProposta"]}");
            }
        }

        protected void BtnDeletar_ServerClick(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["CodigoProposta"]))
            {
                _PropostaBE = _core.Proposta_Get(_PropostaBE, $" CodigoProposta='{Request.QueryString["CodigoProposta"]}'").FirstOrDefault();
                _core.Proposta_Delete(_PropostaBE);
                Response.Redirect("lista-proposta.aspx");
            }
        }
    }
}