using System.Collections.Generic;
using Fitr.Data;
using Fitr.Dtos.Exercise;
using Fitr.Dtos.Rep;

namespace Fitr.Dtos.Set
{
    public class SetCreateDto
    {
        public ExerciseCreateDto Exercise { get; set; }
        
        public double Weight { get; set; }
        
        public Enums.Unit Unit { get; set; }

        public bool? UsesBands { get; set; }
        
        public bool? UsesChains { get; set; }

        public ICollection<RepCreateDto> Reps { get; set; }
    }
}