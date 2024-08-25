package user

import (
	"back/auth"
	"back/dic"
	"back/mail"
	"database/sql"
	"fmt"
	"os"

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

func sendRemoveLink(login string) error {
	o := mail.SendMailOptions{}
	var userId uuid.UUID
	var accountId uuid.UUID

	dataSource := dic.Instance.Get("DB").(*sql.DB)
	err := dataSource.QueryRow(`
		SELECT accounts.id, email, users.id as userId
		FROM accounts
		LEFT JOIN users ON accounts.id = users.accountid 
		WHERE users.login=$1
	`, login).Scan(&accountId, &o.To, &userId)

	if err != nil {
		return err
	}

	jwt, jwtErr := auth.GenerateToken(map[string]string{
		"login":     login,
		"id":        userId.String(),
		"accountId": accountId.String(),
	})

	if jwtErr != nil {
		return jwtErr
	}

	o.Subject = "Request to Delete Your Account"
	o.Template = "delete-user"
	o.Data = struct {
		Name string
		Link string
	}{login, fmt.Sprintf("%v/api/user/remove-link?token=%v", os.Getenv("HOST"), jwt)}

	sendErr := mail.SendMail(o)

	if sendErr != nil {
		return sendErr
	}

	return nil
}

func removeByLink(token string) error {
	claims, err := auth.ValidateToken(token)

	if err != nil {
		return err
	}

	return remove(claims.Id)
}
