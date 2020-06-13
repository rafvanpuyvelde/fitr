namespace Fitr.Dtos.Workout
{
    public class WorkoutSessionExerciseCreateDto
    {
        public int ExerciseId { get; set; }

        public int[] Reps { get; set; }

        public double[] Weight { get; set; }
    }
}