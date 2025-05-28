using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

public class Program
{
    public static async Task Main(string[] args)
    {
        var customer = new Customer
        {
            Id = Guid.NewGuid().ToString(),
            Document = "12345678901",
            DocumentType = "CPF",
            Type = "individual",
            Gender = "male",
            Code = "customer123",
            CreatedAt = DateTime.UtcNow,
            UpdatedAt = DateTime.UtcNow,
            Birthdate = new DateTime(1990, 1, 1),
            Address = new Address
            {
                Line1 = "123 Main St",
                Line2 = "Apt 4B",
                ZipCode = "12345",
                City = "New York",
                State = "NY",
                Country = "US"
            },
            Metadata = new Dictionary<string, string>
            {
                { "custom_field", "custom_value" }
            }
        };

        await CreateCustomerAsync(customer);
    }

    public static async Task CreateCustomerAsync(Customer customer)
    {
        var client = new HttpClient();
        var url = "https://api.pagar.me/core/v5/customers";

        // Serializa os dados do cliente para JSON
        var json = JsonConvert.SerializeObject(new
        {
            name = "John Doe", // Nome fictício, ajuste conforme necessário
            email = "johndoe@example.com", // E-mail fictício, ajuste conforme necessário
            code = customer.Code,
            document = customer.Document,
            document_type = customer.DocumentType,
            type = customer.Type,
            gender = customer.Gender,
            birthdate = customer.Birthdate?.ToString("MM/dd/yyyy"),
            address = new
            {
                line_1 = customer.Address.Line1,
                line_2 = customer.Address.Line2,
                zip_code = customer.Address.ZipCode,
                city = customer.Address.City,
                state = customer.Address.State,
                country = customer.Address.Country
            },
            metadata = customer.Metadata
        });

        var content = new StringContent(json, Encoding.UTF8, "application/json");

        // Adiciona o token de autenticação no cabeçalho (substitua "YOUR_API_KEY" pela sua chave de API)
        client.DefaultRequestHeaders.Add("Authorization", "Bearer YOUR_API_KEY");

        try
        {
            // Faz a requisição POST
            var response = await client.PostAsync(url, content);

            if (response.IsSuccessStatusCode)
            {
                var responseBody = await response.Content.ReadAsStringAsync();
                Console.WriteLine("Cliente criado com sucesso:");
                Console.WriteLine(responseBody);
            }
            else
            {
                Console.WriteLine($"Erro ao criar cliente: {response.StatusCode}");
                var errorBody = await response.Content.ReadAsStringAsync();
                Console.WriteLine(errorBody);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Erro: {ex.Message}");
        }
    }
}

public class Address
{
    public string Line1 { get; set; }
    public string Line2 { get; set; }
    public string ZipCode { get; set; }
    public string City { get; set; }
    public string State { get; set; }
    public string Country { get; set; }
}
