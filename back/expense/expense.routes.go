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

	rg.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, "pong")
	})

	rg.POST("/add", func(c *gin.Context) {
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
	})

	rg.GET("/categories", func(c *gin.Context) {
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
	})

	rg.GET("/names", func(c *gin.Context) {
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
	})

	rg.GET("/items", func(c *gin.Context) {
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
	})
}
