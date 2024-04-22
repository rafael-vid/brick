using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Reflection;
using System.Data;
using System.Threading.Tasks;
using Bsk.BE;
using Bsk.DAL;
using System.Configuration;

namespace Bsk.DAL.Helper
{
    public static class Convertions
    {
        private static Dictionary<Type, IList<PropertyInfo>> typeDictionary = new Dictionary<Type, IList<PropertyInfo>>();

        public static IList<PropertyInfo> GetPropertiesForType<T>()
        {
            var type = typeof(T);

            if (!typeDictionary.ContainsKey(typeof(T)))
            {

                typeDictionary.Add(type, type.GetProperties().ToList());
            }
            return typeDictionary[type];
        }


        public static List<T> ToList<T>(this DataTable table) where T : new()
        {
            //Pegando todas as propriedades da classe genérica.
            IList<PropertyInfo> properties = GetPropertiesForType<T>();
            IList<T> result = new List<T>();

            //Convertendo e adicionando os itens na lista.
            foreach (var row in table.Rows)
            {
                var item = CreateItemFromRow<T>((DataRow)row, properties);
                result.Add(item);
            }

            return result.ToList();
        }


        public static string Query<T>(this List<T> table, string filtro) where T : new()
        {
            string qry = "";
            string header = " select ";

            if (filtro != null && filtro != "")
            {
                filtro = filtro.Replace("--", "");
                filtro = filtro.Replace("''", "");
            }
            int countItem = table[0].GetType().GetProperties().Count();
            string container = " ";

            for (int i = 0; i < countItem; i++)
            {
                container = container + table[0].GetType().GetProperties()[i].Name.ToString();
                if (i != (countItem - 1))
                    container = container + ", ";
            }

            if (filtro != null && filtro != "")
                filtro = " where " + filtro;

            string footer = " from " + table[0].GetType().Name.Substring(0, (table[0].GetType().Name.Length - 2)) + filtro;

            qry = header + container + footer;

            return qry;
        }



        public static string Insert<T>(this List<T> table, string filtro) where T : new()
        {

            if (filtro != null && filtro != "")
            {
                filtro = filtro.Replace("--", "");
                filtro = filtro.Replace("''", "");
            }

            string tabela = table[0].GetType().Name.Substring(0, (table[0].GetType().Name.Length - 2));
            string qry = " INSERT INTO " + tabela + "(#COLUNAS) VALUES (#VALUES)";

            int countItem = table[0].GetType().GetProperties().Count();
            string container = " ";
            string coluna = "";
            string valores = "";
            string valor = "";

            string tipo = "";


            for (int i = 1; i < countItem; i++)
            {

                coluna = table[0].GetType().GetProperties()[i].Name.ToString();

                if (table[0].GetType().GetProperty(coluna).GetValue(table[0], null) != null)
                    valor = table[0].GetType().GetProperty(coluna).GetValue(table[0], null).ToString();
                else
                    valor = "null";

                valor = valor.Replace("'", "");

                container = container + coluna;

                string type = table[0].GetType().GetProperty(coluna).PropertyType.Name;

                if (type == "Int32" || type == "Int64")
                {
                    tipo = "#VALOR";
                }
                else if (type == "Decimal")
                {
                    valor = valor.Replace(",", ".");
                }
                else if (type == "DateTime" || type == "Nullable`1")
                {
                    if (valor == "null")
                    {
                        valor = "0001-01-01";
                    }
                    else
                    {
                        if (ConfigurationManager.AppSettings["servidor"].ToString() == "US")
                        {
                            valor = DateTime.Parse(valor).ToString("yyyy-MM-dd HH:mm:ss");
                        }
                        else
                        {
                            valor = DateTime.Parse(valor).ToString("dd-MM-yyyy HH:mm:ss");
                        }
                    }

                    tipo = "'#VALOR'";

                }
                else
                    tipo = "'#VALOR'";

                valores = valores + tipo.Replace("#VALOR", valor);

                if (i != (countItem - 1))
                {
                    container = container + ", ";
                    valores = valores + ", ";
                }

            }

            qry = qry.Replace("#COLUNAS", container).Replace("#VALUES", valores);

            return qry;
        }

        public static string Update<T>(this List<T> table, string filtro) where T : new()
        {
            if (filtro != null && filtro != "")
            {
                filtro = filtro.Replace("--", "");
                filtro = filtro.Replace("''", "");
            }
            string tabela = table[0].GetType().Name.Substring(0, (table[0].GetType().Name.Length - 2));
            string qry = " UPDATE  " + tabela + " SET #COLUNAS ";

            int countItem = table[0].GetType().GetProperties().Count();
            string container = " ";
            string coluna = "";
            string valores = "";
            string valor = "";

            for (int i = 1; i < countItem; i++)
            {
                coluna = table[0].GetType().GetProperties()[i].Name.ToString();

                var propertyValue = table[0].GetType().GetProperty(coluna).GetValue(table[0], null);
                if (propertyValue != null)
                {
                    valor = propertyValue.ToString();
                    string type = propertyValue.GetType().Name;
                    if (type == "Int32" || type == "Int64")
                    {
                        container = " " + coluna + " = " + valor;
                    }
                    else if (type == "Decimal")
                    {
                        valor = valor.Replace(",", ".");
                        container = " " + coluna + " = " + valor;
                    }
                    else if (type == "DateTime")
                    {
                        valor = "'" + ((DateTime)propertyValue).ToString("yyyy-MM-dd HH:mm:ss") + "'";
                        container = " " + coluna + " = " + valor;
                    }
                    else
                    {
                        container = " " + coluna + " = '" + valor + "'";
                    }
                }
                else
                {
                    container = " " + coluna + " = NULL"; // Directly use SQL NULL here
                }

                valores += container;
                if (i != (countItem - 1))
                {
                    valores += ", ";
                }
            }

            qry = qry.Replace("#COLUNAS", valores) + " WHERE " + filtro;

            if (filtro == null || filtro == "")
                qry = "";

            return qry;
        }






        public static string Delete<T>(this List<T> table, string filtro) where T : new()
        {

            if (filtro != null && filtro != "")
            {
                filtro = filtro.Replace("--", "");
                filtro = filtro.Replace("''", "");
            }
            string tabela = table[0].GetType().Name.Substring(0, (table[0].GetType().Name.Length - 2));
            string coluna = table[0].GetType().GetProperties()[0].Name.ToString();
            string qry = " DELETE FROM " + tabela + " WHERE " + coluna + " = " + table[0].GetType().GetProperty(coluna).GetValue(table[0], null).ToString();

            return qry;
        }


        private static T CreateItemFromRow<T>(DataRow row, IList<PropertyInfo> properties) where T : new()
        {
            T item = new T();
            foreach (var property in properties)
            {
                try
                {
                    property.SetValue(item, row[property.Name], null);
                }
                catch
                {

                }
            }
            return item;
        }
    }
}
