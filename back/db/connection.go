package db

import (
	"database/sql"
	"fmt"
	"os"

	_ "github.com/lib/pq"
)

// NewDB - Get gorm DB instance.
func NewDB() (*sql.DB, error) {
	dsn := fmt.Sprintf(
		"host=%v user=%v password=%v dbname=%v port=%v sslmode=disable",
		os.Getenv("DB_HOST"),
		os.Getenv("DB_USER"),
		os.Getenv("DB_PASSWORD"),
		os.Getenv("DB_DBNAME"),
		os.Getenv("DB_PORT"),
	)

	return sql.Open("postgres", dsn)
}
