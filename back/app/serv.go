package app

import (
	"context"
	"crypto/tls"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/gin-gonic/gin"
)

func Serv(r *gin.Engine) {
	var s *http.Server
	if len(os.Args) > 1 && os.Args[1] == "prod" {
		s = &http.Server{
			Addr:    ":" + os.Getenv("PORT"),
			Handler: r,
		}

		go func() {
			if err := s.ListenAndServe(); err != nil {
				log.Fatalf("listen: %s\n", err)
			}
		}()
	} else {
		cert, err := tls.LoadX509KeyPair("ssl/budget.local.pem", "ssl/budget.local-key.pem")
		if err != nil {
			log.Fatalf("Failed to load TLS certificates: %v\n", err)
		}

		s = &http.Server{
			Addr:      ":" + os.Getenv("PORT"),
			Handler:   r,
			TLSConfig: &tls.Config{Certificates: []tls.Certificate{cert}},
		}

		go func() {
			log.Printf("Server is running at https://%s:%s/\n", os.Getenv("HOST"), os.Getenv("PORT"))
			if err := s.ListenAndServeTLS("", ""); err != nil {
				log.Fatalf("listen: %s\n", err)
			}
		}()
	}

	quit := make(chan os.Signal)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit
	log.Println("Shutdown Server ...")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	if err := s.Shutdown(ctx); err != nil {
		log.Fatal("Server Shutdown:", err)
	}

	select {
	case <-ctx.Done():
		log.Println("timeout of 5 seconds.")
	}
	log.Println("Server exiting")
}
