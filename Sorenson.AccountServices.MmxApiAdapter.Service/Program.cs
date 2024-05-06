var builder = WebApplication.CreateBuilder(args);

//
// Configure the service container
builder.Services.AddControllers();

var app = builder.Build();

//
// Configure the HTTP request middleware pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

//
// Configure the HTTP request endpoints
app.MapControllers();

app.Run();



// This is necessary to allow the WebApplicationFactory to find the Program class
public partial class Program { }
