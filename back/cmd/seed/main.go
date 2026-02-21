package main

import (
	"flag"
	"log"
	"os"

	"back/app"
	"back/db"
)

func main() {
	// Определяем флаги командной строки
	seedCmd := flag.Bool("seed", false, "Seed database with mock data")
	cleanCmd := flag.Bool("clean", false, "Clean mock data from database")
	flag.Parse()

	// Загружаем переменные окружения
	app.LoadEnv()

	// Подключаемся к БД
	database, err := db.NewDB()
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer database.Close()

	// Обработка команд
	if *seedCmd {
		log.Println("Seeding database with mock data...")
		if err := db.SeedMockData(database); err != nil {
			log.Fatalf("Failed to seed database: %v", err)
		}
		log.Println("Database seeded successfully!")
		os.Exit(0)
	}

	if *cleanCmd {
		log.Println("Cleaning mock data from database...")
		if err := db.CleanMockData(database); err != nil {
			log.Fatalf("Failed to clean database: %v", err)
		}
		log.Println("Mock data cleaned successfully!")
		os.Exit(0)
	}

	// Если команды не указаны, запускаем обычное приложение
	log.Println("Starting application...")
	// Здесь должна быть логика запуска вашего приложения
	// Например: app.Start(database)
}
