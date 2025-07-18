using System;
using System.Collections.Generic;

public class Recipient
{
    public string Name { get; set; }
    public string Email { get; set; }
    public string Description { get; set; }
    public string Document { get; set; } // CPF ou CNPJ
    public string Type { get; set; } // "individual" ou "company"
    public BankAccount DefaultBankAccount { get; set; }
    public TransferSettings TransferSettings { get; set; }
    public AutomaticAnticipationSettings AutomaticAnticipationSettings { get; set; }
    public Dictionary<string, string> Metadata { get; set; }
}

class Program
{
    static void Main()
    {
        var recipient = new Recipient
        {
            Name = "John Doe",
            Email = "johndoe@example.com",
            Description = "Vendedor de eletrônicos",
            Document = "12345678901", // CPF ou CNPJ
            Type = "individual",
            DefaultBankAccount = new BankAccount
            {
                Id = "ba_1234567890abcdef",
                HolderName = "John Doe",
                HolderType = "individual",
                Bank = "001", // Exemplo: Banco do Brasil
                BranchNumber = "1234",
                BranchCheckDigit = "5",
                AccountNumber = "56789",
                AccountCheckDigit = "0",
                Type = "checking",
                Status = "active",
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow,
                Metadata = new Dictionary<string, string>
                {
                    { "purpose", "business" },
                    { "region", "south" }
                }
            },
            TransferSettings = new TransferSettings
            {
                TransferEnabled = true,
                TransferInterval = "weekly", // Exemplo: transferências semanais
                TransferDay = 5 // Exemplo: transferências às sextas-feiras
            },
            AutomaticAnticipationSettings = new AutomaticAnticipationSettings
            {
                Enabled = true,
                Interval = "daily",
                Days = 15
            },
            Metadata = new Dictionary<string, string>
            {
                { "store_id", "12345" },
                { "category", "electronics" }
            }
        };

        Console.WriteLine("Recipient created successfully!");
        Console.WriteLine($"Name: {recipient.Name}");
        Console.WriteLine($"Email: {recipient.Email}");
        Console.WriteLine($"Document: {recipient.Document}");
        Console.WriteLine($"Bank Account Holder: {recipient.DefaultBankAccount.HolderName}");
        Console.WriteLine($"Transfer Interval: {recipient.TransferSettings.TransferInterval}");
    }
}
