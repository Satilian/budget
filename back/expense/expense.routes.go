package expense

import (
	"back/models"
	"net/http"

	"github.com/gin-gonic/gin"
)

func AddRoutes(rg *gin.RouterGroup) {
	rg.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, "pong")
	})

	rg.POST("/add", func(c *gin.Context) {
		var expenseData models.AddExpenseDto

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
