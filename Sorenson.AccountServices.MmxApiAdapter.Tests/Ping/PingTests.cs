namespace Sorenson.AccountServices.MmxApiAdapter.Tests.Ping;

using System.Net;
using System.Threading.Tasks;
using Xunit;
using Sorenson.AccountServices.MmxApiAdapter.Tests.Startup;
using Sorenson.AccountServices.MmxApiAdapter.Tests.Extensions;

public class PingTests(TestWebApplicationFactory testFactory) : TestBase(testFactory)
{
    [Fact]
    public async Task Get_Ping_ReturnsPong()
    {
        // Arrange
        var expectedBody = "Pong.";

        // Act
        var response = await this.client.GetAsync("/api/ping");
        var responseBody = await response.Content.ReadAsStringAsync();

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal(expectedBody, responseBody);
    }

    [Fact]
    public async Task Get_PingWithMessage_ReturnsPongWithMessage()
    {
        // Arrange
        var expectedBody = "Pong: Hello, World!";

        // Act
        var response = await this.client.GetAsync("/api/ping", new Dictionary<string, string?> { { "message", "Hello, World!" } });
        var responseBody = await response.Content.ReadAsStringAsync();

        // Assert
        Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        Assert.Equal(expectedBody, responseBody);
    }
}
