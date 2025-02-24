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
                        T.IdSolicitacao, 
                        T.DataEnvio as DataCriacao, 
                        T.DataVencimento,
                        T.Url,
                        C.Titulo,
                        CF.Valor,
                        CL.Nome as Cliente,
                        F.RazaoSocial as Fornecedor,
                        CT.Nome as Categoria
                        from transacao T 
                        INNER JOIN solicitacao C on C.IdSolicitacao = T.IdSolicitacao
                        INNER JOIN cotacao CF on CF.IdCotacao = C.IdCotacao
                        INNER JOIN cliente CL on CL.IdCliente = C.IdCliente
                        INNER JOIN fornecedor F on F.IdFornecedor = CF.IdFornecedor
                        INNER JOIN categoria CT on CT.IdCategoria = C.IdCategoria where " + filtro;
            return _base.ToList<TransacaoModel>(db.Get(sql));
        }

        public List<CotacaoListaClienteModel> CotacaoClienteGet(string filtro)
        {
            string sql = $@"SELECT 
                                CT.IdSolicitacao, 
                                CT.Titulo, 
                                CT.DataCriacao,
                                CT.DataAlteracao,
                                CT.Status,
                                s.nome, 
                                CT.FinalizaFornecedor,
                                CT.FinalizaCliente,
                                CT.IdCotacao,
                                CT.EnviarProposta,
                                    CASE
                                        WHEN 
			                                    (select count(IdCotacaoFornecedorChat) 
			                                    from cotacaofornecedorchat 
			                                    where IdCliente = 0 and IdCotacao in (select IdCotacao from solicitacao where IdSolicitacao=CT.IdSolicitacao) and LidaCliente=1)  > 0 
		                                    THEN 'N'

                                        ELSE ''
                                    END 
                                as Mensagens
                            FROM solicitacao CT
                                inner join status s
		                            on CT.status = s.id
                            where " + filtro;
            return _base.ToList<CotacaoListaClienteModel>(db.Get(sql));
        }
        public List<Dashboard> GetDashboardParticipante(string filtro = "1=1")
        {
            string sql = $@"select s.id, s.nome, s.ordem  from status s
                                where " + filtro + @"
                                    order by s.ordem asc";
            return _base.ToList<Dashboard>(db.Get(sql));
        }
        public List<Dashboard> GetDashboardCliente(string filtro = "1=1")
        {
            string sql = $@"select s.id, s.nome, s.ordem  from status s
                                where " + filtro + @"
                                    order by s.ordem asc";
            return _base.ToList<Dashboard>(db.Get(sql));
        }

        public List<Dashboard> GetDashboardFornecedor(string filtro = "1=1")
        {
            string sql = $@"select s.id, s.nome, s.ordem  from status_fornecedor s
                                where " + filtro + @"
                                    order by s.ordem asc";
            return _base.ToList<Dashboard>(db.Get(sql));
        }

        public List<Dashboard> GetCliente(string filtro = "1=1")
        {
            string sql = $@"select s.id, s.nome, s.ordem  from status_fornecedor s
                                where " + filtro + @"
                                    order by s.ordem asc";
            return _base.ToList<Dashboard>(db.Get(sql));
        }

        public List<BE.Model.Fornecedor> GetFornecedor(string filtro = "1=1")
        {
            string sql = $@"select s.IdFornecedor as id, s.RazaoSocial as nome from fornecedor s
                                where " + filtro + @"";
            return _base.ToList<BE.Model.Fornecedor>(db.Get(sql));
        }

        public String EsqueciASenha(string filtro)
        {
            String guid = Guid.NewGuid().ToString();
            string sql = $@"UPDATE participante set token='" + guid + "' WHERE " + filtro;
            db.Execute(sql);
            return guid;
        }

        public String EsqueciASenhaFornecedor(string filtro)
        {
            String guid = Guid.NewGuid().ToString();
            string sql = $@"UPDATE fornecedor set token='" + guid + "' WHERE " + filtro;
            db.Execute(sql);
            return guid;
        }
        public String AtualizarSenha(String token, String senha)
        {
            string sql = $@"UPDATE participante set Senha='" + senha + "' WHERE token='" + token + "'";
            db.Execute(sql);
            return token;
        }
        public void AlterarSenha(String senha,int ID)
        {
            string sql = $@"UPDATE participante set Senha='" + senha + "' WHERE idParticipante='" + ID + "'";
            db.ExecuteCaseSensitive(sql);
        }
        public String ConsultaSenha(int ID)
        {
            try
            {
                // Construct the SQL query
                String sql = $"SELECT senha FROM participante WHERE idParticipante = {ID}";

                // Use the Get method to retrieve the results as a DataTable
                DataTable dt = db.Get(sql);

                // Check if the DataTable has any rows
                if (dt.Rows.Count > 0)
                {
                    // Return the value from the "senha" column in the first row
                    return dt.Rows[0]["senha"].ToString();
                }
            }
            catch (Exception ex)
            {
                // Log or handle the exception
                Console.WriteLine("Error while fetching password: " + ex.Message);
            }

            // Return null if no result is found or an exception occurs
            return null;
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


        public void AtualizaEnviaPropostaCotacao(int IdSolicitacao)
        {
            string sql = $@"update cotacao set EnviarProposta = 1 where IdCotacao = {IdSolicitacao}";
            db.Execute(sql);
        }


        public List<CotacaoListaFronecedorModel> CotacaoFornecedorGet(string filtro)
        {
            string sql = $@"SELECT 
                                CT.IdSolicitacao, 
                                CT.Titulo, 
                                CT.DataCriacao,
                                CT.DataAlteracao,
                                CT.Status, 
                                CT.FinalizaFornecedor,
                                CT.FinalizaCliente,
                                CT.IdCotacao,
                                    CASE
                                        WHEN 
			                                    (select count(IdCotacaoFornecedorChat) 
			                                    from cotacaofornecedorchat 
			                                    where IdParticipanteFornecedor = 0 and IdCotacao in (select IdCotacao from cotacao where IdSolicitacao=CT.IdSolicitacao) and LidaCliente=1)  > 0 
		                                    THEN 'N'

                                        ELSE ''
                                    END 
                                as Mensagens
                            FROM solicitacao CT
    
                             INNER JOIN cotacao CF on CT.IdSolicitacao = CF.IdCotacao
    
                            where " + filtro;
            return _base.ToList<CotacaoListaFronecedorModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaGet(string cats, int idFornecedor, string where = "1=1")
        {
            var sql = $@"select 
                            CT.IdSolicitacao as CotacaoId, 
                            CF.IdCotacao as CotacaoFornecedorId, 
                            CT.IdParticipante as ClienteId, 
                            CL.Nome, CT.Titulo, 
                            CT.Status, 
                            CT.FinalizaCliente, 
                            CT.FinalizaFornecedor, 
                            CT.IdCotacao as CFId,
                            CT.DataAlteracao,
                            s.Nome as StatusNome

                        from solicitacao CT                      
                        inner join participante CL on CL.IdParticipante = CT.IdParticipante
                        left join cotacao CF on CT.IdSolicitacao = CF.IdCotacao
                        inner join status s on CT.status = s.id
                        where CT.IdCategoria in ({cats}) and {where}
                          order by DataAlteracao desc   ";
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public List<CotacaoListaFronecedorModel> CotacaoListaFronecedorGet(string categorias, string idFornecedor)
        {
            var sql = $@"select CT.IdSolicitacao, CT.Titulo, CA.Nome as Categoria
                            from solicitacao CT 
                            inner join categoria CA on CA.IdCategoria = CT.IdCategoria
                            where CT.Status='{StatusCotacao.Aberto}' 
                            and CT.IdSolicitacao not in (select 
                                                        IdSolicitacao 
                                                    from cotacao where IdParticipanteFornecedor = {idFornecedor} 
                                                    and IdSolicitacao = CT.IdSolicitacao)
                            and CT.IdCategoria in ({categorias});";
            return _base.ToList<CotacaoListaFronecedorModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaAguardandoAceiteGet(int idFornecedor)
        {
            var sql = $@"select CF.IdSolicitacao as CotacaoId, CF.IdCotacao as CotacaoFornecedorId, CT.IdCLiente as ClienteId, CL.Nome, CT.Titulo, CT.Status, CT.FinalizaCliente, CT.FinalizaFornecedor, CT.IdCotacao as CFId
                        from cotacao CF 
                        inner join solicitacao CT
                        on CT.IdSolicitacao = CF.IdCotacao
                        inner join cliente CL
                        on CL.IdCliente = CT.IdCliente
                        where CT.FinalizaCliente = 0 and CT.FinalizaFornecedor=1 and CF.IdFornecedor =" + idFornecedor;
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public List<CotacaoFornecedorListaModel> CotacaoFornecedorListaStatusGet(int idFornecedor, string status)
        {
            var sql = $@"select CF.IdSolicitacao as CotacaoId, CF.IdCotacao as CotacaoFornecedorId, CT.IdParticipante as ClienteId, CL.Nome, CT.Notafornecedor as Nota, CT.Titulo, CT.Status, CT.FinalizaCliente, CT.FinalizaFornecedor, CT.IdCotacao as CFId
                        from cotacao CF 
                        inner join solicitacao CT
                        on CT.IdSolicitacao = CF.IdCotacao
                        inner join participante CL
                        on CL.IdParticipante = CT.IdParticipante
                        where CT.Status in {status} and CF.IdparticipanteFornecedor =" + idFornecedor;
            return _base.ToList<CotacaoFornecedorListaModel>(db.Get(sql));
        }

        public CotacaoAvaliacaoModel Cotacao_Avaliacao_Get(string IdSolicitacao)
        {
            var sql = $@"select CT.IdSolicitacao, CT.Titulo, CT.Descricao, CT.Depoimento, CT.DataTermino, CT.Nota, CF.Valor, CF.IdCotacao, FC.RazaoSocial as NomeFornecedor
                            from solicitacao CT 
                            inner join cotacao CF 
                            on CF.IdCotacao = CT.IdCotacao 
                            inner join Participante FC on FC.IdParticipante = CF.IdParticipanteFornecedor
                            where CT.IdSolicitacao= " + IdSolicitacao;
            return _base.ToList<CotacaoAvaliacaoModel>(db.Get(sql)).FirstOrDefault();
        }

        public CotacaoAvaliacaoFornecedorModel Cotacao_Avaliacao_Fornecedor_Get(string IdSolicitacao)
        {
            var sql = $@"select CT.IdSolicitacao, CT.Titulo, CT.Descricao, CT.Observacao, CT.NotaFornecedor as Nota, CF.Valor, CF.IdCotacao, CL.Nome as NomeCliente, CT.DataTermino
                            from cotacao CF 
                            inner join solicitacao CT 
                            on CF.IdCotacao = CT.IdCotacao 
                            inner join Participante CL on CL.IdParticipante = CT.IdParticipante
                            where CF.IdCotacao= " + IdSolicitacao;
            return _base.ToList<CotacaoAvaliacaoFornecedorModel>(db.Get(sql)).FirstOrDefault();
        }

        public List<CotacaoListaModel> CotacaoListaGet(string IdSolicitacao)
        {
            string sql = $@"select 
                                CT.IdSolicitacao as CotacaoId, 
                                FC.nomeFantasia as NomeParticipante, 
                                CF.IdCotacao as CotacaoFornecedorId, 
                                CF.Valor, 
                                CF.Ativo,
                                CF.Novo,
                                CASE
                                WHEN 
			                            (select count(IdCotacaoFornecedorChat) 
			                            from cotacaofornecedorchat 
			                            where IdCliente = 0 and IdCotacao= CF.IdCotacao and LidaCliente=0)  > 0 
		                            THEN 'N'

                                ELSE ''
                            END as Mensagens,
                                (select DataCriacao 
                                from cotacaofornecedorchat 
                                where IdCotacao = CF.IdCotacao 
                                ORDER BY IdCotacaoFornecedorChat DESC LIMIT 1) AS DataUltimaResposta
                            from solicitacao CT 
                            inner join cotacao CF on CT.IdSolicitacao = CF.IdSolicitacao 
                            inner join participante FC on CF.IdParticipanteFornecedor = FC.IdParticipante
                                where CT.IdSolicitacao = {IdSolicitacao}";
            return _base.ToList<CotacaoListaModel>(db.Get(sql));
        }

        public List<CotacaoPagamentoModel> CotacaoStatusGet(string status, int idCliente)
        {
            string sql = $@"select 
                                CT.IdSolicitacao as CotacaoId, 
                                CT.Status,
                                FC.RazaoSocial as NomeFornecedor, 
                                CF.IdCotacao as CotacaoFornecedorId, 
                                CF.Valor
                                
                            from solicitacao CT 
                            inner join cotacao CF on CT.IdCotacao = CF.IdCotacao 
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

        ////////////////////////////////////////////// Participante ////////////////////////////////////////////////////////////
        public List<ParticipanteBE> Participante_Get(ParticipanteBE lg, string _filtro)
        {
            List<ParticipanteBE> Lista_lg = new List<ParticipanteBE>();
            Lista_lg.Add(lg);
            return _base.ToList<ParticipanteBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }
        public string Participante_Insert(ParticipanteBE lg)
        {
            lg.data = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            List<ParticipanteBE> Lista_lg = new List<ParticipanteBE>();

            Lista_lg.Add(lg);
            string sql = _base.Insert(Lista_lg, null);
            return db.ExecuteCaseSensitive(sql);
        }
        public void Participante_Update(ParticipanteBE lg, string filtro)
        {
            List<ParticipanteBE> Lista_lg = new List<ParticipanteBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
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
        public List<SolicitacaoBE> Cotacao_Get(SolicitacaoBE lg, string _filtro)
        {
            List<SolicitacaoBE> Lista_lg = new List<SolicitacaoBE>();
            Lista_lg.Add(lg);
            return _base.ToList<SolicitacaoBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string Cotacao_Insert(SolicitacaoBE lg)
        {
            List<SolicitacaoBE> Lista_lg = new List<SolicitacaoBE>();
            lg.DataAlteracao = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm"));
            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void Cotacao_Update(SolicitacaoBE lg, string filtro)
        {
            List<SolicitacaoBE> Lista_lg = new List<SolicitacaoBE>();
            lg.DataAlteracao = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm"));
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void Cotacao_Delete(SolicitacaoBE lg)
        {
            List<SolicitacaoBE> Lista_lg = new List<SolicitacaoBE>();
            Lista_lg.Add(lg);
            db.Delete(_base.Delete(Lista_lg, null));
        }

        ////////////////////////////////////////////// CotacaoFornecedor ////////////////////////////////////////////////////////////
        public List<CotacaoBE> CotacaoFornecedor_Get(CotacaoBE lg, string _filtro)
        {
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
            Lista_lg.Add(lg);
            return _base.ToList<CotacaoBE>(db.Get(_base.Query(Lista_lg, _filtro)));
        }

        public string CotacaoFornecedor_Insert(CotacaoBE lg)
        {
            lg.DataCriacao = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss");
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();

            Lista_lg.Add(lg);
            return db.Insert(_base.Insert(Lista_lg, null));
        }

        public void CotacaoFornecedor_Update(CotacaoBE lg, string filtro)
        {
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
            Lista_lg.Add(lg);
            db.Update(_base.Update(Lista_lg, filtro));
        }

        public void CotacaoFornecedor_Delete(CotacaoBE lg)
        {
            List<CotacaoBE> Lista_lg = new List<CotacaoBE>();
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
