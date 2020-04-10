using System.Collections.Generic;

namespace Fitr.Dtos.Workout
{
    public class WorkoutDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public ICollection<WorkoutSessionDto> Sessions { get; set; }

        public ICollection<WorkoutExercisesDto> Exercises { get; set; }
    }
}