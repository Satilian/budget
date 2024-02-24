package auth

import (
	"back/dic"
	"back/models"
	"database/sql"
	"fmt"

	"github.com/google/uuid"
)

func signup(signupData *models.SignupDto) (models.UserEntity, error) {
	user := models.UserEntity{
		Login: signupData.Login,
	}

	password, err := HashPassword(signupData.Password)
	if err != nil {
		err = fmt.Errorf("hash password error %w", err)
		return user, err
	}

	dataSource := dic.Instance.Get("DB").(*sql.DB)
	accountErr := dataSource.QueryRow("SELECT id FROM accounts WHERE email=$1", signupData.Email).Scan(&user.AccountId)
	if accountErr != nil {
		err = dataSource.QueryRow("INSERT INTO accounts (email) VALUES($1) returning id", signupData.Email).Scan(&user.AccountId)
	}

	if err != nil {
		err = fmt.Errorf("can't create account %w", err)
		return user, err
	}

	err = dataSource.QueryRow(
		"INSERT INTO users (login, accountId, password) values ($1, $2, $3) returning id, created_at",
		signupData.Login, user.AccountId, password,
	).Scan(&user.ID, &user.CreatedAt)

	if err != nil {
		err = fmt.Errorf("can't create user %w", err)
	}

	return user, err
}

func signin(signinData *models.SigninDto) (models.JwtDto, error) {
	response := models.JwtDto{}
	var hashedPassword string
	var userId uuid.UUID
	var accountId uuid.UUID

	dataSource := dic.Instance.Get("DB").(*sql.DB)
	dataSource.QueryRow(
		"SELECT id, password, accountId FROM users WHERE login=$1",
		signinData.Login).Scan(&userId, &hashedPassword, &accountId)

	if err := VerifyPassword(hashedPassword, signinData.Password); err != nil {
		return response, err
	}

	jwt, err := GenerateToken(map[string]string{
		"login":     signinData.Login,
		"id":        userId.String(),
		"accountId": accountId.String(),
	})

	if err == nil {
		response.Jwt = jwt
	}

	return response, err
}
