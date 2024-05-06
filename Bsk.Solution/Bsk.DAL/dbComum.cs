using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Bsk.BE;
using Bsk.DAL.Helper;
using System.Data;

namespace Bsk.DAL
{
   public class dbComum
    {
        DataTable dt = new DataTable();
        AcessoDados acc = new AcessoDados();
        //Comentario
        public DataTable Get(string qry)
        {
            return acc.retornaDatatable(qry.ToLower());
        }

        public string Execute(string qry)
        {
            return acc.execute(qry.ToLower()).ToString();
        }

        public string Insert(string qry)
        {
            return acc.execute(qry.ToLower()).ToString();
        }

        public string Update(string qry)
        {
            return acc.execute(qry.ToLower()).ToString();
        }

        public string Delete(string qry)
        {
            return acc.execute(qry.ToLower()).ToString();
        }
    }
}
