using Microsoft.AspNetCore.Mvc;

namespace ClaimApp.Controllers
{
    public class AccountController : Controller
    {
        public IActionResult Login()
        {
            return View();
        }
    }
}
