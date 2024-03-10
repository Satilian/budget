package categories

import (
	"back/auth"
	"back/models"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
)

func AddRoutes(rg *gin.RouterGroup) {
	rg.Use(auth.AuthRequired())

	rg.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, "pong")
	})

	rg.GET("/find", func(c *gin.Context) {
		claims, ok := c.Get("user")

		if !ok {
			c.Status(http.StatusUnauthorized)
			c.Abort()
		}

		var filter models.CategoryFilter

		if err := c.ShouldBind(&filter); err != nil {
			c.Error(err)
		}

		if categories, err := findCategories(
			claims.(*jwt.StandardClaims).Audience,
			filter,
		); err == nil {
			c.JSON(http.StatusOK, gin.H{"categories": categories})
		} else {
			c.Error(err)
		}
	})
}
