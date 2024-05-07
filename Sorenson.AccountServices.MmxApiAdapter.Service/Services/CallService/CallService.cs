using Microsoft.AspNetCore.Mvc;

namespace Sorenson.AccountServices.MmxApiAdapter.Service.Services.CallService
{
    public class CallService : ICallService
    {
        public ActionResult<string> getCallBalance()
        {
            return "call balance";
        }

        public ActionResult<string> getCallHistory()
        {
            return "call history";
        }
    }
}
