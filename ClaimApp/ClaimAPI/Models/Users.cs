
namespace ClaimAPI.Models
{
 
        public class Users
        {
            public int Id { get; set; }
            public string UserId { get; set; }
            public string Email { get; set; }
            public string Password { get; set; }
            public string UserName { get; set; }

        }
    public class UserVm
    {
        public string Id { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string UserName { get; set; }
        public string ManagerId { get; set; }

    }
    public class UserLogin
        {
            public string UserId { get; set; }
            public string Password { get; set; }
        }
    
}
