using Microsoft.AspNetCore.Mvc;

namespace MmxApiAdapter.Controllers;

[ApiController]
[Route("api/[controller]")]
public class PingController : ControllerBase
{
    public PingController()
    {
    }

    [HttpGet]
    public ActionResult<string> Get([FromQuery] string message = "")
    {
        if (!string.IsNullOrEmpty(message))
        {
            return $"Pong: {message}";
        }
        else
        {
            return "Pong.";
        }
    }
}
