using System;
using System.Threading.Tasks;
using Fitr.Dtos.User;
using Fitr.Repositories.User;
using Fitr.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Fitr.Controllers
{
    [Authorize(AuthenticationSchemes = "Bearer")]
    [Produces("application/json")]
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : Controller
    {
        private readonly IUserRepository _userRepository;
        private readonly IUserService _userService;

        public UsersController(IUserRepository userRepository, IUserService userService)
        {
            _userRepository = userRepository;
            _userService = userService;
        }

        /// <summary>
        /// Get the details of a specified user
        /// </summary>
        /// <param name="id"></param> 
        [HttpGet("{id}")]
        public async Task<ActionResult<UserDto>> Get(string id)
        {
            var userDto = await _userRepository.Get(id).ConfigureAwait(false);

            if (userDto == null)
            {
                return NotFound();
            }

            return userDto;
        }

        /// <summary>
        /// Create a new user.
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /users
        ///     {
        ///         "name": "Jane",
        ///         "lastName": "Doe",
        ///         "userName": "JaneDoe123",
        ///         "email": "jane.doe@test.com",
        ///         "password": "Azerty123_"
        ///     }
        ///
        /// </remarks>
        /// <returns>The newly created user</returns>
        /// <response code="201">Returns the created user</response>
        /// <response code="400">If the item is null</response> 
        [AllowAnonymous, HttpPost]
        public async Task<ActionResult<UserDto>> Create(UserCreateDto userPostDto)
        {
            if (await _userRepository.UserAlreadyExists(userPostDto))
                return BadRequest(new { message = "A user with the provided email address and/or username already exists." });

            var userResult = await _userRepository.Create(userPostDto).ConfigureAwait(false);

            if (userResult == null)
            {
                return BadRequest(new { message = "Registration failed" });
            }

            var userAuthenticateDto = new UserAuthenticateDto
            {
                UserName = userPostDto.UserName,
                Password = userPostDto.Password
            };

            return await Authenticate(userAuthenticateDto).ConfigureAwait(false);
        }

        /// <summary>
        /// Authenticates a user
        /// </summary>
        /// <remarks>
        /// Sample request:
        ///
        ///     POST /api/users/authenticate
        ///     {
        ///	        "Username": "RafVanpuyvelde",
        ///	        "Password": "p@ssword123"
        ///     }
        ///
        /// </remarks>
        /// <param name="userAuthenticateDto"></param>
        [AllowAnonymous, HttpPost("authenticate")]
        public async Task<ActionResult<UserDto>> Authenticate(UserAuthenticateDto userAuthenticateDto)
        {
            if (userAuthenticateDto == null) { throw new ArgumentNullException(nameof(userAuthenticateDto)); }

            var userResult = await _userService.Authenticate(userAuthenticateDto.UserName, userAuthenticateDto.Password).ConfigureAwait(false);

            if (userResult == null)
            {
                return BadRequest(new { message = "Username or password is incorrect" });
            }

            return CreatedAtAction("Get", new { id = userResult.Id }, userResult);
        }
    }
}