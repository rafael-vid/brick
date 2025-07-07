using System;
using System.Collections.Generic;

public class Payment
{
    public string PaymentMethod { get; set; }
    //public CreditCard CreditCard { get; set; }
    //public DebitCard DebitCard { get; set; }
    //public Voucher Voucher { get; set; }
    //public Boleto Boleto { get; set; }
    //public BankTransfer BankTransfer { get; set; }
    //public Checkout Checkout { get; set; }
    //public Cash Cash { get; set; }
    //public Pix Pix { get; set; }
    public int Amount { get; set; }
    public Dictionary<string, string> Metadata { get; set; }
}
