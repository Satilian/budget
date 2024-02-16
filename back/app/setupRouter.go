package app

import (
	"back/auth"
	"back/expense"
	"back/test"

	"github.com/gin-gonic/gin"
)

var r = gin.Default()

func SetupRouter() *gin.Engine {
	r.Static("/assets", "./assets")

	r.Use(gin.Recovery())

	test.AddRoutes(r.Group("/test"))
	auth.AddRoutes(r.Group("/auth"))
	expense.AddRoutes(r.Group("/expense"))

	return r
}
