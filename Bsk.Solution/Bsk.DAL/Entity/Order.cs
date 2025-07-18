using System;
using System.Collections.Generic;

public class Order
{
    public string Id { get; set; }
    public string Currency { get; set; }
    public string Status { get; set; }
    public string Code { get; set; }
    public Customer Customer { get; set; }
    public Shipping Shipping { get; set; }
    public Antifraud Antifraud { get; set; }
    public List<Payment> Payments { get; set; }
    public List<Item> Items { get; set; }
    public bool Closed { get; set; } = true;
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public Dictionary<string, string> Metadata { get; set; }
    public string RecurrenceCycle { get; set; }
}
