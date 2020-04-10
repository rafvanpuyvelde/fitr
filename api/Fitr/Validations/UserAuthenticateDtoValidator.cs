using Fitr.Dtos.User;
using FluentValidation;

namespace Fitr.Validations
{
    public class UserAuthenticateDtoValidator : AbstractValidator<UserAuthenticateDto>
    {
        public UserAuthenticateDtoValidator()
        {
            RuleFor(x => x.UserName).NotEmpty();
            RuleFor(x => x.Password).NotEmpty().Length(6, 25);
        }
    }
}