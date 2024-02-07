package auth

import (
	"back/db"
	"back/models"
	"log"
)

func signup(signupData *models.SignupDto) string {
	user := models.User{
		Login:    signupData.Login,
		Email:    signupData.Email,
		Password: signupData.Pass,
	}
	result := db.DB.Create(&user)

	log.Println(user.Email)

	if result.Error != nil {
		log.Fatal("Create User Error")
	}

	return user.Login
}
