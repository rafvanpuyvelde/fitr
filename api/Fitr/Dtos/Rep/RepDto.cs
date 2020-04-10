using Fitr.Dtos.Exercise;
using Fitr.Dtos.Set;

namespace Fitr.Dtos.Rep
{
    public class RepDto
    {
        public int Id { get; set; }

        public int Amount { get; set; }

        public int SetId { get; set; }
        
        public SetDto Set { get; set; }
        
        public int ExerciseId { get; set; }
        
        public ExerciseDto Exercise { get; set; }
    }
}