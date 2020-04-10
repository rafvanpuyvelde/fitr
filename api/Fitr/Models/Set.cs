using System.Collections.Generic;
using static Fitr.Data.Enums;

namespace Fitr.Models
{
    public class Set
    {
        public int Id { get; set; }
        
        public int ExerciseId { get; set; }
        
        public Exercise Exercise { get; set; }
        
        public double Weight { get; set; }
        
        public Unit Unit { get; set; }

        public bool UsesBands { get; set; }
        
        public bool UsesChains { get; set; }

        public ICollection<Rep> Reps { get; set; }
    }
}