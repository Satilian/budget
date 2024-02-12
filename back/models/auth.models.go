package models

import (
	"time"

	"github.com/google/uuid"
)

type SigninDto struct {
	Login    string `form:"login"`
	Password string `form:"pass"`
}

type SignupDto struct {
	SigninDto
	Email string `form:"email"`
}

type User struct {
	SignupDto
	ID uuid.UUID
}

type UserDto struct {
	ID        uuid.UUID `json:"id,omitempty"`
	Login     string    `json:"name,omitempty"`
	Email     string    `json:"email,omitempty"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}
