using System;
using System.Collections.Generic;

public class BankAccount
{
    public string Id { get; set; } // Código da conta bancária
    public string HolderName { get; set; }
    public string HolderType { get; set; } // "individual" ou "company"
    public string Bank { get; set; }
    public string BranchNumber { get; set; }
    public string BranchCheckDigit { get; set; }
    public string AccountNumber { get; set; }
    public string AccountCheckDigit { get; set; }
    public string Type { get; set; } // "checking" ou "savings"
    public string Status { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public DateTime? DeletedAt { get; set; }
    public Dictionary<string, string> Metadata { get; set; }
}
