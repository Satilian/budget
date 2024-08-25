package models

import (
	"github.com/google/uuid"
)

type SigninDto struct {
	Login    string `form:"login"`
	Password string `form:"pass" json:"pass"`
}

type SignupDto struct {
	SigninDto
	Email string `form:"email"`
}

type User struct {
	SignupDto
	ID uuid.UUID
}

type JwtDto struct {
	Jwt string `json:"jwt"`
}

type AccountEntity struct {
	BaseEntity
	Email string `json:"email,omitempty"`
}

type UserEntity struct {
	BaseEntity
	Login     string    `json:"login,omitempty"`
	AccountId uuid.UUID `json:"accountId,omitempty"`
	Password  string    `json:"password,omitempty"`
}

type DeleteUser struct {
	Login string `form:"username"`
}

type RemoveByLinkDto struct {
	Token string `form:"token"`
}
