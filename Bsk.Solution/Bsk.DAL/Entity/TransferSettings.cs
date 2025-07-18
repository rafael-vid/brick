using System;
using System.Collections.Generic;

public class TransferSettings
{
    public bool TransferEnabled { get; set; }
    public string TransferInterval { get; set; } // "daily", "weekly", "monthly"
    public int? TransferDay { get; set; } // Opcional, usado para intervalos semanais ou mensais
}
