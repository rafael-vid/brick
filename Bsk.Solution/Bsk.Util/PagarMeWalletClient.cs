using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;

namespace Bsk.Util
{
    public class PagarMeWalletClient
    {
        private readonly HttpClient _http;
        public PagarMeWalletClient()
        {
            var apiKey = ConfigurationManager.AppSettings["PagarmeApiKey"] ?? string.Empty;
            _http = new HttpClient { BaseAddress = new Uri("https://api.pagar.me/core/v5/") };
            var auth = Convert.ToBase64String(Encoding.ASCII.GetBytes(apiKey + ":"));
            _http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", auth);
        }

        public List<PagarMeCard> ListCards(string customerId)
        {
            try
            {
                var resp = _http.GetAsync($"customers/{customerId}/cards").Result;
                if (!resp.IsSuccessStatusCode) return new List<PagarMeCard>();
                var json = resp.Content.ReadAsStringAsync().Result;
                return JsonConvert.DeserializeObject<List<PagarMeCard>>(json);
            }
            catch
            {
                return new List<PagarMeCard>();
            }
        }

        public PagarMeCard AddCard(string customerId, PagarMeCardCreateRequest req)
        {
            var json = JsonConvert.SerializeObject(req);
            var resp = _http.PostAsync($"customers/{customerId}/cards", new StringContent(json, Encoding.UTF8, "application/json")).Result;
            resp.EnsureSuccessStatusCode();
            var respJson = resp.Content.ReadAsStringAsync().Result;
            return JsonConvert.DeserializeObject<PagarMeCard>(respJson);
        }

        public void DeleteCard(string customerId, string cardId)
        {
            var resp = _http.DeleteAsync($"customers/{customerId}/cards/{cardId}").Result;
            resp.EnsureSuccessStatusCode();
        }
    }

    public class PagarMeCard
    {
        [JsonProperty("id")] public string Id { get; set; }
        [JsonProperty("holder_name")] public string HolderName { get; set; }
        [JsonProperty("last_four_digits")] public string LastFourDigits { get; set; }
        [JsonProperty("brand")] public string Brand { get; set; }
        [JsonProperty("exp_month")] public int ExpMonth { get; set; }
        [JsonProperty("exp_year")] public int ExpYear { get; set; }
        [JsonProperty("status")] public string Status { get; set; }
    }

    public class PagarMeCardCreateRequest
    {
        [JsonProperty("holder_name")] public string HolderName { get; set; }
        [JsonProperty("number")] public string Number { get; set; }
        [JsonProperty("exp_month")] public int ExpMonth { get; set; }
        [JsonProperty("exp_year")] public int ExpYear { get; set; }
        [JsonProperty("cvv")] public string Cvv { get; set; }
        [JsonProperty("holder_document")] public string HolderDocument { get; set; }
    }
}
