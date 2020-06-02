using System.Collections.Generic;

namespace Fitr.Dtos.Workout
{
    public class WorkoutExerciseSessionDetailDto
    {
        public int WorkoutId { get; set; }

        public string WorkoutName { get; set; }

        public int ExerciseId { get; set; }

        public string ExerciseName { get; set; }

        public virtual ICollection<WorkoutExerciseSession> Sessions { get; set; }
    }
}