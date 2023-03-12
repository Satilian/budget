package main

import (
	"back/app"
	"back/db"
)

func main() {
	app.LoadEnv()
	db.DbConnect()
	app.Serv(app.SetupRouter())
}
