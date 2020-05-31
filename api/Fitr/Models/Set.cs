using static Fitr.Data.Enums;

namespace Fitr.Models
{
    public class Set
    {
        public int Id { get; set; }
        
        public int ExerciseId { get; set; }
        
        public virtual Exercise Exercise { get; set; }
        
        public double Weight { get; set; }
        
        public Unit Unit { get; set; }

        public bool UsesBands { get; set; }
        
        public bool UsesChains { get; set; }

        public int Reps { get; set; }

        public int SessionId { get; set; }

        public Session Session { get; set; }
    }
}