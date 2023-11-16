using ClaimAPI.Enums;
using ClaimAPI.Models;

namespace ClaimAPI.Services
{

        public interface IUserAccount
        {
            string SignUp(Users users);
            LoginResult Login(UserLogin users);
            UserVm GetUserByEmailID(string email);
            void Logout();
        
    }
}
