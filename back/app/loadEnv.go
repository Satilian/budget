package app

import (
	"log"

	"github.com/subosito/gotenv"
)

func LoadEnv() {
	err := gotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
}
