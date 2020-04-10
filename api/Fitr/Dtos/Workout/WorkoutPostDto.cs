using System.Collections.Generic;
using Fitr.Dtos.Session;

namespace Fitr.Dtos.Workout
{
    public class WorkoutPostDto
    {
        public string Name { get; set; }

        public ICollection<SessionCreateDto> Sessions { get; set; }

        public ICollection<WorkoutExercisesDto> Exercises { get; set; }
    }
}