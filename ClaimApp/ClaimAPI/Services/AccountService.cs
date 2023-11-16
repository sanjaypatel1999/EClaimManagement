using ClaimAPI.Data;
using ClaimAPI.Models;
using Microsoft.EntityFrameworkCore;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using System.Data;
using Microsoft.Data.SqlClient;
using ClaimAPI.Enums;

namespace ClaimAPI.Services
{
    public class AccountService: IUserAccount
    {
         public ApplicationDbContext DbContext { get; }
        public AccountService(ApplicationDbContext dbContext) {
            DbContext = dbContext;
        }

        public LoginResult Login(UserLogin users)
        {
            using (var command = DbContext.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = "USP_LoginUser";
                command.CommandType = CommandType.StoredProcedure;

                var parameter = new SqlParameter("@email", users.UserId);
                var parameter2 = new SqlParameter("@pass", users.Password);

                command.Parameters.Add(parameter);
                command.Parameters.Add(parameter2);

                DbContext.Database.OpenConnection();
                LoginResult result = (LoginResult)command.ExecuteScalar();
                return result;
            }
           
        }

        public UserVm GetUserByEmailID(string email)
        {
            using (var command = DbContext.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = "usp_get_user_by_email";
                command.CommandType = CommandType.StoredProcedure;

                var parameter = new SqlParameter("@email", email);

                command.Parameters.Add(parameter);

                DbContext.Database.OpenConnection();

                var result = command.ExecuteReader();
                result.Read();
                UserVm user=new UserVm();
                user.Email = result["Email"].ToString();
                user.Id = result["Id"].ToString();
                user.UserName = result["Nm"].ToString();
                user.Mobile = result["Mobile"].ToString();
                user.ManagerId = result["Manager_Id"].ToString();
                DbContext.Database.CloseConnection();
                return user;
            }

        }
        public void Logout()
        {
            // nno code
        }

        public string SignUp(Users users)
        {
            DbContext.Users.Add(users);
            DbContext.SaveChanges();
            return "ok";
        }
    }
}
