package main

import (
	"back/greetings"
	"crypto/tls"
	"fmt"
	"html/template"
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

type SignupData struct {
	Email string `from:"email"`
	Login string `from:"login"`
	Pass  string `from:"pass"`
}

var html = template.Must(template.New("https").Parse(`
<html>
<head>
  <title>Https Test</title>
  <script src="/assets/app.js"></script>
</head>
<body>
  <h1 style="color:red;">Welcome, Ginner!</h1>
</body>
</html>
`))

func setupRouter() *gin.Engine {
	r := gin.Default()
	r.SetHTMLTemplate(html)
	r.Static("/assets", "./assets")

	r.GET("/", func(c *gin.Context) {
		if pusher := c.Writer.Pusher(); pusher != nil {
			if err := pusher.Push("/assets/app.js", nil); err != nil {
				log.Printf("Failed to push: %v", err)
			}
		}

		c.HTML(200, "https", gin.H{
			"status": "success",
		})
	})

	r.GET("/hello", func(c *gin.Context) {
		c.String(http.StatusOK, greetings.Hello("Satilian"))
	})

	r.POST("/signup", func(c *gin.Context) {
		var signupData SignupData

		if c.ShouldBind(&signupData) == nil {
			log.Println(signupData.Email)
			log.Println(signupData.Login)
			log.Println(signupData.Pass)
		}

		c.String(http.StatusOK, signupData.Login)
	})

	r.GET("/factorial", func(c *gin.Context) {
		type Param struct {
			F int `form:"f" binding:"required"`
		}

		i, err := strconv.Atoi(c.Query("f"))
		if err != nil {
			c.String(http.StatusInternalServerError, err.Error())
		}

		c.String(http.StatusOK, factorial(i))
	})

	r.GET("/send", func(c *gin.Context) {
		type Param struct {
			A string `form:"a" binding:"required"`
			B int    `form:"b" binding:"required"`
		}

		c.JSON(200, gin.H{
			"a": c.Query("a"),
			"b": c.Query("b"),
		})
	})

	return r
}

func main() {
	r := setupRouter()
	cert, _ := tls.LoadX509KeyPair("ssl/budget_local.crt", "ssl/budget_local.key")

	s := &http.Server{
		Addr:      ":8080",
		Handler:   r,
		TLSConfig: &tls.Config{Certificates: []tls.Certificate{cert}},
	}

	if err := s.ListenAndServeTLS("", ""); err != nil {
		fmt.Println(err)
	}
}
