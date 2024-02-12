package auth

import (
	"log"
	"net/http"

	"back/models"

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
		var signupData models.SignupDto

		if c.ShouldBind(&signupData) == nil {
			log.Println(signupData.Email)
			log.Println(signupData.Login)
			log.Println(signupData.Password)
		}

		c.JSON(200, signup(&signupData))
	})
}
