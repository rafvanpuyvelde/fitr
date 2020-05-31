using System;

namespace Fitr.Dtos.Exercise
{
    public class ExerciseSessionsDto
    {
        public int Id { get; set; }

        public DateTime Date { get; set; }

        public int WorkoutId { get; set; }
    }
}