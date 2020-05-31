using System;
using System.Collections.Generic;

namespace Fitr.Models
{
    public class Session
    {
        public int Id { get; set; }

        public DateTime Date { get; set; }
        
        public int WorkoutId { get; set; }
        
        public virtual Workout Workout { get; set; }

        public virtual ICollection<Set> Sets { get; set; }
    }
}