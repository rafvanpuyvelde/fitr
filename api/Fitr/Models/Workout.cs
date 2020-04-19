using System.Collections.Generic;

namespace Fitr.Models
{
    public class Workout
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string UserId { get; set; }
        
        public User User { get; set; }

        public bool IsActive { get; set; }

        public ICollection<Session> Sessions { get; set; }

        public ICollection<WorkoutHasExercise> Exercises { get; set; }
    }
}