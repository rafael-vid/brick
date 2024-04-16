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
using Bsk.Util;
using Bsk.BE.Pag;
using ZstdSharp.Unsafe;

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

        public List<TransacaoModel> TransacaoModel_Get(string filtro)
        {
            var sql = $@"select 
                        T.IdTransacao, 
                        T.Status, 
                        T.IdCotacao, 
                        T.DataEnvio as DataCriacao, 
                        T.DataVencimento,
                        T.Url,
                        C.Titulo,
                        CF.Valor,
                        CL.Nome as Cliente,
                        F.RazaoSocial as Fornecedor,
                        CT.Nome as Categoria
                        from transacao T 
                        INNER JOIN cotacao C on C.IdCotacao = T.IdCotacao
                        INNER JOIN cotacaofornecedor CF on CF.IdCotacaoFornecedor = C.IdCotacaoFornecedor
                        INNER JOIN cliente CL on CL.IdCliente = C.IdCliente
                        INNER JOIN fornecedor F on F.IdFornecedor = CF.IdFornecedor
                        INNER JOIN categoria CT on CT.IdCategoria = C.IdCategoria where "+filtro;
            return _base.ToList<TransacaoModel>(db.Get(sql));
        }

        public List<CotacaoListaClienteModel> CotacaoClienteGet(string filtro)
        {
            string sql = $@"SELECT 
                                CT.IdCotacao, 
                                CT.Titulo, 
                                CT.DataCriacao,
                                CT.DataAlteracao,
                                CT.Status,
                                s.nome, 
                                CT.FinalizaFornecedor,
                                CT.FinalizaCliente,
                                CT.IdCotacaoFornecedor,
                                CT.EnviarProposta,
                                    CASE
                                        WHEN 
			                                    (select count(IdCotacaoFornecedorChat) 
			                                    from cotacaofornecedorchat 
			                                    where IdCliente = 0 and IdCotacaoFornecedor in (select IdCotacaoFornecedor from cotacaofornecedor where IdCotacao=CT.IdCotacao) and LidaCliente=0)  > 0 
		                                    THEN 'N'

                                        ELSE ''
                                    END 
                                as Mensagens
                            FROM cotacao CT
                                inner join status_cliente s
		                            on CT.status = s.id
                            where " + filtro;
            return _base.ToList<CotacaoListaClienteModel>(db.Get(sql));
        }
        public List<Dashboard> GetDashboardCliente(string filtro="1=1")
        {
            string sql = $@"select s.id, s.nome, s.ordem  from status_cliente s
                                where "+filtro+@"
                                    order by s.ordem asc";
            return _base.ToList<Dashboard>(db.Get(sql));
        }

        public List<Dashboard> GetDashboardFornecedor(string filtro="1=1")
        {
            string sql = $@"select s.id, s.nome, s.ordem  from status_fornecedor s
                                where " + filtro + @"
                                    order by s.ordem asc";
            return _base.ToList<Dashboard>(db.Get(sql));
        }

        public List<ClienteBE> EsqueciASenha(string filtro)
        {
            string sql = $@"SELECT 
                                Nome,
                                Senha
                            FROM cliente
                            where " + filtro;
            return _base.ToList<ClienteBE>(db.Get(sql));
        }

        public List<ClienteBE> EsqueciASenhaFornecedor(string filtro)
        {
            string sql = $@"SELECT 

                                Senha
                            FROM fornecedor
                            where " + filtro;
            return _base.ToList<ClienteBE>(db.Get(sql));
        }


        public List<NotificacaoModel> NotificacaoGet(string filtro)
        {
            string sql = $@"SELECT 
                                CT.idnotificacao, 
                                CT.titulo, 
                                CT.mensagem,
                                CT.link,
                                CT.visualizado,
                                CT.data
                            FROM notificacao CT
                            where " + filtro;
            return _base.ToList<NotificacaoModel>(db.Get(sql));
        }

        public void NotificacaoUpdate(int id)
        {
            string sql = $@"update notificacao set visualizado = 1 where idnotificacao = " + id;
            db.Execute(sql);
        }

        public string NotificacaoInsert(NotificacaoBE lg)
        {
            List<NotificacaoBE> Lista_lg = new List<NotificacaoBE>();
            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }


        public void AtualizaEnviaPropostaCotacao(int idCotacao)
        {
            string sql = $@"update cotacaofornecedor set EnviarProposta = 1 where IdCotacaoFornecedor = {idCotacao}";
            db.Execute(sql);
        }


        public List<CotacaoListaFronecedorModel> CotacaoFornecedorGet(string filtro)
        {
            string sql = $@"SELECT 
                                CT.IdCotacao, 
                                CT.Titulo, 
                                CT.DataCriacao,
                                CT.DataAlteracao,
                                CT.Status, 
                                CT.FinalizaFornecedor,
                                CT.FinalizaCliente,
                                CT.IdCotacaoFornecedor,
                                    CASE
                                        WHEN 
			                                    (select count(IdCotacaoFornecedorChat) 
			                                    from cotacaofornecedorchat 
			                                    where IdFornecedor = 0 and IdCotacaoFornecedor in (select IdCotacaoFornecedor from cotacaofornecedor where IdCotacao=CT.IdCotacao) and LidaCliente=0)  > 0 
		                                    THEN 'N'

                                        ELSE ''
                                    END 
                                as Mensagens
                            FROM cotacao CT
    
                             INNER JOIN CotacaoFornecedor CF on CT.IdCotacao = CF.IdCotacao
    
                            where " + filtro;
            return _base.ToList<CotacaoListaFronecedorModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaGet(int idFornecedor)
        {
            var sql = $@"select 
                            CT.IdCotacao as CotacaoId, 
                            CF.IdCotacaoFornecedor as CotacaoFornecedorId, 
                            CT.IdCLiente as ClienteId, 
                            CL.Nome, CT.Titulo, 
                            CT.Status, 
                            CT.FinalizaCliente, 
                            CT.FinalizaFornecedor, 
                            CT.IdCotacaoFornecedor as CFId,
                            CT.DataAlteracao,
                            s.Nome as StatusNome

                        from cotacao CT                      
                        inner join cliente CL on CL.IdCliente = CT.IdCliente
                        left join cotacaofornecedor CF on CT.IdCotacao = CF.IdCotacao
                        inner join status_cliente s on CT.status = s.id
                          order by DataAlteracao desc   ";
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public List<CotacaoListaFronecedorModel> CotacaoListaFronecedorGet(string categorias, string idFornecedor)
        {
            var sql = $@"select CT.IdCotacao, CT.Titulo, CA.Nome as Categoria
                            from cotacao CT 
                            inner join categoria CA on CA.IdCategoria = CT.IdCategoria
                            where CT.Status='{StatusCotacao.Aberto}' 
                            and CT.IdCotacao not in (select 
                                                        IdCotacao 
                                                    from cotacaofornecedor where IdFornecedor = {idFornecedor} 
                                                    and IdCotacao = CT.IdCotacao)
                            and CT.IdCategoria in ({categorias});";
            return _base.ToList<CotacaoListaFronecedorModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaAguardandoAceiteGet(int idFornecedor)
        {
            var sql = $@"select CF.IdCotacao as CotacaoId, CF.IdCotacaoFornecedor as CotacaoFornecedorId, CT.IdCLiente as ClienteId, CL.Nome, CT.Titulo, CT.Status, CT.FinalizaCliente, CT.FinalizaFornecedor, CT.IdCotacaoFornecedor as CFId
                        from cotacaofornecedor CF 
                        inner join cotacao CT
                        on CT.IdCotacao = CF.IdCotacao
                        inner join cliente CL
                        on CL.IdCliente = CT.IdCliente
                        where CT.FinalizaCliente = 0 and CT.FinalizaFornecedor=1 and CF.IdFornecedor =" + idFornecedor;
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaStatusGet(int idFornecedor, string status)
        {
            var sql = $@"select CF.IdCotacao as CotacaoId, CF.IdCotacaoFornecedor as CotacaoFornecedorId, CT.IdCLiente as ClienteId, CL.Nome, CT.Notafornecedor as Nota, CT.Titulo, CT.Status, CT.FinalizaCliente, CT.FinalizaFornecedor, CT.IdCotacaoFornecedor as CFId
                        from cotacaofornecedor CF 
                        inner join cotacao CT
                        on CT.IdCotacao = CF.IdCotacao
                        inner join cliente CL
                        on CL.IdCliente = CT.IdCliente
                        where CT.Status = {status} and CF.IdFornecedor =" + idFornecedor;
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public CotacaoAvaliacaoModel Cotacao_Avaliacao_Get(string idCotacao)
        {
            var sql = $@"select CT.IdCotacao, CT.Titulo, CT.Descricao, CT.Depoimento, CT.DataTermino, CT.Nota, CF.Valor, CF.IdCotacaoFornecedor, FC.RazaoSocial as NomeFornecedor
                            from cotacao CT 
                            inner join cotacaofornecedor CF 
                            on CF.IdCotacaoFornecedor = CT.IdCotacaoFornecedor 
                            inner join Fornecedor FC on FC.IdFornecedor = CF.IdFornecedor
                            where CT.IdCotacao= " + idCotacao;
            return _base.ToList<CotacaoAvaliacaoModel>(db.Get(sql)).FirstOrDefault();
        }

        public CotacaoAvaliacaoFornecedorModel Cotacao_Avaliacao_Fornecedor_Get(string idCotacao)
        {
            var sql = $@"select CT.IdCotacao, CT.Titulo, CT.Descricao, CT.Observacao, CT.NotaFornecedor as Nota, CF.Valor, CF.IdCotacaoFornecedor, CL.Nome as NomeCliente, CT.DataTermino
                            from cotacaofornecedor CF 
                            inner join cotacao CT 
                            on CF.IdCotacaoFornecedor = CT.IdCotacaoFornecedor 
                            inner join Cliente CL on CL.IdCliente = CT.IdCliente
                            where CF.IdCotacaoFornecedor= " + idCotacao;
            return _base.ToList<CotacaoAvaliacaoFornecedorModel>(db.Get(sql)).FirstOrDefault();
        }

        public List<CotacaoListaModel> CotacaoListaGet(string idCotacao)
        {
            string sql = $@"select 
                                CT.IdCotacao as CotacaoId, 
                                FC.RazaoSocial as NomeFornecedor, 
                                CF.IdCotacaoFornecedor as CotacaoFornecedorId, 
                                CF.Valor, 
                                CF.Ativo,
                                CF.Novo,
                                CASE
                                WHEN 
			                            (select count(IdCotacaoFornecedorChat) 
			                            from cotacaofornecedorchat 
			                            where IdCliente = 0 and IdCotacaoFornecedor= CF.IdCotacaoFornecedor and LidaCliente=0)  > 0 
		                            THEN 'N'

                                ELSE ''
                            END as Mensagens,
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
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
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
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
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

        ////////////////////////////////////////////// AreaFornecedor ////////////////////////////////////////////////////////////
        public List<AreaFornecedorBE> AreaFornecedor_Get(AreaFornecedorBE lg, string _filtro)
        {
            List<AreaFornecedorBE> Lista_lg = new List<AreaFornecedorBE>();
            Lista_lg.Add(lg);
            return _base.ToList<AreaFornecedorBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string AreaFornecedor_Insert(AreaFornecedorBE lg)
        {
            List<AreaFornecedorBE> Lista_lg = new List<AreaFornecedorBE>();
            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void AreaFornecedor_Update(AreaFornecedorBE lg, string filtro)
        {
            List<AreaFornecedorBE> Lista_lg = new List<AreaFornecedorBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void AreaFornecedor_Delete(AreaFornecedorBE lg)
        {
            List<AreaFornecedorBE> Lista_lg = new List<AreaFornecedorBE>();
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
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            lg.Status = "0";
            List<ClienteBE> Lista_lg = new List<ClienteBE>();

            Lista_lg.Add(lg);
            string sql = _base.Insert(Lista_lg, null);
            return db.Insert(sql);
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
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");

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
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
            lg.DataAlteracao = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm"));
            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Cotacao_Update(CotacaoBE lg, string filtro)
        {
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
            lg.DataAlteracao = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm"));
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
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
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
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
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

        ////////////////////////////////////////////// Transacao ////////////////////////////////////////////////////////////
        public List<TransacaoBE> Transacao_Get(TransacaoBE lg, string _filtro)
        {
            List<TransacaoBE> Lista_lg = new List<TransacaoBE>();
            Lista_lg.Add(lg);
            return _base.ToList<TransacaoBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Transacao_Insert(TransacaoBE lg)
        {
            List<TransacaoBE> Lista_lg = new List<TransacaoBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Transacao_Update(TransacaoBE lg, string filtro)
        {
            List<TransacaoBE> Lista_lg = new List<TransacaoBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Transacao_Delete(TransacaoBE lg)
        {
            List<TransacaoBE> Lista_lg = new List<TransacaoBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// RedefinirSenha ////////////////////////////////////////////////////////////
        public List<RedefinirSenhaBE> RedefinirSenha_Get(RedefinirSenhaBE lg, string _filtro)
        {
            List<RedefinirSenhaBE> Lista_lg = new List<RedefinirSenhaBE>();
            Lista_lg.Add(lg);
            return _base.ToList<RedefinirSenhaBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string RedefinirSenha_Insert(RedefinirSenhaBE lg)
        {
            List<RedefinirSenhaBE> Lista_lg = new List<RedefinirSenhaBE>();
            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void RedefinirSenha_Update(RedefinirSenhaBE lg, string filtro)
        {
            List<RedefinirSenhaBE> Lista_lg = new List<RedefinirSenhaBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void RedefinirSenha_Delete(RedefinirSenhaBE lg)
        {
            List<RedefinirSenhaBE> Lista_lg = new List<RedefinirSenhaBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

    }
}
