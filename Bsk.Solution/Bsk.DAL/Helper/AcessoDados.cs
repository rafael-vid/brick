using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using MySql.Data.MySqlClient;


namespace Bsk.DAL.Helper
{
    public class AcessoDados
    {
        public int execute(string mSQL)
        {
            int id = 0;

            using (MySqlConnection conexaoMySQL = AcessoDados.MySQLDao.getInstancia().getConexao())
            {

                DataTable dt = new DataTable();
                try
                {
                    conexaoMySQL.Open();

                    MySqlCommand cmd = new MySqlCommand(mSQL, conexaoMySQL);


                    cmd.ExecuteNonQuery();
                    id = Convert.ToInt32(cmd.LastInsertedId);

                }
                catch (MySqlException msqle)
                {
                    var erro = msqle.Message;
                }
                finally
                {
                    conexaoMySQL.Close();
                }

                return id;
            }
        }


        public DataTable retornaDatatable(string mSQL)
        {

            using (MySqlConnection conexaoMySQL = AcessoDados.MySQLDao.getInstancia().getConexao())
            {

                DataTable dt = new DataTable();
                try
                {
                    conexaoMySQL.Open();

                    MySqlCommand cmd = new MySqlCommand(mSQL, conexaoMySQL);
                    MySqlDataAdapter da = new MySqlDataAdapter(cmd);

                    da.Fill(dt);

                    return dt;
                }
                catch (MySqlException msqle)
                {
                    var erro = msqle.Message;
                    return dt;
                }
                finally
                {
                    conexaoMySQL.Close();
                }


            }

        }


        public class MySQLDao
        {
            private static readonly MySQLDao instanciaMySQL = new MySQLDao();

            private MySQLDao() { }

            public static MySQLDao getInstancia()
            {
                return instanciaMySQL;
            }

            public MySqlConnection getConexao()
            {
                string conn = ConfigurationManager.ConnectionStrings["MySQLConnectionString"].ToString();
                return new MySqlConnection(conn);
            }

        }
    }
}
