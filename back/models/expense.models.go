package models

import (
	"github.com/google/uuid"
)

type AddExpenseDto struct {
	Category string  `json:"category,omitempty"`
	Expense  string  `json:"expense,omitempty"`
	Value    float32 `json:"value,omitempty"`
}

type ExpenseNameEntity struct {
	BaseEntity
	Name      string    `json:"name,omitempty"`
	AccountId uuid.UUID `json:"accountId,omitempty"`
}

type ExpenseEntity struct {
	BaseEntity
	Value         float32   `json:"value,omitempty"`
	UserId        uuid.UUID `json:"userId,omitempty"`
	AccountId     uuid.UUID `json:"accountId,omitempty"`
	CategoryId    uuid.UUID `json:"categoryId,omitempty"`
	ExpenseNameId uuid.UUID `json:"expenseName,omitempty"`
}
