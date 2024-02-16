package models

import (
	"github.com/google/uuid"
)

type AddExpenseDto struct {
	Category string  `json:"category"`
	Expense  string  `json:"expense"`
	Value    float32 `json:"value"`
}

type Expense struct {
	ID         uuid.UUID
	CategoryID uuid.UUID
	UserID     uuid.UUID
	Name       string
	Value      float32
}
