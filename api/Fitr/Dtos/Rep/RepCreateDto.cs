using Fitr.Dtos.Exercise;
using Fitr.Dtos.Set;

namespace Fitr.Dtos.Rep
{
    public class RepCreateDto
    {
        public int SetId { get; set; }
        
        public int ExerciseId { get; set; }
        
        public ExerciseCreateDto Exercise { get; set; }
    }
}