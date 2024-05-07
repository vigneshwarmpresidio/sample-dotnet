using Microsoft.AspNetCore.Mvc;

namespace Sorenson.AccountServices.MmxApiAdapter.Service.Services.CallService
{
    public interface ICallService
    {
        ActionResult<string> getCallBalance();
        ActionResult<string> getCallHistory();
    }
}
