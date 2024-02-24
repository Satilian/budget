package auth

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/golang-jwt/jwt"
	"golang.org/x/crypto/bcrypt"
)

func HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	return string(bytes), err
}

func VerifyPassword(hashedPassword string, candidatePassword string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(candidatePassword))
}

func GenerateToken(payload map[string]string) (string, error) {
	token := jwt.New(jwt.SigningMethodHS256)

	now := time.Now().UTC()
	claims := token.Claims.(jwt.MapClaims)

	claims["sub"] = payload["login"]
	claims["jti"] = payload["id"]
	claims["exp"] = time.Now().Add(time.Hour * 24).Unix()
	claims["iat"] = now.Unix()
	claims["nbf"] = now.Unix()

	tokenString, err := token.SignedString([]byte(os.Getenv("TOKEN_SECRET")))

	if err != nil {
		return "", fmt.Errorf("generating JWT Token failed: %w", err)
	}

	return tokenString, nil
}

func ValidateToken(token string) (*jwt.StandardClaims, error) {
	claims := &jwt.StandardClaims{}

	tok, err := jwt.ParseWithClaims(token, claims, func(jwtToken *jwt.Token) (any, error) {
		if _, ok := jwtToken.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected method: %s", jwtToken.Header["alg"])
		}

		return []byte(os.Getenv("TOKEN_SECRET")), nil
	})

	if err != nil || !tok.Valid {
		return claims, fmt.Errorf("invalidate token: %w", err)
	}

	log.Printf("token: %v", tok)

	return claims, nil
}
