package expense

import (
	"back/dic"
	"back/models"
	"database/sql"

	"github.com/google/uuid"
)

func addExpense(expenseData *models.AddExpenseDto, userId string, accountId string) (models.ExpenseEntity, error) {
	var err error
	expense := models.ExpenseEntity{
		Value: expenseData.Value,
	}

	if expense.UserId, err = uuid.Parse(userId); err != nil {
		return expense, err
	}
	if expense.AccountId, err = uuid.Parse(accountId); err != nil {
		return expense, err
	}

	dataSource := dic.Instance.Get("DB").(*sql.DB)

	if err = dataSource.QueryRow(
		"SELECT id FROM categories WHERE name=$1",
		expenseData.Category).Scan(&expense.CategoryId); err != nil {
		err = dataSource.QueryRow(
			"INSERT INTO categories (name, accountId) VALUES($1, $2) returning id",
			expenseData.Category, expense.AccountId).Scan(&expense.CategoryId)
	}

	if err != nil {
		return expense, err
	}

	if err = dataSource.QueryRow(
		"SELECT id FROM expense_names WHERE name=$1",
		expenseData.Expense).Scan(&expense.ExpenseNameId); err != nil {
		err = dataSource.QueryRow(
			"INSERT INTO expense_names (name, accountId) VALUES($1, $2) returning id",
			expenseData.Expense, expense.AccountId).Scan(&expense.ExpenseNameId)
	}

	if err == nil {
		err = dataSource.QueryRow(
			`INSERT INTO expense (
				value, userId, accountId, categoryId, expense_nameId
			) VALUES($1, $2, $3, $4, $5) returning id`,
			expense.Value,
			expense.UserId,
			expense.AccountId,
			expense.CategoryId,
			expense.ExpenseNameId,
		).Scan(&expense.ID)
	}

	return expense, err
}
