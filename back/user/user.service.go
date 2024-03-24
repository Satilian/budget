package user

import (
	"back/dic"
	"database/sql"

	"github.com/google/uuid"
)

func remove(_userId string) error {
	var err error
	var userId uuid.UUID
	userId, err = uuid.Parse(_userId)
	if err != nil {
		return err
	}
	dataSource := dic.Instance.Get("DB").(*sql.DB)
	res, err := dataSource.Exec(`UPDATE users SET deleted_at=now() WHERE id=$1`, userId)

	if res != nil {
		res.RowsAffected()
	}

	return err
}
