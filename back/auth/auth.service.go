package auth

import (
	"back/dic"
	"back/models"
	"log"

	"gorm.io/gorm"
)

func signup(signupData *models.SignupDto) models.User {
	user := models.User{
		Login:    signupData.Login,
		Email:    signupData.Email,
		Password: signupData.Pass,
	}
	repo := dic.Instance.Get("DB").(*gorm.DB)
	result := repo.Create(&user)

	log.Println(user.ID)

	if result.Error != nil {
		log.Fatal("Create User Error")
	}

	return user
}
