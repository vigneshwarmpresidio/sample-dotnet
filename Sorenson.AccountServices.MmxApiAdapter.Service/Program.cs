using Sorenson.AccountServices.MmxApiAdapter.Service.Services.CallService;

var builder = WebApplication.CreateBuilder(args);

//
// Configure the service container
builder.Services.AddControllers();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<ICallService, CallService>();

var app = builder.Build();

//
// Configure the HTTP request middleware pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseHsts();
}

app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UsePathBase(new PathString("/RUE"));
app.UseRouting();
app.UseAuthorization();

//
// Configure the HTTP request endpoints
app.MapControllers();

app.Run();


// This is necessary to allow the WebApplicationFactory to find the Program class
public partial class Program { }
