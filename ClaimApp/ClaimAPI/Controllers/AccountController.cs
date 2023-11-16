using ClaimAPI.Enums;
using ClaimAPI.Models;
using ClaimAPI.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace ClaimAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        public IUserAccount _accountService { get; }
        private APIResponse response = new APIResponse();
        private IConfiguration _config;
        public AccountController(IUserAccount account, IConfiguration _config)
        {
            _accountService = account;
            this._config = _config;
        }

        [HttpPost]
        [Route("Login")]
        public IActionResult Login(UserLogin user)
        {
            try
            {
                var result = _accountService.Login(user);
                if (result == LoginResult.Success)
                {
                    var userInfo = _accountService.GetUserByEmailID(user.UserId);
                    response.status = 200;
                    response.ok = true;
                    response.data = userInfo;
                    response.message = "User authenticated successfully!";

                    response.token = GenerateJSONWebToken(userInfo);

                }
                else if (result == LoginResult.Invalid)
                {
                    response.status = 101;
                    response.ok = false;
                    response.data = null;
                    response.message = "User not autheticated!";
                }
                else if (result == LoginResult.NotExist)
                {
                    response.status = 101;
                    response.ok = false;
                    response.data = null;
                    response.message = "User not exist!";
                }
                else
                {
                    response.status = 101;
                    response.ok = false;
                    response.data = null;
                    response.message = "Something went wrong!";
                }
            }
            catch (Exception ex)
            {
                response.status = 500;
                response.ok = false;
                response.data = null;
                response.message = ex.Message;
            }

            return Ok(response);
        }

        [HttpPost]
        [Route("Register")]
        public IActionResult Register(Users user)
        {
            var result = _accountService.SignUp(user);
            if (result == "ok")
            {
                response.status = 200;
                response.ok = true;
                response.data = user;
                response.message = "User registered successfully!";
            }
            else
            {
                response.status = 101;
                response.ok = false;
                response.data = null;
                response.message = "User not registered successfully!";
            }
            return Ok(response);
        }
        private string GenerateJSONWebToken(UserVm userInfo)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[] {
            new Claim(JwtRegisteredClaimNames.Sub, userInfo.Email),
            new Claim(JwtRegisteredClaimNames.Email, userInfo.Email),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
              };

            var token = new JwtSecurityToken(_config["Jwt:Issuer"],
                _config["Jwt:Issuer"],
                claims,
                expires: DateTime.Now.AddMinutes(15),
                signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

    }
}
