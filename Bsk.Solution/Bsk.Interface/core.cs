using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Bsk.BE;
using Bsk.DAL;
using _base = Bsk.DAL.Helper.Convertions;
using System.Data;
using System.Net;
using System.Xml;
using Bsk.BE.Model;

namespace Bsk.Interface
{
    public class core
    {
        Dictionary<string, string> dinamico = new Dictionary<string, string>();
        dbComum db = new dbComum();

        public DataTable GetFree(string _filtro)
        {
            return db.Get(_filtro);
        }

        public void ExecFree(string _filtro)
        {
            db.Execute(_filtro);
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaGet(int idFornecedor)
        {
            var sql = $@"select CF.IdCotacao as CotacaoId, CF.IdCotacaoFornecedor as CotacaoFornecedorId, CT.IdCLiente as ClienteId, CL.Nome, CT.Titulo, CT.Status, CT.FinalizaCliente, CT.FinalizaFornecedor
                        from cotacaofornecedor CF 
                        inner join cotacao CT
                        on CT.IdCotacao = CF.IdCotacao
                        inner join cliente CL
                        on CL.IdCliente = CT.IdCliente
                        where CF.IdFornecedor =" + idFornecedor;
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaAguardandoAceiteGet(int idFornecedor)
        {
            var sql = $@"select CF.IdCotacao as CotacaoId, CF.IdCotacaoFornecedor as CotacaoFornecedorId, CT.IdCLiente as ClienteId, CL.Nome, CT.Titulo, CT.Status, CT.FinalizaCliente, CT.FinalizaFornecedor
                        from cotacaofornecedor CF 
                        inner join cotacao CT
                        on CT.IdCotacao = CF.IdCotacao
                        inner join cliente CL
                        on CL.IdCliente = CT.IdCliente
                        where CT.FinalizaCliente = 0 and CT.FinalizaFornecedor=1 and CF.IdFornecedor =" + idFornecedor;
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaAguardandoPagamentoGet(int idFornecedor)
        {
            var sql = $@"select CF.IdCotacao as CotacaoId, CF.IdCotacaoFornecedor as CotacaoFornecedorId, CT.IdCLiente as ClienteId, CL.Nome, CT.Titulo, CT.Status, CT.FinalizaCliente, CT.FinalizaFornecedor
                        from cotacaofornecedor CF 
                        inner join cotacao CT
                        on CT.IdCotacao = CF.IdCotacao
                        inner join cliente CL
                        on CL.IdCliente = CT.IdCliente
                        where CT.Status = 3 and CF.IdFornecedor =" + idFornecedor;
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public CotacaoAvaliacaoModel Cotacao_Avaliacao_Get(string idCotacao)
        {
            var sql = $@"select CT.IdCotacao, CT.Titulo, CT.Descricao, CT.Depoimento, CT.Nota, CF.Valor, CF.IdCotacaoFornecedor, FC.RazaoSocial as NomeFornecedor
                            from cotacao CT 
                            inner join cotacaofornecedor CF 
                            on CF.IdCotacaoFornecedor = CT.IdCotacaoFornecedor 
                            inner join Fornecedor FC on FC.IdFornecedor = CF.IdFornecedor
                            where CT.IdCotacao= " + idCotacao;
            return _base.ToList<CotacaoAvaliacaoModel>(db.Get(sql)).FirstOrDefault();
        }

        public List<CotacaoListaModel> CotacaoListaGet(string idCotacao)
        {
            string sql = $@"select 
                                CT.IdCotacao as CotacaoId, 
                                FC.RazaoSocial as NomeFornecedor, 
                                CF.IdCotacaoFornecedor as CotacaoFornecedorId, 
                                CF.Valor, 
                                (select 
                                count(IdCotacaoFornecedorChat) 
                                from cotacaofornecedorchat 
                                where IdCotacaoFornecedor = CF.IdCotacaoFornecedor) AS NumeroMensagens, 
                                (select DataCriacao 
                                from cotacaofornecedorchat 
                                where IdCotacaoFornecedor = CF.IdCotacaoFornecedor 
                                ORDER BY IdCotacaoFornecedorChat DESC LIMIT 1) AS DataUltimaResposta
                            from cotacao CT 
                            inner join cotacaofornecedor CF on CT.IdCotacao = CF.IdCotacao 
                            inner join fornecedor FC on CF.IdFornecedor = FC.IdFornecedor
                                where CT.IdCotacao = {idCotacao}";
            return _base.ToList<CotacaoListaModel>(db.Get(sql));
        }

        public List<CotacaoPagamentoModel> CotacaoStatusGet(string status, int idCliente)
        {
            string sql = $@"select 
                                CT.IdCotacao as CotacaoId, 
                                CT.Status,
                                FC.RazaoSocial as NomeFornecedor, 
                                CF.IdCotacaoFornecedor as CotacaoFornecedorId, 
                                CF.Valor
                                
                            from cotacao CT 
                            inner join cotacaofornecedor CF on CT.IdCotacaoFornecedor = CF.IdCotacaoFornecedor 
                            inner join fornecedor FC on CF.IdFornecedor = FC.IdFornecedor
                                where CT.Status = {status} AND CT.IdCliente={idCliente}";
            return _base.ToList<CotacaoPagamentoModel>(db.Get(sql));
        }


        ////////////////////////////////////////////// Admin ////////////////////////////////////////////////////////////
        public List<AdminBE> Admin_Get(AdminBE lg, string _filtro)
        {

            List<AdminBE> Lista_lg = new List<AdminBE>();
            Lista_lg.Add(lg);
            return _base.ToList<AdminBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Admin_Insert(AdminBE lg)
        {

            List<AdminBE> Lista_lg = new List<AdminBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Admin_Update(AdminBE lg, string filtro)
        {

            List<AdminBE> Lista_lg = new List<AdminBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Admin_Delete(AdminBE lg)
        {
            List<AdminBE> Lista_lg = new List<AdminBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }
        public List<PropostaBE> Proposta_Get(PropostaBE lg, string _filtro)
        {

            List<PropostaBE> Lista_lg = new List<PropostaBE>();
            Lista_lg.Add(lg);
            return _base.ToList<PropostaBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }
        public string Proposta_Insert(PropostaBE lg)
        {

            List<PropostaBE> Lista_lg = new List<PropostaBE>();
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");
            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Proposta_Update(PropostaBE lg, string filtro)
        {

            List<PropostaBE> Lista_lg = new List<PropostaBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Proposta_Delete(PropostaBE lg)
        {
            List<PropostaBE> Lista_lg = new List<PropostaBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// Fornecedor ////////////////////////////////////////////////////////////
        public List<FornecedorBE> Fornecedor_Get(FornecedorBE lg, string _filtro)
        {

            List<FornecedorBE> Lista_lg = new List<FornecedorBE>();
            Lista_lg.Add(lg);
            return _base.ToList<FornecedorBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Fornecedor_Insert(FornecedorBE lg)
        {
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");
            lg.Status = "0";
            List<FornecedorBE> Lista_lg = new List<FornecedorBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Fornecedor_Update(FornecedorBE lg, string filtro)
        {

            List<FornecedorBE> Lista_lg = new List<FornecedorBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Fornecedor_Delete(FornecedorBE lg)
        {
            List<FornecedorBE> Lista_lg = new List<FornecedorBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }


        ////////////////////////////////////////////// Alert ////////////////////////////////////////////////////////////
        public List<AlertBE> Alert_Get(AlertBE lg, string _filtro)
        {

            List<AlertBE> Lista_lg = new List<AlertBE>();
            Lista_lg.Add(lg);
            return _base.ToList<AlertBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Alert_Insert(AlertBE lg)
        {

            List<AlertBE> Lista_lg = new List<AlertBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Alert_Update(AlertBE lg, string filtro)
        {

            List<AlertBE> Lista_lg = new List<AlertBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Alert_Delete(AlertBE lg)
        {
            List<AlertBE> Lista_lg = new List<AlertBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// Categoria ////////////////////////////////////////////////////////////
        public List<CategoriaBE> Categoria_Get(CategoriaBE lg, string _filtro)
        {

            List<CategoriaBE> Lista_lg = new List<CategoriaBE>();
            Lista_lg.Add(lg);
            return _base.ToList<CategoriaBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Categoria_Insert(CategoriaBE lg)
        {

            lg.Status = "1";
            List<CategoriaBE> Lista_lg = new List<CategoriaBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Categoria_Update(CategoriaBE lg, string filtro)
        {

            List<CategoriaBE> Lista_lg = new List<CategoriaBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Categoria_Delete(CategoriaBE lg)
        {
            List<CategoriaBE> Lista_lg = new List<CategoriaBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// Master ////////////////////////////////////////////////////////////
        public List<MasterBE> Master_Get(MasterBE lg, string _filtro)
        {

            List<MasterBE> Lista_lg = new List<MasterBE>();
            Lista_lg.Add(lg);
            return _base.ToList<MasterBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Master_Insert(MasterBE lg)
        {

            List<MasterBE> Lista_lg = new List<MasterBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Master_Update(MasterBE lg, string filtro)
        {

            List<MasterBE> Lista_lg = new List<MasterBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Master_Delete(MasterBE lg)
        {
            List<MasterBE> Lista_lg = new List<MasterBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// Servico ////////////////////////////////////////////////////////////
        public List<ServicoBE> Servico_Get(ServicoBE lg, string _filtro)
        {

            List<ServicoBE> Lista_lg = new List<ServicoBE>();
            Lista_lg.Add(lg);
            return _base.ToList<ServicoBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Servico_Insert(ServicoBE lg)
        {

            lg.Status = "0";
            List<ServicoBE> Lista_lg = new List<ServicoBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Servico_Update(ServicoBE lg, string filtro)
        {

            List<ServicoBE> Lista_lg = new List<ServicoBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Servico_Delete(ServicoBE lg)
        {
            List<ServicoBE> Lista_lg = new List<ServicoBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// Cliente ////////////////////////////////////////////////////////////
        public List<ClienteBE> Cliente_Get(ClienteBE lg, string _filtro)
        {

            List<ClienteBE> Lista_lg = new List<ClienteBE>();
            Lista_lg.Add(lg);
            return _base.ToList<ClienteBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Cliente_Insert(ClienteBE lg)
        {
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");
            lg.Status = "0";
            List<ClienteBE> Lista_lg = new List<ClienteBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Cliente_Update(ClienteBE lg, string filtro)
        {

            List<ClienteBE> Lista_lg = new List<ClienteBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Cliente_Delete(ClienteBE lg)
        {
            List<ClienteBE> Lista_lg = new List<ClienteBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// CotacaoAnexos ////////////////////////////////////////////////////////////
        public List<CotacaoAnexosBE> CotacaoAnexos_Get(CotacaoAnexosBE lg, string _filtro)
        {

            List<CotacaoAnexosBE> Lista_lg = new List<CotacaoAnexosBE>();
            Lista_lg.Add(lg);
            return _base.ToList<CotacaoAnexosBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string CotacaoAnexos_Insert(CotacaoAnexosBE lg)
        {
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");

            List<CotacaoAnexosBE> Lista_lg = new List<CotacaoAnexosBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void CotacaoAnexos_Update(CotacaoAnexosBE lg, string filtro)
        {

            List<CotacaoAnexosBE> Lista_lg = new List<CotacaoAnexosBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void CotacaoAnexos_Delete(CotacaoAnexosBE lg)
        {
            List<CotacaoAnexosBE> Lista_lg = new List<CotacaoAnexosBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// Cotacao ////////////////////////////////////////////////////////////
        public List<CotacaoBE> Cotacao_Get(CotacaoBE lg, string _filtro)
        {

            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
            Lista_lg.Add(lg);
            return _base.ToList<CotacaoBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Cotacao_Insert(CotacaoBE lg)
        {
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");
            lg.Status = "0";
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Cotacao_Update(CotacaoBE lg, string filtro)
        {

            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Cotacao_Delete(CotacaoBE lg)
        {
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// CotacaoFornecedor ////////////////////////////////////////////////////////////
        public List<CotacaoFornecedorBE> CotacaoFornecedor_Get(CotacaoFornecedorBE lg, string _filtro)
        {

            List<CotacaoFornecedorBE> Lista_lg = new List<CotacaoFornecedorBE>();
            Lista_lg.Add(lg);
            return _base.ToList<CotacaoFornecedorBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string CotacaoFornecedor_Insert(CotacaoFornecedorBE lg)
        {
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");
            List<CotacaoFornecedorBE> Lista_lg = new List<CotacaoFornecedorBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void CotacaoFornecedor_Update(CotacaoFornecedorBE lg, string filtro)
        {

            List<CotacaoFornecedorBE> Lista_lg = new List<CotacaoFornecedorBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void CotacaoFornecedor_Delete(CotacaoFornecedorBE lg)
        {
            List<CotacaoFornecedorBE> Lista_lg = new List<CotacaoFornecedorBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// CotacaoFornecedorChat ////////////////////////////////////////////////////////////
        public List<CotacaoFornecedorChatBE> CotacaoFornecedorChat_Get(CotacaoFornecedorChatBE lg, string _filtro)
        {

            List<CotacaoFornecedorChatBE> Lista_lg = new List<CotacaoFornecedorChatBE>();
            Lista_lg.Add(lg);
            return _base.ToList<CotacaoFornecedorChatBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string CotacaoFornecedorChat_Insert(CotacaoFornecedorChatBE lg)
        {
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:s");
            lg.Status = "1";
            List<CotacaoFornecedorChatBE> Lista_lg = new List<CotacaoFornecedorChatBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void CotacaoFornecedorChat_Update(CotacaoFornecedorChatBE lg, string filtro)
        {

            List<CotacaoFornecedorChatBE> Lista_lg = new List<CotacaoFornecedorChatBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void CotacaoFornecedorChat_Delete(CotacaoFornecedorChatBE lg)
        {
            List<CotacaoFornecedorChatBE> Lista_lg = new List<CotacaoFornecedorChatBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }
    }
}
