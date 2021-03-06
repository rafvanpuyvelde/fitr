﻿using System.Collections.Generic;
using System.Threading.Tasks;
using Fitr.Dtos.Workout;

namespace Fitr.Repositories.Workout
{
    public interface IWorkoutRepository
    {
        Task<WorkoutDetailDto> Get(string currentUserId, int workoutId);
        
        Task<IEnumerable<WorkoutDto>> GetAll(string currentUserId);
        
        Task<WorkoutSessionDetailDto> CreateSession(string currentUserId, int workoutId, WorkoutSessionDetailDto sessionDetail);

        WorkoutExerciseSessionDetailDto GetExerciseSessions(string currentUserId, int workoutId, int exerciseId);

        Task ToggleActiveWorkout(string currentUserId, int workoutId);
    }
}