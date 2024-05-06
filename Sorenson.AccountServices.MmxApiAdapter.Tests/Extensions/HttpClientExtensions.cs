namespace Sorenson.AccountServices.MmxApiAdapter.Tests.Extensions;

using Microsoft.AspNetCore.WebUtilities;

public static class HttpClientExtensions
{
    public static async Task<HttpResponseMessage> GetAsync(this HttpClient client, string url, Dictionary<string, string?> queryParams)
    {
        var fullUrl = QueryHelpers.AddQueryString(url, queryParams);
        return await client.GetAsync(fullUrl);
    }
}
