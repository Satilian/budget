package app

import (
	"back/auth"
	"back/categories"
	"back/expense"

	"github.com/gin-gonic/gin"
)

var r = gin.Default()

func SetupRouter() *gin.Engine {
	r.Static("/assets", "./assets")

	r.Use(gin.Recovery())

	auth.AddRoutes(r.Group("/auth"))
	expense.AddRoutes(r.Group("/expense"))
	categories.AddRoutes(r.Group("/categories"))

	return r
}
