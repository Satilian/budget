package app

import (
	"back/auth"
	"back/test"

	"github.com/gin-gonic/gin"
)

var r = gin.Default()

func SetupRouter() *gin.Engine {
	r.Static("/assets", "./assets")

	test.AddRoutes(r.Group("/test"))
	auth.AddRoutes(r.Group("/auth"))

	return r
}
