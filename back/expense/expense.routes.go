package expense

import (
	"back/auth"
	"back/models"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
)

func AddRoutes(rg *gin.RouterGroup) {
	rg.Use(auth.AuthRequired())

	rg.GET("/", HealthCheck)

	rg.POST("/add", AddExpense)

	rg.GET("/categories", GetExpenseCategories)

	rg.GET("/names", GetExpenseNames)

	rg.GET("/items", GetExpenseItems)
}

// HealthCheck godoc
// @Summary Health check for expense service
// @Description Check if expense service is running
// @Tags expense
// @Produce json
// @Security Bearer
// @Success 200 {string} string "pong"
// @Router /expense [get]
func HealthCheck(c *gin.Context) {
	c.JSON(http.StatusOK, "pong")
}

// AddExpense godoc
// @Summary Add new expense
// @Description Create a new expense entry
// @Tags expense
// @Accept json
// @Produce json
// @Security Bearer
// @Param expense body models.AddExpenseDto true "Expense data"
// @Success 200 {object} models.ExpenseEntity
// @Failure 401 {string} string "Unauthorized"
// @Router /expense/add [post]
func AddExpense(c *gin.Context) {
	var expenseData models.AddExpenseDto
	claims, ok := c.Get("user")

	if !ok {
		c.Status(http.StatusUnauthorized)
		c.Abort()
	}

	if err := c.BindJSON(&expenseData); err != nil {
		c.Error(err)
	}

	if expense, err := addExpense(
		&expenseData,
		claims.(*jwt.StandardClaims).Id,
		claims.(*jwt.StandardClaims).Audience,
	); err == nil {
		c.JSON(http.StatusOK, expense)
	} else {
		c.Error(err)
	}
}

// GetExpenseCategories godoc
// @Summary Get expense categories summary
// @Description Get summary of expenses grouped by categories
// @Tags expense
// @Produce json
// @Security Bearer
// @Success 200 {object} models.ExpenseCategoriesResponse
// @Failure 401 {string} string "Unauthorized"
// @Router /expense/categories [get]
func GetExpenseCategories(c *gin.Context) {
	claims, ok := c.Get("user")

	if !ok {
		c.Status(http.StatusUnauthorized)
		c.Abort()
	}
	if expense, err := getExpenseCategories(
		claims.(*jwt.StandardClaims).Id,
		claims.(*jwt.StandardClaims).Audience,
	); err == nil {
		c.JSON(http.StatusOK, gin.H{"expense": expense})
	} else {
		c.Error(err)
	}
}

// GetExpenseNames godoc
// @Summary Get expense names
// @Description Get list of expense names filtered by name
// @Tags expense
// @Produce json
// @Security Bearer
// @Param name query string false "Expense name filter"
// @Success 200 {object} models.ExpenseNamesResponse
// @Failure 401 {string} string "Unauthorized"
// @Router /expense/names [get]
func GetExpenseNames(c *gin.Context) {
	claims, ok := c.Get("user")

	if !ok {
		c.Status(http.StatusUnauthorized)
		c.Abort()
	}

	var filter models.ExpenseNameFilter

	if err := c.ShouldBind(&filter); err != nil {
		c.Error(err)
	}

	if names, err := getExpenseNames(
		claims.(*jwt.StandardClaims).Audience,
		filter,
	); err == nil {
		c.JSON(http.StatusOK, gin.H{"names": names})
	} else {
		c.Error(err)
	}
}

// GetExpenseItems godoc
// @Summary Get expense items by category
// @Description Get list of expenses filtered by category
// @Tags expense
// @Produce json
// @Security Bearer
// @Param categoryId query string true "Category ID (UUID)"
// @Success 200 {object} models.ExpenseItemsResponse
// @Failure 401 {string} string "Unauthorized"
// @Router /expense/items [get]
func GetExpenseItems(c *gin.Context) {
	claims, ok := c.Get("user")

	if !ok {
		c.Status(http.StatusUnauthorized)
		c.Abort()
	}

	var filter models.ExpenseItemFilter

	if err := c.ShouldBind(&filter); err != nil {
		c.Error(err)
	}

	if items, err := getExpenseItems(
		claims.(*jwt.StandardClaims).Audience,
		filter,
	); err == nil {
		c.JSON(http.StatusOK, gin.H{"items": items})
	} else {
		c.Error(err)
	}
}
