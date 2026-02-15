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

	rg.GET("/", HealthCheck)

	rg.GET("/find", FindCategories)
}

// HealthCheck godoc
// @Summary Health check for categories service
// @Description Check if categories service is running
// @Tags categories
// @Produce json
// @Security Bearer
// @Success 200 {string} string "pong"
// @Router /categories [get]
func HealthCheck(c *gin.Context) {
	c.JSON(http.StatusOK, "pong")
}

// FindCategories godoc
// @Summary Find categories
// @Description Get list of categories filtered by name
// @Tags categories
// @Produce json
// @Security Bearer
// @Param name query string false "Category name filter"
// @Success 200 {object} models.CategoriesResponse
// @Failure 401 {string} string "Unauthorized"
// @Router /categories/find [get]
func FindCategories(c *gin.Context) {
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
}
