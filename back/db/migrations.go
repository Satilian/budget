package db

import "back/models"

func autoMigrate() {
	DB.AutoMigrate(&models.User{})
}
