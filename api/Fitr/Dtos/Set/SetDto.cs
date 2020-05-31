using Fitr.Data;
using Fitr.Dtos.Exercise;

namespace Fitr.Dtos.Set
{
    public class SetDto
    {
        public int Id { get; set; }
        
        public int ExerciseId { get; set; }
        
        public ExerciseDto Exercise { get; set; }
        
        public double Weight { get; set; }
        
        public Enums.Unit Unit { get; set; }

        public bool UsesBands { get; set; }
        
        public bool UsesChains { get; set; }

        public int Reps { get; set; }
    }
}