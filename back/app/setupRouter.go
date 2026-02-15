package app

import (
	"back/auth"
	"back/categories"
	"back/expense"
	"back/user"

	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"

	_ "back/docs"
)

var r = gin.Default()

func SetupRouter() *gin.Engine {
	r.Static("/static", "./assets")

	r.Use(gin.Recovery())

	// Swagger documentation
	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	apiGroup := r.Group("/api")

	auth.AddRoutes(apiGroup.Group("/auth"))
	user.AddRoutes(apiGroup.Group("/user"))
	expense.AddRoutes(apiGroup.Group("/expense"))
	categories.AddRoutes(apiGroup.Group("/categories"))

	return r
}
