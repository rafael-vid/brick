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

    }
}
