package user

import (
	"back/auth"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
)

func AddRoutes(rg *gin.RouterGroup) {
	rg.Use(auth.AuthRequired())

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
}
