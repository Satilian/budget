package auth

import (
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
			c.Status(http.StatusBadRequest)
			c.Error(err)
		}

		if newUser, err := signup(&signupData); err == nil {
			c.JSON(http.StatusOK, newUser)
		} else {
			c.Status(http.StatusBadRequest)
			c.Error(err)
		}
	})

	rg.POST("/signin", func(c *gin.Context) {
		var signinData models.SigninDto

		if err := c.BindJSON(&signinData); err != nil {
			c.Status(http.StatusBadRequest)
			c.Error(err)
		}

		if response, err := signin(&signinData); err == nil {
			c.JSON(http.StatusOK, response)
		} else {
			c.Status(http.StatusUnauthorized)
			c.Error(err)
		}
	})
}
