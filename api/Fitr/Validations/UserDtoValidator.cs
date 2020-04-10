using Fitr.Dtos.User;
using FluentValidation;

namespace Fitr.Validations
{
    public class UserDtoValidator : AbstractValidator<UserDto>
    {
        public UserDtoValidator()
        {
            RuleFor(x => x.Email).NotEmpty().EmailAddress();
            RuleFor(x => x.LastName).NotEmpty();
            RuleFor(x => x.Name).NotEmpty();
            RuleFor(x => x.UserName).NotEmpty();
        }
    }
}