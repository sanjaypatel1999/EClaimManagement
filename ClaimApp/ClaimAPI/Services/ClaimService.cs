using ClaimAPI.Data;
using ClaimAPI.Models;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;
using System.Security.Claims;

namespace ClaimAPI.Services
{
    public interface IClaimService
    {
        string RaiseClaimRequest(EmployeeClaim claim);
        Tuple<string, List<EmployeeClaimRequest>> GetAllPendingRequest(int userid,string role);
        Tuple<string, List<ClaimActionHisotry>> GetClaimActionHisotry(int claimid);
        string ClaimAction(ClaimAction claim);
    }
    public class ClaimService : IClaimService
    {
        public ApplicationDbContext DbContext { get; }
        public ClaimService(ApplicationDbContext dbContext)
        {
            DbContext = dbContext;
        }
        public string RaiseClaimRequest(EmployeeClaim claim)
        {
            string message=string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "USP_Raise_Claim_Request";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@UserId";
                    parameter.SqlValue = claim.UserId;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Claim_Title";
                    parameter.SqlValue = claim.ClaimTitle;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Claim_Reason";
                    parameter.SqlValue = claim.ClaimReason;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Amount";
                    parameter.SqlValue = Convert.ToDecimal(claim.ClaimAmount);
                    parameter.SqlDbType = SqlDbType.Decimal;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@ExpenseDt";
                    parameter.SqlValue = claim.ExpenseDt;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Evidence";
                    parameter.SqlValue = claim.Evidence;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@Claim_Description";
                    parameter.SqlValue = claim.ClaimDescription;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteScalar();

                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            } 
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return message;     
         }

        public Tuple<string, List<EmployeeClaimRequest>> GetAllPendingRequest(int userid, string role)
        {
            string message = string.Empty;
            List<EmployeeClaimRequest> lstclaimRequests = new List<EmployeeClaimRequest>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "USP_GET_Pending_Request";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@userid";
                    parameter.SqlValue = userid;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@role";
                    parameter.SqlValue =role;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while(result.Read())
                    {
                        EmployeeClaimRequest claimRequest=new EmployeeClaimRequest();
                        claimRequest.ClaimTitle = result["Claim_Title"].ToString();
                        claimRequest.ClaimReason = result["Claim_Reason"].ToString();
                        claimRequest.ClaimAmount = result["Claim_Title"].ToString();
                        claimRequest.ClaimDescription = result["Claim_Description"].ToString();
                        claimRequest.ClaimId = Convert.ToInt32(result["Id"]);
                        claimRequest.ClaimDt = result["ClaimDt"].ToString();
                        claimRequest.ExpenseDt = result["ExpenseDt"].ToString();
                        claimRequest.EmployeeName = result["Nm"].ToString();
                        claimRequest.CurrentStatus = result["CurrentStatus"].ToString();
                        claimRequest.Evidence = result["Evidence"].ToString();

                        lstclaimRequests.Add(claimRequest);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<EmployeeClaimRequest>>(message,lstclaimRequests) ;
        }

        public string ClaimAction(ClaimAction claim)
        {
            string message = string.Empty;
            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_update_claim";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@userid";
                    parameter.SqlValue = claim.UserId;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@role";
                    parameter.SqlValue = claim.Role;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@action";
                    parameter.SqlValue = claim.Action;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@remark";
                    parameter.SqlValue = claim.Remarks;
                    parameter.SqlDbType = SqlDbType.VarChar;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@claimid";
                    parameter.SqlValue = claim.ClaimId;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);

                
                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteScalar();

                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return message;
        }

        public Tuple<string, List<ClaimActionHisotry>> GetClaimActionHisotry(int claimid)
        {
            string message = string.Empty;
            List<ClaimActionHisotry> lstclaimRequests = new List<ClaimActionHisotry>();

            try
            {
                using (var command = DbContext.Database.GetDbConnection().CreateCommand())
                {
                    command.CommandText = "usp_get_claim_action_history";
                    command.CommandType = CommandType.StoredProcedure;

                    var parameter = new SqlParameter();

                    parameter = new SqlParameter();
                    parameter.ParameterName = "@claim_id";
                    parameter.SqlValue = claimid;
                    parameter.SqlDbType = SqlDbType.Int;
                    parameter.Direction = ParameterDirection.Input;
                    command.Parameters.Add(parameter);


                    DbContext.Database.OpenConnection();
                    var result = command.ExecuteReader();
                    while (result.Read())
                    {
                        ClaimActionHisotry claimRequest = new ClaimActionHisotry();
                        claimRequest.ActionDt = result["ActionDt"].ToString();
                        claimRequest.Actionby = result["Nm"].ToString();
                        claimRequest.Action = result["Action"].ToString();
                        claimRequest.Remarks = result["Remarks"].ToString();
                        

                        lstclaimRequests.Add(claimRequest);
                    }
                    DbContext.Database.CloseConnection();
                }
            }
            catch (SqlException ex)
            {
                message = ex.Message;
            }
            catch (Exception ex)
            {
                message = ex.Message;
            }
            return new Tuple<string, List<ClaimActionHisotry>>(message, lstclaimRequests);
        }
    }
}
