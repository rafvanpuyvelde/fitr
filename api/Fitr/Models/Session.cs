using System;

namespace Fitr.Models
{
    public class Session
    {
        public int Id { get; set; }

        public DateTime Date { get; set; }
        
        public int WorkoutId { get; set; }
        
        public Workout Workout { get; set; }
    }
}