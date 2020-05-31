using System.Collections.Generic;

namespace Fitr.Models
{
    public class Workout
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string UserId { get; set; }
        
        public virtual User User { get; set; }

        public bool IsActive { get; set; }

        public virtual ICollection<Session> Sessions { get; set; }

        public virtual ICollection<WorkoutHasExercise> Exercises { get; set; }
    }
}