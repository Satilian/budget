package main

import (
	"back/app"
)

func main() {
	app.LoadEnv()
	app.Serv(app.SetupRouter())
}
