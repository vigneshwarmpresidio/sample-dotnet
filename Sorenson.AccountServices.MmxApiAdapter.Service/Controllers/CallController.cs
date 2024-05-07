using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Sorenson.AccountServices.MmxApiAdapter.Service.Services.CallService;

namespace Sorenson.AccountServices.MmxApiAdapter.Service.Controllers
{
    [ApiController]
    public class CallController : ControllerBase
    {
        private readonly ICallService _callService;
        public CallController(ICallService callService) {
            _callService = callService;
        }

        [HttpGet]
        [Route("callbalance")]
        public ActionResult<string> getCallBalance()
        {
            return _callService.getCallBalance();
        }

        [HttpGet]
        [Route("callhistory")]
        public ActionResult<string> getCallHistory()
        {
            return _callService.getCallHistory();
        }
    }
}
