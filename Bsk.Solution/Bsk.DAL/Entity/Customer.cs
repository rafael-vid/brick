using System;
using System.Collections.Generic;

public class Customer
{
    public string Id { get; set; }
    public string Document { get; set; }
    public string DocumentType { get; set; }
    public string Type { get; set; }
    public string Gender { get; set; }
    public Address Address { get; set; }
    public string Code { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public DateTime? Birthdate { get; set; }
    public Dictionary<string, string> Metadata { get; set; }
}
