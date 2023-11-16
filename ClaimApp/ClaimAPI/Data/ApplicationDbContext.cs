using ClaimAPI.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace ClaimAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<Users> Users { get; set; }

    }
}
