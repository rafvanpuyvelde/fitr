using System;
using System.Linq;
using System.Threading.Tasks;
using Fitr.Data;
using Fitr.Dtos.User;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Fitr.Repositories.User
{
    public class UserRepository : IUserRepository
    {
        private readonly FitrContext _context;
        private readonly UserManager<Models.User> _userManager;
        
        public UserRepository(FitrContext context, UserManager<Models.User> userManager)
        {
            _context = context;
            _userManager = userManager;
        }
        
        public async Task<UserDto> Get(string id)
        {
            var user = await _context.Users
                .Select(i => new UserDto()
                {
                    Id = i.Id,
                    Name = i.Name,
                    LastName = i.LastName,
                    UserName = i.UserName,
                    Email = i.Email
                })
                .AsNoTracking()
                .FirstOrDefaultAsync(r => r.Id == id)
                .ConfigureAwait(false);

            return user;
        }

        public async Task<UserDto> Create(UserCreateDto userPostDto)
        {
            if (userPostDto == null) { throw new ArgumentNullException(nameof(userPostDto)); }

            var user = new Models.User
            {
                Name = userPostDto.Name,
                LastName = userPostDto.LastName,
                Email = userPostDto.Email,
                UserName = userPostDto.UserName
            };

            await _userManager.CreateAsync(user, userPostDto.Password).ConfigureAwait(false);

            var userDto = new UserDto
            {
                Id = user.Id,
                Name = user.Name,
                LastName = user.LastName,
                Email = user.Email,
                UserName = user.UserName
            };

            return userDto;
        }

        public async Task<bool> UserAlreadyExists(UserCreateDto userPostDto)
        {
            return await _context.Users.AnyAsync(u => u.Email == userPostDto.Email || u.UserName == userPostDto.UserName);
        }
    }
}