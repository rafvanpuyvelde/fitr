using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Fitr.Dtos.Workout;
using Fitr.Repositories.Workout;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Fitr.Controllers
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    [Produces("application/json")]
    [Route("api/[controller]")]
    [ApiController]
    public class WorkoutsController : Controller
    {
        private readonly IWorkoutRepository _workoutRepository;

        private string CurrentUserId => User.Identity?.Name;

        public WorkoutsController(IWorkoutRepository workoutRepository)
        {
            _workoutRepository = workoutRepository;
        }

        /// <summary>
        /// Get a Workout by it's id for a given user.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /workout/1
        ///
        /// </remarks>
        /// <returns>The requested workout details</returns>
        /// <response code="200">Returns the workout</response>
        /// <response code="401">If the user is unauthorized</response>  
        [HttpGet("{id}")]
        public async Task<ActionResult<IEnumerable<WorkoutDto>>> Get(int id)
        {
            if (string.IsNullOrEmpty(CurrentUserId))
                return Unauthorized(new { message = $"Unable to fetch workout with id {id}, no user is currently logged in." });

            return Ok(await _workoutRepository.Get(CurrentUserId, id));
        }

        /// <summary>
        /// Gets the Sessions for a given exercise for a given Workout.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /workout/1/exercises/1/sessions
        ///
        /// </remarks>
        /// <returns>The requested workout exercise sessions</returns>
        /// <response code="200">Returns the workout exercise sessions</response>
        /// <response code="401">If the user is unauthorized</response>  
        [HttpGet("{workoutId}/exercises/{exerciseId}/sessions")]
        public async Task<ActionResult<IEnumerable<WorkoutDto>>> GetSessions(int workoutId, int exerciseId)
        {
            if (string.IsNullOrEmpty(CurrentUserId))
                return Unauthorized(new { message = $"Unable to fetch exercise sessions for workout with id {workoutId}, no user is currently logged in." });

            if (!await ExerciseIsPartOfProvidedWorkout(exerciseId, workoutId))
                return NotFound(new { message = $"Unable to fetch exercise sessions for workout with id { workoutId}, the exercise with id {exerciseId} is not a part of the provided workout." });

            return Ok(await _workoutRepository.GetExerciseSessions(CurrentUserId, workoutId, exerciseId));
        }

        /// <summary>
        /// Gets all Workouts for a given user.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     GET /workouts
        ///
        /// </remarks>
        /// <returns>A list of workouts</returns>
        /// <response code="200">Returns the workouts</response>
        /// <response code="401">If the user is unauthorized</response>  
        [HttpGet]
        public async Task<ActionResult<IEnumerable<WorkoutDto>>> GetAll()
        {
            if (string.IsNullOrEmpty(CurrentUserId))
                return Unauthorized(new { message = "Unable to fetch workouts, no user is currently logged in." });

            return Ok(await _workoutRepository.GetAll(CurrentUserId));
        }

        private async Task<bool> ExerciseIsPartOfProvidedWorkout(int exerciseId, int workoutId)
        {
            var workout = await _workoutRepository.Get(CurrentUserId, workoutId);

            return workout.Exercises.Any(exercise => exercise.Id == exerciseId);
        }
    }
}