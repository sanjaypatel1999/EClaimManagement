using ClaimAPI.Data;
using ClaimAPI.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;

namespace ClaimAPI.Services
{
    
    public interface IProgram
    {
        List<ProgramVm> GetPrograms(int UserId);

    }
    public class ProgramService : IProgram
    {
        public ApplicationDbContext DbContext { get; }
        public ProgramService(ApplicationDbContext dbContext)
        {
            DbContext = dbContext;
        }
        public List<ProgramVm> GetPrograms(int UserId)
        {
            using (var command = DbContext.Database.GetDbConnection().CreateCommand())
            {
                command.CommandText = "usd_get_program_path";
                command.CommandType = CommandType.StoredProcedure;

                var parameter = new SqlParameter("@UserId", UserId);

                command.Parameters.Add(parameter);

                DbContext.Database.OpenConnection();

                var result = command.ExecuteReader();
                List<ProgramVm> resultList = new List<ProgramVm>();
                while (result.Read())
                {
                    ProgramVm resultVm = new ProgramVm();
                    resultVm.Id = result["Id"].ToString();
                    resultVm.Path = result["path"].ToString();
                    resultVm.Title = result["title"].ToString();
                    resultVm.Description = result["Descr"].ToString();
                    resultList.Add(resultVm);
                }
                return resultList;
            }

        }
    }
}
