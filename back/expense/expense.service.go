package expense

import (
	"back/dic"
	"back/models"
	"database/sql"
	"fmt"
	"log"
)

func addExpense(expenseData *models.AddExpenseDto) error {
	log.Println(fmt.Printf("Category:  %v\n", expenseData.Category))
	log.Println(fmt.Printf("Expense:  %v\n", expenseData.Expense))
	log.Println(fmt.Printf("Value:  %v\n", expenseData.Value))

	var err error
	expense := models.Expense{
		Name:  expenseData.Expense,
		Value: expenseData.Value,
	}

	dataSource := dic.Instance.Get("DB").(*sql.DB)
	err = dataSource.QueryRow("SELECT id FROM public.categories WHERE name=$1", expenseData.Category).Scan(&expense.CategoryID)
	if err != nil {
		err = dataSource.QueryRow("INSERT INTO public.categories (name) VALUES($1) returning id", expenseData.Category).Scan(&expense.CategoryID)
	}
	if err == nil {
		log.Println(fmt.Printf("categoryId:  %v\n", expense.CategoryID))
	}

	return err
}
