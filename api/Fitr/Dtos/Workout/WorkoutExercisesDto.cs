using System.Collections.Generic;

namespace Fitr.Dtos.Workout
{
    public class WorkoutExercisesDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public ICollection<WorkoutSetDto> Sets { get; set; }
    }
}