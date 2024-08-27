package app

import (
	"log"
	"os"

	"github.com/subosito/gotenv"
)

func LoadEnv() {
	file := "../.env.dev"
	if len(os.Args) > 1 && os.Args[1] == "prod" {
		file = ".env"
	}

	if err := gotenv.Load(file); err != nil {
		log.Fatalf("Error loading %v file", file)
	}
}
