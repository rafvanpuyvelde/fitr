using System.Collections.Generic;
using System.Threading.Tasks;
using Fitr.Dtos.Workout;

namespace Fitr.Repositories.Workout
{
    public interface IWorkoutRepository
    {
        Task<WorkoutDetailDto> Get(string currentUserId, int workoutId);
        
        Task<IEnumerable<WorkoutDto>> GetAll(string currentUserId);
        
        Task<WorkoutPostDto> Create(WorkoutPostDto workout);

        Task<WorkoutExerciseSessionDetailDto> GetExerciseSessions(string currentUserId, int workoutId, int exerciseId);
    }
}