package auth

import (
	"time"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	ID               uuid.UUID `gorm:"type:uuid;primary_key"`
	Login            string    `gorm:"type:varchar(255);not null"`
	Email            string    `gorm:"type:varchar(255);not null;uniqueIndex"`
	Password         string    `gorm:"type:varchar(255);not null"`
	Role             string    `gorm:"type:varchar(255);not null"`
	VerificationCode string
	Verified         bool `gorm:"not null"`
}

type SignupDto struct {
	Email string `from:"email"`
	Login string `from:"login"`
	Pass  string `from:"pass"`
}

type SigninDto struct {
	Email string `from:"email"`
	Pass  string `from:"pass"`
}

type UserDto struct {
	ID        uuid.UUID `json:"id,omitempty"`
	Login     string    `json:"name,omitempty"`
	Email     string    `json:"email,omitempty"`
	Role      string    `json:"role,omitempty"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}
