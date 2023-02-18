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
		type HelloData struct {
			Name string `form:"name"`
			Age  int    `form:"age"`
		}

		var helloData HelloData

		if c.ShouldBind(&helloData) == nil {
			c.String(http.StatusOK, greetings.Hello(helloData.Name, helloData.Age))
		}
	})

	rg.GET("/migrate", func(c *gin.Context) {
		c.String(http.StatusOK, migrate())
	})

	rg.GET("/factorial", func(c *gin.Context) {
		i, err := strconv.Atoi(c.Query("f"))
		if err != nil {
			c.String(http.StatusInternalServerError, err.Error())
		}

		c.String(http.StatusOK, factorial(i))
	})
}
