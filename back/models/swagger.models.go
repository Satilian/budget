package models

// CategoriesResponse represents the response for categories endpoint
// @Description Categories response with list of categories
type CategoriesResponse struct {
	Categories []CategoryDto `json:"categories"`
}

// ExpenseNamesResponse represents the response for expense names endpoint
// @Description Expense names response with list of names
type ExpenseNamesResponse struct {
	Names []ExpenseNameDto `json:"names"`
}

// ExpenseItemsResponse represents the response for expense items endpoint
// @Description Expense items response with list of items
type ExpenseItemsResponse struct {
	Items []ExpenseItemDto `json:"items"`
}

// ExpenseCategoriesResponse represents the response for expense categories endpoint
// @Description Expense categories response with list of categories and values
type ExpenseCategoriesResponse struct {
	Expense []ExpenseCategoryDto `json:"expense"`
}
