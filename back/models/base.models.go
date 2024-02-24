package models

import (
	"time"

	"github.com/google/uuid"
)

type BaseEntity struct {
	ID        uuid.UUID `json:"id,omitempty"`
	CreatedAt time.Time `json:"created,omitempty"`
	UpdatedAt time.Time `json:"updated,omitempty"`
	DeletedAt time.Time `json:"deleted,omitempty"`
}

type CategoryEntity struct {
	*BaseEntity
	Name      string    `json:"name,omitempty"`
	AccountId uuid.UUID `json:"accountId,omitempty"`
}
