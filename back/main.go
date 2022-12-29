package main

import (
	"back/greetings"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func setupRouter() *gin.Engine {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, greetings.Hello("Max"))
	})

	r.GET("/factorial", func(c *gin.Context) {
		type Param struct {
			F int `form:"f" binding:"required"`
		}

		i, err := strconv.Atoi(c.Query("f"))
		if err != nil {
			c.String(http.StatusInternalServerError, err.Error())
		}

		c.String(http.StatusOK, factorial(i))
	})

	r.GET("/send", func(c *gin.Context) {
		type Param struct {
			A string `form:"a" binding:"required"`
			B int    `form:"b" binding:"required"`
		}

		c.JSON(200, gin.H{
			"a": c.Query("a"),
			"b": c.Query("b"),
		})
	})

	return r
}

func main() {
	r := setupRouter()
	r.Run()
}
