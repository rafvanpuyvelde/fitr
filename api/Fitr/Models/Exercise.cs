using System.Collections.Generic;

namespace Fitr.Models
{
    public class Exercise
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public ICollection<Set> Sets { get; set; }
        
        public ICollection<WorkoutHasExercise> Workouts { get; set; }
    }
}