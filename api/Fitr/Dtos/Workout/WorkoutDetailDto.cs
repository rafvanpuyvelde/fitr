using System.Collections.Generic;

namespace Fitr.Dtos.Workout
{
    public class WorkoutDetailDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public bool IsActive { get; set; }

        public int AmountOfSessions { get; set; }

        public ICollection<WorkoutExercisesDto> Exercises { get; set; }
    }
}