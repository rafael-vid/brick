public class Phone
{
    // Código do País (Apenas numérico)
    public string CountryCode { get; set; }

    // Código da área (Apenas numérico)
    public string AreaCode { get; set; }

    // Número do telefone (Apenas numérico)
    public string Number { get; set; }
}

public class Phones
{
    // Telefone residencial
    public Phone HomePhone { get; set; }

    // Telefone móvel
    public Phone MobilePhone { get; set; }
}
