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
	rg.GET("/", HealthCheck)

	rg.POST("/signup", Signup)

	rg.POST("/signin", Signin)
}

// HealthCheck godoc
// @Summary Health check for auth service
// @Description Check if auth service is running
// @Tags auth
// @Produce json
// @Success 200 {string} string "pong"
// @Router /auth [get]
func HealthCheck(c *gin.Context) {
	c.JSON(http.StatusOK, "pong")
}

// Signup godoc
// @Summary Create new account
// @Description Register a new user account
// @Tags auth
// @Accept json
// @Produce json
// @Param signup body models.SignupDto true "Signup data"
// @Success 200 {object} models.User
// @Failure 400 {string} string "Bad request"
// @Router /auth/signup [post]
func Signup(c *gin.Context) {
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
}

// Signin godoc
// @Summary Login to account
// @Description Authenticate user and get JWT token
// @Tags auth
// @Accept json
// @Produce json
// @Param signin body models.SigninDto true "Signin data"
// @Success 200 {object} models.JwtDto
// @Failure 401 {string} string "Unauthorized"
// @Router /auth/signin [post]
func Signin(c *gin.Context) {
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
}
