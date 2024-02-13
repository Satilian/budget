package auth

import (
	"back/dic"
	"back/models"
	"database/sql"
	"fmt"
)

func signup(signupData *models.SignupDto) (models.UserDto, error) {
	user := models.UserDto{
		Login: signupData.Login,
		Email: signupData.Email,
	}

	password, err := HashPassword(signupData.Password)
	if err != nil {
		return user, err
	}

	dataSource := dic.Instance.Get("DB").(*sql.DB)
	err = dataSource.QueryRow("insert into Users (login, email, password) values ($1, $2, $3) returning id, created_at",
		signupData.Login, signupData.Email, password).Scan(&user.ID, &user.CreatedAt)

	if err != nil {
		err = fmt.Errorf("can't create user %w", err)
	}

	return user, err
}

func signin(signinData *models.SigninDto) (models.JwtDto, error) {
	response := models.JwtDto{}
	var hashedPassword string

	dataSource := dic.Instance.Get("DB").(*sql.DB)
	dataSource.QueryRow("SELECT password FROM public.users WHERE login=$1", signinData.Login).Scan(&hashedPassword)

	candidatePassword, err := HashPassword(signinData.Password)
	err = VerifyPassword(hashedPassword, candidatePassword)

	var jwt string
	jwt, err = GenerateToken(map[string]string{"login": signinData.Login})

	if err == nil {
		response.Jwt = jwt
	}

	return response, err
}
