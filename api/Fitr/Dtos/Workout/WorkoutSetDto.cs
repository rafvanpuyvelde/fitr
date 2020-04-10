using System.Collections.Generic;

namespace Fitr.Dtos.Workout
{
    public class WorkoutSetDto
    {
        public int Id { get; set; }

        public double Weight { get; set; }

        public ICollection<WorkoutRepDto> Reps { get; set; }
    }
}