package auth

import (
	"back/dic"
	"back/models"
	"database/sql"
	"log"
)

func signup(signupData *models.SignupDto) models.UserDto {
	user := models.UserDto{
		Login: signupData.Login,
		Email: signupData.Email,
	}
	dataSource := dic.Instance.Get("DB").(*sql.DB)

	err := dataSource.QueryRow("insert into Users (login, email, password) values ($1, $2. %3) returning id, created_at",
		"Huawei", 35000).Scan(&user.ID, &user.CreatedAt)

	if err != nil {
		log.Fatal("Create User Error")
	}

	log.Println(user.ID)

	return user
}
