using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
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

        public PagarMeResult<PagarMeCard> AddCard(string customerId, PagarMeCardCreateRequest req)
        {
            try
            {
                var json = JsonConvert.SerializeObject(req);
                var resp = _http.PostAsync($"customers/{customerId}/cards", new StringContent(json, Encoding.UTF8, "application/json")).Result;
                var respJson = resp.Content.ReadAsStringAsync().Result;
                if (!resp.IsSuccessStatusCode)
                {
                    return new PagarMeResult<PagarMeCard> { Error = ParseError(respJson) ?? resp.StatusCode.ToString() };
                }
                var card = JsonConvert.DeserializeObject<PagarMeCard>(respJson);
                return new PagarMeResult<PagarMeCard> { Data = card };
            }
            catch (Exception ex)
            {
                return new PagarMeResult<PagarMeCard> { Error = ex.Message };
            }
        }

        public PagarMeResult<bool> DeleteCard(string customerId, string cardId)
        {
            try
            {
                var resp = _http.DeleteAsync($"customers/{customerId}/cards/{cardId}").Result;
                var body = resp.Content.ReadAsStringAsync().Result;
                if (!resp.IsSuccessStatusCode)
                {
                    return new PagarMeResult<bool> { Error = ParseError(body) ?? resp.StatusCode.ToString() };
                }
                return new PagarMeResult<bool> { Data = true };
            }
            catch (Exception ex)
            {
                return new PagarMeResult<bool> { Error = ex.Message };
            }
        }

        private string ParseError(string json)
        {
            try
            {
                var token = JToken.Parse(json);
                var msg = token.SelectToken("errors[0].message") ?? token.SelectToken("message");
                return msg?.ToString();
            }
            catch
            {
                return null;
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

    public class PagarMeResult<T>
    {
        public T Data { get; set; }
        public string Error { get; set; }
        public bool Success => Error == null;
    }
}
