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
}
