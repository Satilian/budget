package auth

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

func AuthRequired() gin.HandlerFunc {
	return func(c *gin.Context) {
		claims, err := ValidateToken(c.GetHeader("Authorization"))

		if err != nil {
			fmt.Println(err)
			c.Status(http.StatusUnauthorized)
			c.Abort()
			return
		}

		c.Set("user", claims)

		c.Next()
	}
}
