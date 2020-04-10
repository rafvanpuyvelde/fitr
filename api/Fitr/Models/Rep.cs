namespace Fitr.Models
{
    public class Rep
    {
        public int Id { get; set; }

        public int Amount { get; set; }

        public int SetId { get; set; }
        
        public Set Set { get; set; }
        
        public int ExerciseId { get; set; }
        
        public Exercise Exercise { get; set; }
    }
}