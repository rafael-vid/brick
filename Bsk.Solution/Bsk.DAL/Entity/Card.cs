using System;
using System.Collections.Generic;

public class Card
{
    public string Id { get; set; } // Código do cartão. Formato card_XXXXXXXXXXXXXXXX.
    public string LastFourDigits { get; set; } // Quatro últimos dígitos do cartão.
    public string FirstSixDigits { get; set; } // Primeiros seis dígitos do cartão.
    public string Brand { get; set; } // Bandeira do cartão.
    public string HolderName { get; set; } // Nome impresso no cartão.
    public string HolderDocument { get; set; } // CPF ou CNPJ do portador do cartão.
    public int ExpMonth { get; set; } // Mês de vencimento do cartão.
    public int ExpYear { get; set; } // Ano de vencimento do cartão. Formatos: yy ou yyyy.
    public string Status { get; set; } // Status do cartão. Valores possíveis: active, deleted ou expired.
    public DateTime CreatedAt { get; set; } // Data de criação do cartão (UTC).
    public DateTime UpdatedAt { get; set; } // Data de atualização do cartão (UTC).
    public DateTime? DeletedAt { get; set; } // Data de exclusão do cartão (UTC).
    public Address BillingAddress { get; set; } // Endereço de cobrança.
    public Customer Customer { get; set; } // Dados do cliente.
    public bool PrivateLabel { get; set; } // Indica se é um cartão private label.
    public string Type { get; set; } // Tipo do cartão. Valores possíveis: credit ou voucher.
    public Dictionary<string, string> Metadata { get; set; } // Informações adicionais sobre o cartão.
}
