using System;

namespace Fitr.Dtos.Workout
{
    public class WorkoutSessionExerciseCreateDto
    {
        public int Id { get; set; }

        public int ExerciseId { get; set; }

        public DateTime Date { get; set; }

        public int Sets { get; set; }

        public int[] Reps { get; set; }

        public double[] Weight { get; set; }
    }
}