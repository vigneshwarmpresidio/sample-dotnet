namespace Sorenson.AccountServices.MmxApiAdapter.Tests.Startup;

using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Hosting;

public class TestWebApplicationFactory : WebApplicationFactory<Program>
{
    protected override IHost CreateHost(IHostBuilder builder)
    {
        return base.CreateHost(builder);
    }

    // This method is called before the ConfigureWebHost method. It can be used to inject services into the
    // web application, and/or configure the client used to communicate with the server.
    protected override void ConfigureWebHost(IWebHostBuilder builder)
    {
        builder.ConfigureServices(services =>
        {
            // Provide test-specific implementations of services here
        });
    }
}
