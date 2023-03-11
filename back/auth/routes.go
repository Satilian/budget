package auth

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

// Добавляет роуты для аутентикации
//
// Принимает в качестве аргументя группу (gin.Engine.Group)
func AddRoutes(rg *gin.RouterGroup) {
	rg.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, "pong")
	})

	rg.POST("/signup", func(c *gin.Context) {
		var signupData SignupDto

		if c.ShouldBind(&signupData) == nil {
			log.Println(signupData.Email)
			log.Println(signupData.Login)
			log.Println(signupData.Pass)
		}

		c.String(http.StatusOK, signup(&signupData))
	})
}
