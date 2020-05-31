using Fitr.Data;

namespace Fitr.Dtos.Workout
{
    public class WorkoutExercisesDto
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Unit { get; set; }

        public double Record { get; set; }

        public double Trend { get; set; }
    }
}