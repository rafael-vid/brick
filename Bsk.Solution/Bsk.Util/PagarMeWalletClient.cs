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
        private readonly Action<string> _logger;
        public PagarMeWalletClient(Action<string> logger = null)
        {
            var apiKey = ConfigurationManager.AppSettings["PagarmeApiKey"] ?? string.Empty;
            _http = new HttpClient { BaseAddress = new Uri("https://api.pagar.me/core/v5/") };
            var auth = Convert.ToBase64String(Encoding.ASCII.GetBytes(apiKey + ":"));
            _http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", auth);
            _logger = logger ?? Console.WriteLine;
        }

        public bool EnsureCustomer(string customerId, string name, string email)
        {
            try
            {
                var payload = new { name = name, email = email };
                var json = JsonConvert.SerializeObject(payload);
                var resp = _http.PutAsync($"customers/{customerId}",
                    new StringContent(json, Encoding.UTF8, "application/json")).Result;
                var body = resp.Content.ReadAsStringAsync().Result;
                _logger?.Invoke($"EnsureCustomer response: {(int)resp.StatusCode} - {body}");
                return resp.IsSuccessStatusCode;
            }
            catch (Exception ex)
            {
                _logger?.Invoke($"EnsureCustomer error: {ex.Message}");
                return false;
            }
        }

        public List<PagarMeCard> ListCards(string customerId)
        {
            try
            {
                var resp = _http.GetAsync($"customers/{customerId}/cards").Result;
                var body = resp.Content.ReadAsStringAsync().Result;
                _logger?.Invoke($"ListCards response: {(int)resp.StatusCode} - {body}");

                if (!resp.IsSuccessStatusCode) return new List<PagarMeCard>();
                return JsonConvert.DeserializeObject<List<PagarMeCard>>(body);
            }
            catch (Exception ex)
            {
                _logger?.Invoke($"ListCards error: {ex.Message}");
                return new List<PagarMeCard>();
            }
        }

        public PagarMeCard AddCard(string customerId, PagarMeCardCreateRequest req)
        {
            try
            {
                var json = JsonConvert.SerializeObject(req);
                var resp = _http.PostAsync($"customers/{customerId}/cards",
                    new StringContent(json, Encoding.UTF8, "application/json")).Result;
                var body = resp.Content.ReadAsStringAsync().Result;
                _logger?.Invoke($"AddCard response: {(int)resp.StatusCode} - {body}");

                if (!resp.IsSuccessStatusCode) return null;
                return JsonConvert.DeserializeObject<PagarMeCard>(body);
            }
            catch (Exception ex)
            {
                _logger?.Invoke($"AddCard error: {ex.Message}");
                return null;
            }
        }

        public bool DeleteCard(string customerId, string cardId)
        {
            try
            {
                var resp = _http.DeleteAsync($"customers/{customerId}/cards/{cardId}").Result;
                var body = resp.Content.ReadAsStringAsync().Result;
                _logger?.Invoke($"DeleteCard response: {(int)resp.StatusCode} - {body}");
                return resp.IsSuccessStatusCode;
            }
            catch (Exception ex)
            {
                _logger?.Invoke($"DeleteCard error: {ex.Message}");
                return false;
            }
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
