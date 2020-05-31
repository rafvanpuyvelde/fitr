using System.Collections.Generic;
using Fitr.Dtos.Set;

namespace Fitr.Dtos.Exercise
{
    public class ExerciseDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public ICollection<SetDto> Sets { get; set; }
        
        public ICollection<ExerciseWorkoutDto> Workouts { get; set; }

        public ICollection<ExerciseSessionsDto> Sessions { get; set; }
    }
}