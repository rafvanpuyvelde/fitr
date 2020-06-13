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

        public async Task<WorkoutSessionDetailDto> CreateSession(string currentUserId, int workoutId, WorkoutSessionDetailDto sessionDetail)
        {
            if (sessionDetail == null) { throw new ArgumentNullException(nameof(sessionDetail)); }

            // Add the sessionDetail to the db
            var newlyCreatedSession = _context.Sessions.Add(new Session { Date = sessionDetail.Date, WorkoutId = sessionDetail.WorkoutId });

            await _context.SaveChangesAsync();

            // Edit the sessionDetail id
            sessionDetail.SessionId = newlyCreatedSession.Entity.Id;

            // Add sessionDetail sets
            foreach (var exercise in sessionDetail.Exercises)
            {
                for (var setIndex = 0; setIndex < exercise.Reps.Length; setIndex++)
                {
                    _context.Sets.Add(new Set
                    {
                        ExerciseId = exercise.ExerciseId,
                        SessionId = sessionDetail.SessionId,
                        Reps = exercise.Reps[setIndex],
                        Weight = exercise.Weight[setIndex],
                        Unit = Enums.Unit.Kg,
                        UsesBands = false,
                        UsesChains = false
                    });
                }
            }

            await _context.SaveChangesAsync();

            return sessionDetail;
        }

        public WorkoutExerciseSessionDetailDto GetExerciseSessions(string currentUserId, int workoutId, int exerciseId)
        {
            var sessions = _context.Sessions
                .Include(s => s.Sets)
                .ThenInclude(s => s.Exercise)
                .Include(s => s.Workout)
                .ThenInclude(w => w.Exercises)
                .Where(s => s.WorkoutId == workoutId);

            var result = new WorkoutExerciseSessionDetailDto
            {
                ExerciseId = exerciseId,
                ExerciseName = _context.Exercises.SingleAsync(exercise => exercise.Id == exerciseId).Result.Name,
                WorkoutId = workoutId,
                WorkoutName = sessions.First().Workout.Name,
                Sessions = new List<WorkoutExerciseSession>()
            };

            foreach (var session in sessions)
            {
                result.Sessions.Add(new WorkoutExerciseSession
                {
                    Date = session.Date,
                    Id = session.Id,
                    Sets = session.Sets.Count,
                    Reps = session.Sets.Where(x => x.ExerciseId == exerciseId).Select(x => x.Reps).ToArray(),
                    Weight = session.Sets.Where(y => y.ExerciseId == exerciseId).Select(y => y.Weight).ToArray()
                });
            }

            return result;
        }

        public async Task ToggleActiveWorkout(string currentUserId, int workoutId)
        {
            _context.Workouts.ToList().ForEach(workout => { workout.IsActive = workout.Id == workoutId; });

            await _context.SaveChangesAsync();
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
                    {
                        performanceDictionary.Add(exercise.Key, set.Reps * set.Weight);
                    }
                    else
                    {
                        performanceDictionary[exercise.Key] = set.Reps * set.Weight + performanceDictionary[exercise.Key];
                    }
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
                        Unit = e.Exercise.Sets.First().Unit.ToString()
                    }).ToList()
                })
                .AsNoTracking()
                .FirstAsync()
                .ConfigureAwait(false);
        }
    }
}