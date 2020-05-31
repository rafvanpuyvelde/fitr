using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Fitr.Data;
using Fitr.Dtos.Workout;
using Fitr.Models;
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

        public async Task<WorkoutDetailDto> Get(string currentUserId, int id)
        {
            var workout = await GetWorkoutDetails(currentUserId, id);

            await UpdateExerciseTrends(workout);

            return workout;
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
                    IsActive = w.IsActive
                })
                .AsNoTracking()
                .ToListAsync()
                .ConfigureAwait(false);
        }

        public Task<WorkoutPostDto> Create(WorkoutPostDto workout)
        {
            throw new System.NotImplementedException();
        }

        private Task UpdateExerciseTrends(WorkoutDetailDto workout)
        {
            // Get list of sets from db
            var sessions = _context.Sessions
                .Include(w => w.Sets)
                .Where(session => session.WorkoutId == workout.Id)
                .OrderBy(session => session.Date)
                .AsNoTracking()
                .ToArray();

            var trendsDictionary = CalculateExerciseTrends(sessions);

            foreach (var exercise in workout.Exercises)
            {
                trendsDictionary.TryGetValue(exercise.Id, out var exerciseTrend);
                exercise.Trend = exerciseTrend;
            }

            return Task.CompletedTask;
        }

        private static Dictionary<int, double> CalculateExerciseTrends(IReadOnlyList<Session> sessions)
        {
            var results = new Dictionary<int, double>();

            if (sessions.Count >= 2)
            {
                // Get data for the last two sessions
                var oldPerformanceDictionary = GetExercisePerformanceForSession(sessions[^2]);
                var newPerformanceDictionary = GetExercisePerformanceForSession(sessions[^1]);

                results = oldPerformanceDictionary.Keys.ToDictionary(key => key, key => Math.Round(newPerformanceDictionary[key] / oldPerformanceDictionary[key] - 1, 2) );
            }

            return results;
        }

        private static Dictionary<int, double> GetExercisePerformanceForSession(Session session)
        {
            var performanceDictionary = new Dictionary<int, double>();

            // Get all the exercise id's
            var exercises = session.Sets
                .GroupBy(set => set.ExerciseId)
                .ToArray();

            foreach (var exercise in exercises)
            {
                foreach (var set in exercise)
                {
                    if (!performanceDictionary.ContainsKey(exercise.Key))
                        performanceDictionary.Add(exercise.Key, set.Reps * set.Weight);
                    else
                        performanceDictionary[exercise.Key] = set.Reps * set.Weight + performanceDictionary[exercise.Key];
                }
            }

            return performanceDictionary;
        }

        private async Task<WorkoutDetailDto> GetWorkoutDetails(string currentUserId, int id)
        {
            return await _context.Workouts
                .Include(w => w.Exercises)
                .Include(w => w.Sessions)
                .Where(w => w.UserId == currentUserId && w.Id == id)
                .Select(w => new WorkoutDetailDto
                {
                    Id = w.Id,
                    Name = w.Name,
                    IsActive = w.IsActive,
                    AmountOfSessions = w.Sessions.Count,
                    Exercises = w.Exercises.Select(e => new WorkoutExercisesDto
                    {
                        Id = e.ExerciseId,
                        Name = e.Exercise.Name,
                        Record = e.Exercise.Sets.Max(set => set.Weight),
                        Unit = e.Exercise.Sets.First().Unit.ToString(),
                    }).ToList()
                })
                .AsNoTracking()
                .FirstAsync()
                .ConfigureAwait(false);
        }

        /*private async Task UpdateExerciseTrends(WorkoutDetailDto workout)
        {
            // Get exercise id's from workout
            var exerciseIds = workout.Exercises.Select(exercise => exercise.Id).ToArray();

            // Get list of exercises from db
            var exercises = GetExercises(exerciseIds);

            // Calculate trend for each exercise
            foreach (var exercise in exercises)
            {
            }
        }

        private IEnumerable<Exercise> GetExercises(int[] exerciseIds)
        {
            return _context.Exercises
                .Where(exercise => exerciseIds.Contains(exercise.Id))
                .AsNoTracking()
                .ToList();
        }*/
    }
}