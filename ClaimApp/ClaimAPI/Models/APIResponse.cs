namespace ClaimAPI.Models
{
    public class APIResponse
    {
        public bool ok { get; set; }
        public int status { get; set; }
        public string message { get; set; }
        public string token { get; set; }
        public object data { get; set; }
    }
}
