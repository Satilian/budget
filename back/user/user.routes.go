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

	rg.GET("/remove", RemoveAccount)

	rg.GET("/send-remove-link", SendRemoveLink)

	rg.GET("/remove-link", RemoveByLink)
}

// RemoveAccount godoc
// @Summary Delete user account
// @Description Delete the authenticated user's account
// @Tags user
// @Produce json
// @Security Bearer
// @Success 200 {string} string "Account deleted"
// @Failure 401 {string} string "Unauthorized"
// @Router /user/remove [get]
func RemoveAccount(c *gin.Context) {
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
}

// SendRemoveLink godoc
// @Summary Send account deletion link
// @Description Send email with account deletion link
// @Tags user
// @Produce json
// @Param username query string true "User login"
// @Success 200 {string} string "Link sent"
// @Failure 404 {string} string "User not found"
// @Router /user/send-remove-link [get]
func SendRemoveLink(c *gin.Context) {
	var deleteUser models.DeleteUser

	if c.ShouldBind(&deleteUser) == nil {
		if err := sendRemoveLink(deleteUser.Login); err == nil {
			c.Status(http.StatusOK)
		} else {
			c.Status(http.StatusNotFound)
			c.Error(err)
		}
	}
}

// RemoveByLink godoc
// @Summary Delete account via verification link
// @Description Delete account using the verification token from email
// @Tags user
// @Produce json
// @Param token query string true "Verification token"
// @Success 307 {string} string "Redirecting to success page"
// @Failure 404 {string} string "Invalid token"
// @Router /user/remove-link [get]
func RemoveByLink(c *gin.Context) {
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
}
