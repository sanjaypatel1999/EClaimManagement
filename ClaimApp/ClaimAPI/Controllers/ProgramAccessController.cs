using ClaimAPI.Models;
using ClaimAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ClaimAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProgramAccessController : ControllerBase
    {
        private APIResponse response = new APIResponse();
        public IProgram ProgramService { get; }
        public ProgramAccessController(IProgram program)
        {
            ProgramService = program;
        }

        [Route("GetProgramList")]
        [HttpGet]
        public IActionResult GetProgramList(int UserId) {
            try
            {
                var result = ProgramService.GetPrograms(UserId);
                response.status = 200;
                response.ok = true;
                response.data = result;
                response.message = "program found!";

            }
            catch (Exception ex)
            {
                response.status = 500;
                response.ok = true;
                response.message = ex.Message;
            }
            return Ok(response);
        }

    }
}
