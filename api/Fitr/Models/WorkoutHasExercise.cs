namespace Fitr.Models
{
    public class WorkoutHasExercise
    {
        public int WorkoutId { get; set; }
        
        public virtual Workout Workout { get; set; }
        
        public int ExerciseId { get; set; }
        
        public virtual Exercise Exercise { get; set; }
    }
}