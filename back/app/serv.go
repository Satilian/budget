package app

import (
	"crypto/tls"
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func Serv(r *gin.Engine) {
	cert, _ := tls.LoadX509KeyPair("ssl/budget_local.crt", "ssl/budget_local.key")

	s := &http.Server{
		Addr:      ":" + os.Getenv("PORT"),
		Handler:   r,
		TLSConfig: &tls.Config{Certificates: []tls.Certificate{cert}},
	}

	if err := s.ListenAndServeTLS("", ""); err != nil {
		fmt.Println(err)
	}
}
