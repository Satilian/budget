package expense

import (
	"back/auth"
	"back/models"
	"fmt"
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

		if claims, ok := c.Get("user"); ok {
			fmt.Println(claims.(*jwt.StandardClaims).Id)
		}

		if err := c.BindJSON(&expenseData); err != nil {
			c.Error(err)
		}

		if err := addExpense(&expenseData); err == nil {
			c.Status(http.StatusNoContent)
		} else {
			c.Error(err)
		}
	})
}
