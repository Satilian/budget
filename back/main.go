package main

import (
	"back/app"
	"crypto/tls"
	"fmt"
	"net/http"
)

func main() {
	r := app.SetupRouter()

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
