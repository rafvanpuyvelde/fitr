using System;
using System.Collections.Generic;

namespace Fitr.Dtos.Workout
{
    public class WorkoutSessionDetailDto
    {
        public int Id { get; set; }

        public int WorkoutId { get; set; }

        public DateTime Date { get; set; }

        public ICollection<WorkoutSessionExerciseCreateDto> Sessions { get; set; }
    }
}