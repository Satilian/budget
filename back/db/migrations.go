package db

import "back/auth"

func autoMigrate() {
	DB.AutoMigrate(&auth.User{})
}
