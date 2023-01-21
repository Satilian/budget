package test

import (
	"back/greetings"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func AddRoutes(rg *gin.RouterGroup) {
	rg.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, "pong")
	})

	rg.GET("/hello", func(c *gin.Context) {
		c.String(http.StatusOK, greetings.Hello("Satilian"))
	})

	rg.GET("/migrate", func(c *gin.Context) {
		c.String(http.StatusOK, migrate())
	})

	rg.GET("/factorial", func(c *gin.Context) {
		type Param struct {
			F int `form:"f" binding:"required"`
		}

		i, err := strconv.Atoi(c.Query("f"))
		if err != nil {
			c.String(http.StatusInternalServerError, err.Error())
		}

		c.String(http.StatusOK, factorial(i))
	})
}
