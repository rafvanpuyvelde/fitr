using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Fitr.Data;
using Fitr.Dtos.Workout;
using Microsoft.EntityFrameworkCore;

namespace Fitr.Repositories.Workout
{
    public class WorkoutRepository : IWorkoutRepository
    {
        private readonly FitrContext _context;

        public WorkoutRepository(FitrContext context)
        {
            _context = context;
        }

        public Task<WorkoutDto> Get(string id)
        {
            throw new System.NotImplementedException();
        }

        public async Task<IEnumerable<WorkoutDto>> GetAll(string currentUserId)
        {
            return await _context.Workouts
                .Include(w => w.Exercises)
                .Include(w => w.Sessions)
                .Where(w => w.UserId == currentUserId)
                .Select(w => new WorkoutDto
                {
                    Id = w.Id,
                    Name = w.Name,
                    Exercises = w.Exercises.Select(e => new WorkoutExercisesDto
                    {
                        Id = e.ExerciseId,
                        Name = e.Exercise.Name,
                        Sets = e.Exercise.Sets.Select(s => new WorkoutSetDto
                        {
                            Id = s.Id,
                            Reps = s.Reps.Select(r => new WorkoutRepDto
                            {
                                Id = r.Id,
                                Amount = r.Amount
                            }).ToList(),
                            Weight = s.Weight
                        }).ToList()
                    }).ToList()
                })
                .AsNoTracking()
                .ToListAsync()
                .ConfigureAwait(false);
        }

        public Task<WorkoutPostDto> Create(WorkoutPostDto workout)
        {
            throw new System.NotImplementedException();
        }
    }
}