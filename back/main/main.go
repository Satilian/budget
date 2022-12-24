package main

import (
	"net/http"

	"github.com/gin-gonic/gin"

	"greetings"
)

func setupRouter() *gin.Engine {
	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, greetings.Hello("Max"))
	})

	r.GET("/make-file", func(c *gin.Context) {
		greetings.MakeFile()
		c.String(http.StatusOK, "file crated")
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
