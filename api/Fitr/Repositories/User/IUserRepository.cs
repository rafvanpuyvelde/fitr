using System.Threading.Tasks;
using Fitr.Dtos.User;

namespace Fitr.Repositories.User
{
    public interface IUserRepository
    {
        Task<UserDto> Get(string id);
        
        Task<UserDto> Create(UserCreateDto user);
        Task<bool> UserAlreadyExists(UserCreateDto userPostDto);
    }
}