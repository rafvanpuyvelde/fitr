﻿using Fitr.Dtos.User;
using FluentValidation;

namespace Fitr.Validations
{
    public class UserCreateDtoValidations
    {
        public class UserCreateDtoValidator : AbstractValidator<UserCreateDto>
        {
            public UserCreateDtoValidator()
            {
                RuleFor(x => x.Email).NotEmpty().EmailAddress();
                RuleFor(x => x.LastName).NotEmpty();
                RuleFor(x => x.Name).NotEmpty();
                RuleFor(x => x.UserName).NotEmpty();
                RuleFor(x => x.Password).NotEmpty().Length(6, 25);
            }
        }
    }
}