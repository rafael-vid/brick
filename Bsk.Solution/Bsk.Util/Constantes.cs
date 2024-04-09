using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Bsk.Util
{
    public class Constantes
    {

        public static string Dia(string dia)
        {
            dia = Convert.ToDateTime(dia).DayOfWeek.ToString();
            switch (dia)
            {
                case "Sunday":
                    dia = "Domingo";
                    break;
                case "Monday":
                    dia = "Segunda";
                    break;
                case "Tuesday":
                    dia = "Terça";
                    break;
                case "Wednesday":
                    dia = "Quarta";
                    break;
                case "Thursday":
                    dia = "Quinta";
                    break;
                case "Friday":
                    dia = "Sexta";
                    break;
                case "Saturday":
                    dia = "Sábado";
                    break;
            }
            return dia;
        }
    }

    public static class Chaves
    {
        public const string ChaveApiInserir = "e2962718-67b1-4b20-86b2-046f83757250";
        public const string ChaveApiLogin = "333342bb-14ef-44f6-829f-a4d914bf58f1";
        public const string ChaveCriarConta = "7d87b744-4ab0-4329-897b-8973fc75cbfb";
        public const string ChaveValidarConta = "6ceffd29-2773-406c-aa94-49b0107ce01d";
    }

    public static class TipoMovimentacao
    {
        public const int Compra = 1;
        public const int Pagamento = 2;
    }

    public static class Status
    {
        public const int Ativo = 1;
        public const int Inativo = 2;
        public const int Desligado = 3;
    }

    public static class Padrao
    {
        public const string Data = "yyyy-MM-dd";
        public const string DataHora = "yyyy-MM-dd HH:mm:ss";
    }

    public static class MensagensSistema
    {
        public const string CpfNaoEncontrado = "O CPF {0} não foi encontrado em nossos registros.";
        public const string CpfJaCadastrado = "O CPF {0} já foi cadastrado.";
        public const string SuspeitaAtaque = "Bad request";
        public static string EstabelecimentoInativo = "O estabelecimento {0} está inativo ou desligado";
        public static string FiaditoInativo = "O fiadito {0} está inativo ou desligado";
        public static string ContaExistente = "Já existe uma conta com esse CPF nesse estabelecimento";
        public static string ContaJaAtivada = "Essa conta já foi ativada";
        public static string ContaInexistente = "Número de conta não encontrado";
        public static object ContaBloqueada;
    }

    public static class StatusCotacao
    {
        public const string Criacao = "1";
        public const string Aberto = "1";
        public const string AguardandoPagamento = "2";
        public const string EmAndamento = "3";
        public const string Finalizado = "4";
        public const string Avaliado = "5";
        public const string Pago = "6";
    }

    public static class VariaveisGlobais
    {
        public const int DiasBoleto = 2;
        public const string Logo = "http://brikk.areadecompras.com.br/Cliente/img/logo.png";

    }
}
