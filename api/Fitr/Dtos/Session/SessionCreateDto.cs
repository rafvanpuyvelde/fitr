using System;
using Fitr.Dtos.Workout;

namespace Fitr.Dtos.Session
{
    public class SessionCreateDto
    {
        public DateTime Date { get; set; }
        
        public int WorkoutId { get; set; }
        
        public WorkoutPostDto Workout { get; set; }
    }
}