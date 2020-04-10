using System;
using Fitr.Dtos.Workout;

namespace Fitr.Dtos.Session
{
    public class SessionDto
    {
        public int Id { get; set; }

        public DateTime Date { get; set; }
        
        public int WorkoutId { get; set; }
        
        public WorkoutDto Workout { get; set; }
    }
}