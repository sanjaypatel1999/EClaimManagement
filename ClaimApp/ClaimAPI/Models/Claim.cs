namespace ClaimAPI.Models
{
    public class EmployeeClaim
    {
        public int UserId { get; set; }
        public string ClaimTitle { get; set; }
        public string ClaimReason { get; set; }
        public string ClaimDescription { get; set; }
        public string ClaimAmount { get; set; }
        public string Evidence { get; set; }
        public string ExpenseDt { get; set; }

    }
    public class EmployeeClaimRequest
    {
        public int ClaimId { get; set; }
        public string ClaimTitle { get; set; }
        public string ClaimReason { get; set; }
        public string ClaimDescription { get; set; }
        public string ClaimAmount { get; set; }
        public string Evidence { get; set; }
        public string ExpenseDt { get; set; }
        public string ClaimDt { get; set; }
        public string EmployeeName { get; set; }
        public string CurrentStatus { get; set; }
    }

    public class ClaimAction
    {
        public int ClaimId { get; set; }
        public string Role { get; set;}
        public int Action { get; set; }
        public int UserId { get; set; }
        public string Remarks { get; set; }
    }
    public class ClaimActionHisotry
    {
        public string ActionDt { get; set; }
        public string Action { get; set;}
        public string Actionby { get; set; }
        public string Remarks { get; set; }
    }
}
