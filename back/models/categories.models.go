package models

import "github.com/google/uuid"

type CategoryEntity struct {
	*BaseEntity
	Name      string    `json:"name,omitempty"`
	AccountId uuid.UUID `json:"accountId,omitempty"`
}

type CategoryDto struct {
	ID   uuid.UUID `json:"id,omitempty"`
	Name string    `json:"name,omitempty"`
}

type CategoryFilter struct {
	Name string `form:"name"`
}
