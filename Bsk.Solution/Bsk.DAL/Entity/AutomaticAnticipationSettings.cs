using System;
using System.Collections.Generic;

public class AutomaticAnticipationSettings
{
    public bool Enabled { get; set; }
    public string Interval { get; set; } // "daily", "weekly", etc.
    public int? Days { get; set; } // Número de dias para antecipação
}
