using System;
using Fitr.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Fitr.Data
{
    public static class ModelBuilderExtensions
    {
        public static void MigrateDb(this ModelBuilder modelBuilder)
        {
            SetupWorkoutDbRelation(modelBuilder);

            SetupExerciseDbRelation(modelBuilder);
            
            SetupSetDbRelation(modelBuilder);
            
            SetupRepDbRelation(modelBuilder);
            
            SetupWorkoutHasExercisesDbRelation(modelBuilder);
        }
        
        public static void SeedDb(this ModelBuilder modelBuilder)
        {
            var pwdHasher = new PasswordHasher<User>();

            // Create users
            var users = new[] {
                new User
                {
                    Id = Guid.NewGuid().ToString("D"),
                    UserName = "JaneDoe123",
                    Email = "janedoe@test.com",
                    NormalizedEmail = "janedoe@test.com".ToUpper(),
                    NormalizedUserName = "JaneDoe123".ToUpper(),
                    TwoFactorEnabled = false,
                    EmailConfirmed = true,
                    PhoneNumber = "123456789",
                    PhoneNumberConfirmed = false,
                    Name = "Jane", 
                    LastName = "Doe", 
                },
                new User
                {
                    Id = Guid.NewGuid().ToString("D"),
                    UserName = "JohnDoe123",
                    Email = "johndoe@test.com",
                    NormalizedEmail = "johndoe@test.com".ToUpper(),
                    NormalizedUserName = "JohnDoe123".ToUpper(),
                    TwoFactorEnabled = false,
                    EmailConfirmed = true,
                    PhoneNumber = "133456789",
                    PhoneNumberConfirmed = false,
                    Name = "John",
                    LastName = "Doe",
                },
                new User
                {
                    Id = Guid.NewGuid().ToString("D"),
                    UserName = "JimDoe123",
                    Email = "jimdoe@test.com",
                    NormalizedEmail = "jimdoe@test.com".ToUpper(),
                    NormalizedUserName = "JimDoe123".ToUpper(),
                    TwoFactorEnabled = false,
                    EmailConfirmed = true,
                    PhoneNumber = "123456789",
                    PhoneNumberConfirmed = false,
                    Name = "Jim",
                    LastName = "Doe",
                }
            };

            // Add hashed passwords
            foreach (var user in users)
            {
                user.PasswordHash = pwdHasher.HashPassword(user, "Azerty123_");
                user.SecurityStamp = Guid.NewGuid().ToString("D");
            }

            // Seed users
            modelBuilder.Entity<User>().HasData(users);

            // Seed workouts
            modelBuilder.Entity<Workout>().HasData(
                new Workout { Id = 1, Name = "Upper Lower split", UserId = users[0].Id },
                new Workout { Id = 2, Name = "5x5 workout", UserId = users[0].Id },
                new Workout { Id = 3, Name = "Full body workout", UserId = users[0].Id },
                new Workout { Id = 4, Name = "Warmup routine", UserId = users[0].Id }
            );
        }
        
        private static void SetupWorkoutHasExercisesDbRelation(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<WorkoutHasExercise>(workoutHasExercise =>
            {
                workoutHasExercise.HasKey(w => new { w.WorkoutId, w.ExerciseId });

                workoutHasExercise.HasOne(w => w.Exercise)
                    .WithMany(e => e.Workouts)
                    .HasForeignKey(w => w.ExerciseId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Cascade); // When a WorkoutHasExercise is deleted, the corresponding Exercise may not be deleted
                
                workoutHasExercise.HasOne(w => w.Workout)
                    .WithMany(e => e.Exercises)
                    .HasForeignKey(w => w.WorkoutId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Cascade); // When a WorkoutHasExercise is deleted, the corresponding Workout may not be deleted
            });
        }

        private static void SetupRepDbRelation(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Rep>(rep =>
            {
                rep.HasOne(r => r.Set)
                    .WithMany(s => s.Reps) 
                    .HasForeignKey(r => r.SetId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Restrict); // When a Rep is deleted, the corresponding Sets may not be deleted
            });
        }
        
        private static void SetupSetDbRelation(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Set>(set =>
            {
                set.HasMany(s => s.Reps)
                    .WithOne(r => r.Set) 
                    .HasForeignKey(r => r.SetId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Restrict); // When a Set is deleted, the corresponding Reps may not be deleted
                
                set.HasOne(s => s.Exercise)
                    .WithMany(e => e.Sets) 
                    .HasForeignKey(s => s.ExerciseId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Restrict); // When a Set is deleted, the corresponding Exercises may not be deleted
            });
        }

        private static void SetupExerciseDbRelation(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Exercise>(exercise =>
            {
                exercise.HasMany(e => e.Sets)
                    .WithOne(s => s.Exercise)
                    .HasForeignKey(s => s.ExerciseId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Restrict); // When a Exercise is deleted, the corresponding Set may not be deleted
            });
        }

        private static void SetupWorkoutDbRelation(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Workout>(workout =>
            {
                workout.HasOne(w => w.User)
                    .WithMany(u => u.Workouts)
                    .HasForeignKey(c => c.UserId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Restrict); // When a Workout is deleted, the corresponding User may not be deleted

                workout.HasMany(w => w.Sessions)
                    .WithOne(s => s.Workout)
                    .HasForeignKey(s => s.WorkoutId)
                    .IsRequired()
                    .OnDelete(DeleteBehavior.Restrict); // When a Workout is deleted, the corresponding Sessions may not be deleted
            });
        }
    }
}