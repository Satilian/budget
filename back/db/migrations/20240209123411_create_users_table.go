package db

import (
	"back/db"
	"back/models"
	"context"
	"database/sql"

	"github.com/pressly/goose/v3"
)

func init() {
	goose.AddMigrationContext(upCreateUsersTable, downCreateUsersTable)
}

func upCreateUsersTable(ctx context.Context, tx *sql.Tx) error {
	// This code is executed when the migration is applied.
	con, err := db.NewDB()
	if err != nil {
		return err
	}

	return con.Migrator().CreateTable(&models.User{})
}

func downCreateUsersTable(ctx context.Context, tx *sql.Tx) error {
	// This code is executed when the migration is rolled back.
	con, err := db.NewDB()
	if err != nil {
		return err
	}
	return con.Migrator().DropTable(&models.User{})
}
