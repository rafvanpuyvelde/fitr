using System.Collections.Generic;

namespace Fitr.Models
{
    public class Exercise
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public virtual ICollection<Set> Sets { get; set; }
        
        public virtual ICollection<WorkoutHasExercise> Workouts { get; set; }
    }
}