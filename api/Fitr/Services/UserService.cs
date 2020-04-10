using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Fitr.Dtos.User;
using Fitr.Helpers;
using Fitr.Models;
using Fitr.Repositories.User;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;

namespace Fitr.Services
{
    public class UserService : IUserService
    {
        private readonly AppSettings _appSettings;
        private readonly SignInManager<User> _signInManager;
        private readonly UserManager<User> _userManager;
        private readonly IUserRepository _userRepository;
        
        public UserService(IOptions<AppSettings> appSettings, SignInManager<User> signInManager, UserManager<User> userManager, IUserRepository userRepository)
        {
            _appSettings = appSettings.Value;
            _signInManager = signInManager;
            _userManager = userManager;
            _userRepository = userRepository;
        }
        
        public async Task<UserDto> Authenticate(string userName, string password)
        {
            var user = await _userManager.FindByNameAsync(userName).ConfigureAwait(false);

            // return null if user not found
            if (user == null)
            {
                return null;
            }

            var result = await _signInManager.CheckPasswordSignInAsync(user, password, lockoutOnFailure: false).ConfigureAwait(false);

            // return null if user failed to authenticate
            if (!result.Succeeded)
            {
                return null;
            }

            var tokenHandler = GetNewJwtSecurityToken(user, out var token);
            var userDto = await _userRepository.Get(user.Id).ConfigureAwait(false);
            userDto.Token = tokenHandler.WriteToken(token);

            return userDto;
        }

        private JwtSecurityTokenHandler GetNewJwtSecurityToken(User user, out SecurityToken token)
        {
            // authentication successful so generate jwt token
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Id)
                }),
                Expires = DateTime.UtcNow.AddMinutes(60),
                SigningCredentials =
                    new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler;
        }
    }
}