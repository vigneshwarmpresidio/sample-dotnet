namespace Sorenson.AccountServices.MmxApiAdapter.Tests;

using Sorenson.AccountServices.MmxApiAdapter.Tests.Startup;

public abstract class TestBase : IClassFixture<TestWebApplicationFactory>
{
    protected readonly HttpClient client;

    private readonly TestWebApplicationFactory factory;

    protected TestBase(TestWebApplicationFactory factory)
    {
        this.factory = factory;
        this.client = factory.CreateClient();
    }
}
