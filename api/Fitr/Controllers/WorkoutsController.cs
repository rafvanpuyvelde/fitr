using System.Collections.Generic;
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
            var currentUserId = GetCurrentUserId();

            if (string.IsNullOrEmpty(currentUserId))
                return Unauthorized(new { message = "Unable to fetch workouts, no user is currently logged in." });

            return Ok(await _workoutRepository.Get(currentUserId, id));
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
            var currentUserId = GetCurrentUserId();

            if (string.IsNullOrEmpty(currentUserId))
                return Unauthorized(new { message = "Unable to fetch workouts, no user is currently logged in." });

            return Ok(await _workoutRepository.GetAll(currentUserId));
        }

        private string GetCurrentUserId()
        {
            return User.Identity?.Name;
        }
    }
}