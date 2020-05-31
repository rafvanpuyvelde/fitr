using System;
using Fitr.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Fitr.Data
{
    public class FitrContext : IdentityDbContext
    <
        User,
        IdentityRole,
        string,
        IdentityUserClaim<string>,
        IdentityUserRole<string>,
        IdentityUserLogin<string>,
        IdentityRoleClaim<string>,
        IdentityUserToken<string>
    >
    {
        public FitrContext(DbContextOptions<FitrContext> options) : base(options)
        {
        }

        public DbSet<Exercise> Exercises { get; set; }
        
        public DbSet<Session> Sessions { get; set; }
        
        public DbSet<Set> Sets { get; set; }
        
        public DbSet<Workout> Workouts { get; set; }
        
        public DbSet<WorkoutHasExercise> WorkoutHasExercises { get; set; }
        
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            if (modelBuilder == null) { throw new ArgumentNullException(nameof(modelBuilder)); }

            modelBuilder.MigrateDb();

            // modelBuilder.SeedDb();
        }
    }
}