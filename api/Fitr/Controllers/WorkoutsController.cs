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
        public async Task<ActionResult<WorkoutDetailDto>> Get(int id)
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
        public async Task<ActionResult<WorkoutExerciseSessionDetailDto>> GetSessions(int workoutId, int exerciseId)
        {
            if (string.IsNullOrEmpty(CurrentUserId))
                return Unauthorized(new { message = $"Unable to fetch exercise sessions for workout with id {workoutId}, no user is currently logged in." });

            if (!await ExerciseIsPartOfProvidedWorkout(exerciseId, workoutId))
                return NotFound(new { message = $"Unable to fetch exercise sessions for workout with id { workoutId}, the exercise with id {exerciseId} is not a part of the provided workout." });

            return Ok(_workoutRepository.GetExerciseSessions(CurrentUserId, workoutId, exerciseId));
        }

        /// <summary>
        /// Toggles the currently active workout
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     PATCH /workout/1
        ///
        /// </remarks>
        /// <returns>The updated workout details</returns>
        /// <response code="200">The updated workout details</response>
        /// <response code="401">If the user is unauthorized</response>  
        [HttpPatch("{workoutId}")]
        public async Task<ActionResult> ToggleActiveWorkout(int workoutId)
        {
            if (string.IsNullOrEmpty(CurrentUserId))
                return Unauthorized(new { message = $"Unable to toggle status for workout with id {workoutId}, no user is currently logged in." });

            await _workoutRepository.ToggleActiveWorkout(CurrentUserId, workoutId);

            return Ok();
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

        /// <summary>
        /// Adds a session to a workout
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /workouts/1/sessions
        ///
        /// </remarks>
        /// <returns>The workout session details</returns>
        /// <response code="200">Returns the workout session details</response>
        /// <response code="401">If the user is unauthorized</response>  
        [HttpPost("{workoutId}/sessions")]
        public async Task<ActionResult<WorkoutSessionDetailDto>> AddSession(int workoutId, WorkoutSessionDetailDto workoutSessionDetailDto)
        {
            if (string.IsNullOrEmpty(CurrentUserId))
                return Unauthorized(new { message = $"Unable to create session for workout with id {workoutId}, no user is currently logged in." });

            if (workoutSessionDetailDto == null)
                return BadRequest(new { message = $"Unable to create session for workout with id {workoutId}, session details are null."});

            return Ok(await _workoutRepository.CreateSession(CurrentUserId, workoutId, workoutSessionDetailDto));
        }

        private async Task<bool> ExerciseIsPartOfProvidedWorkout(int exerciseId, int workoutId)
        {
            var workout = await _workoutRepository.Get(CurrentUserId, workoutId);

            return workout.Exercises.Any(exercise => exercise.Id == exerciseId);
        }
    }
}