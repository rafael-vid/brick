public class Phone
{
    // C�digo do Pa�s (Apenas num�rico)
    public string CountryCode { get; set; }

    // C�digo da �rea (Apenas num�rico)
    public string AreaCode { get; set; }

    // N�mero do telefone (Apenas num�rico)
    public string Number { get; set; }
}

public class Phones
{
    // Telefone residencial
    public Phone HomePhone { get; set; }

    // Telefone m�vel
    public Phone MobilePhone { get; set; }
}
