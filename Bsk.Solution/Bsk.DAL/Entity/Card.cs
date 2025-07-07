using System;
using System.Collections.Generic;

public class Card
{
    public string Id { get; set; } // C�digo do cart�o. Formato card_XXXXXXXXXXXXXXXX.
    public string LastFourDigits { get; set; } // Quatro �ltimos d�gitos do cart�o.
    public string FirstSixDigits { get; set; } // Primeiros seis d�gitos do cart�o.
    public string Brand { get; set; } // Bandeira do cart�o.
    public string HolderName { get; set; } // Nome impresso no cart�o.
    public string HolderDocument { get; set; } // CPF ou CNPJ do portador do cart�o.
    public int ExpMonth { get; set; } // M�s de vencimento do cart�o.
    public int ExpYear { get; set; } // Ano de vencimento do cart�o. Formatos: yy ou yyyy.
    public string Status { get; set; } // Status do cart�o. Valores poss�veis: active, deleted ou expired.
    public DateTime CreatedAt { get; set; } // Data de cria��o do cart�o (UTC).
    public DateTime UpdatedAt { get; set; } // Data de atualiza��o do cart�o (UTC).
    public DateTime? DeletedAt { get; set; } // Data de exclus�o do cart�o (UTC).
    public Address BillingAddress { get; set; } // Endere�o de cobran�a.
    public Customer Customer { get; set; } // Dados do cliente.
    public bool PrivateLabel { get; set; } // Indica se � um cart�o private label.
    public string Type { get; set; } // Tipo do cart�o. Valores poss�veis: credit ou voucher.
    public Dictionary<string, string> Metadata { get; set; } // Informa��es adicionais sobre o cart�o.
}
