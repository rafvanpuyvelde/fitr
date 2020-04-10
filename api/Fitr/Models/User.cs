using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;

namespace Fitr.Models
{
    public class User : IdentityUser
    {
        public string Name { get; set; }
        
        public string LastName { get; set; }

        public ICollection<Workout> Workouts { get; set; }
    }
}