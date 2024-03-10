package expense

import (
	"back/dic"
	"back/models"
	"database/sql"
	"fmt"

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

func getExpenseCategories(userId string, accountId string) ([]models.ExpenseCategoryDto, error) {
	expense := []models.ExpenseCategoryDto{}

	dataSource := dic.Instance.Get("DB").(*sql.DB)

	rows, err := dataSource.Query(`
		SELECT categories.id, categories.name, SUM(expense.value) as value 
		FROM expense 
		LEFT JOIN categories ON categories.id = expense.categoryid 
		WHERE expense.accountid=$1
		GROUP BY categories.id, categories.name
	`, accountId)

	if err != nil {
		return expense, err
	}

	defer rows.Close()

	for rows.Next() {
		e := models.ExpenseCategoryDto{}
		err := rows.Scan(&e.ID, &e.Name, &e.Value)
		if err != nil {
			fmt.Println(err)
			continue
		}
		expense = append(expense, e)
	}

	return expense, err
}

func getExpenseNames(
	accountId string,
	filter models.ExpenseNameFilter,
) ([]models.ExpenseNameDto, error) {
	names := []models.ExpenseNameDto{}

	dataSource := dic.Instance.Get("DB").(*sql.DB)

	rows, err := dataSource.Query(`
		SELECT id, name 
		FROM expense_names
		WHERE accountId=$1
		AND LOWER(name) LIKE LOWER($2 || '%')
		ORDER BY name ASC`,
		accountId,
		filter.Name,
	)

	if err != nil {
		return names, err
	}

	defer rows.Close()

	for rows.Next() {
		n := models.ExpenseNameDto{}
		err := rows.Scan(&n.ID, &n.Name)
		if err != nil {
			fmt.Println(err)
			continue
		}
		names = append(names, n)
	}

	return names, err
}

func getExpenseItems(
	accountId string,
	filter models.ExpenseItemFilter,
) ([]models.ExpenseItemDto, error) {
	expense := []models.ExpenseItemDto{}

	dataSource := dic.Instance.Get("DB").(*sql.DB)

	rows, err := dataSource.Query(`
		SELECT expense_names.id, expense_names.name, SUM(expense.value) as value 
		FROM expense 
		LEFT JOIN expense_names ON expense_names.id = expense.expense_nameId 
		WHERE expense.accountid=$1
		AND expense.categoryid=$2
		GROUP BY expense_names.id
	`, accountId, filter.CategoryId)

	if err != nil {
		return expense, err
	}

	defer rows.Close()

	for rows.Next() {
		e := models.ExpenseItemDto{}
		err := rows.Scan(&e.ID, &e.Name, &e.Value)
		if err != nil {
			fmt.Println(err)
			continue
		}
		expense = append(expense, e)
	}

	return expense, err
}
