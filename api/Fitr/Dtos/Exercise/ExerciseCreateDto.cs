using System.Collections.Generic;
using Fitr.Dtos.Set;
using Fitr.Dtos.Workout;

namespace Fitr.Dtos.Exercise
{
    public class ExerciseCreateDto
    {
        public string Name { get; set; }

        public ICollection<SetCreateDto> Sets { get; set; }
        
        public ICollection<WorkoutPostDto> Workouts { get; set; }
    }
}