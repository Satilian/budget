package user

import (
	"back/auth"
	"fmt"
	"net/http"
	"os"

	"back/models"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
)

func AddRoutes(rg *gin.RouterGroup) {
	rg.Use(auth.AuthNotRequired())

	rg.GET("/remove", func(c *gin.Context) {
		claims, ok := c.Get("user")

		if !ok {
			c.Status(http.StatusUnauthorized)
			c.Abort()
		}

		if err := remove(claims.(*jwt.StandardClaims).Id); err == nil {
			c.Status(http.StatusOK)
		} else {
			c.Status(http.StatusUnauthorized)
			c.Error(err)
		}
	})

	rg.GET("/send-remove-link", func(c *gin.Context) {
		var deleteUser models.DeleteUser

		if c.ShouldBind(&deleteUser) == nil {
			if err := sendRemoveLink(deleteUser.Login); err == nil {
				c.Status(http.StatusOK)
			} else {
				c.Status(http.StatusNotFound)
				c.Error(err)
			}
		}
	})

	rg.GET("/remove-link", func(c *gin.Context) {
		var removeDto models.RemoveByLinkDto

		if c.ShouldBind(&removeDto) == nil {
			if err := removeByLink(removeDto.Token); err == nil {
				if value := os.Getenv("DEV_WEB_HOST"); len(value) != 0 {
					c.Redirect(307, fmt.Sprintf("%v/user-delete?state=fullfilled", value))
				} else {
					c.Redirect(307, fmt.Sprintf("%v/user-delete?state=fullfilled", os.Getenv("HOST")))
				}
			} else {
				c.Status(http.StatusNotFound)
				c.Error(err)
			}
		}
	})
}
