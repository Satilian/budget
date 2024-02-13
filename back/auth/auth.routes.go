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

		if err := c.BindJSON(&signupData); err != nil {
			c.Error(err)
		} else {
			log.Println(signupData.Email)
			log.Println(signupData.Login)
			log.Println(signupData.Password)
		}

		if newUser, err := signup(&signupData); err == nil {
			c.JSON(200, newUser)
		} else {
			c.Error(err)
		}
	})
}
