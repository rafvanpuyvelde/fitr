using System.Threading.Tasks;
using Fitr.Dtos.User;

namespace Fitr.Services
{
    public interface IUserService
    {
        Task<UserDto> Authenticate(string username, string password);
    }
}