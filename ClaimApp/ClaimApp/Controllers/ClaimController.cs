using Microsoft.AspNetCore.Mvc;

namespace ClaimApp.Controllers
{
    public class ClaimController : Controller
    {
        public IActionResult AddClaim()
        {
            return View();
        }
        public IActionResult ShowClaim(string Role)
        {
            ViewBag.Role = Role;
            return View();
        }
    }
}
