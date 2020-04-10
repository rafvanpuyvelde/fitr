using System.Collections.Generic;
using System.Threading.Tasks;
using Fitr.Dtos.Workout;

namespace Fitr.Repositories.Workout
{
    public interface IWorkoutRepository
    {
        Task<WorkoutDto> Get(string id);
        
        Task<IEnumerable<WorkoutDto>> GetAll(string currentUserId);
        
        Task<WorkoutPostDto> Create(WorkoutPostDto workout);
    }
}