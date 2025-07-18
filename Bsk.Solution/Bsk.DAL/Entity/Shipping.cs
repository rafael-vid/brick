using System;
using System.Collections.Generic;

public class Shipping
{
    public int Amount { get; set; }
    public string Description { get; set; }
    public string RecipientName { get; set; }
    public string RecipientPhone { get; set; }
    public Address Address { get; set; }
    public string MaxDeliveryDate { get; set; }
    public string EstimatedDeliveryDate { get; set; }
    public string Type { get; set; }
}
