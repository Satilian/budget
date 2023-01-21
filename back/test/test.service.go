package test

import (
	"fmt"

	"gorm.io/driver/postgres"

	"gorm.io/gorm"
)

type service struct {
}

type Product struct {
	gorm.Model
	Code  string
	Price uint
}

func migrate() string {
	dsn := "host=localhost user=postgres password=1zad2bulki dbname=budget port=5432 sslmode=disable"
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		panic("failed to connect database")
	}

	db.AutoMigrate(&Product{})
	return fmt.Sprintf("test service")
}
