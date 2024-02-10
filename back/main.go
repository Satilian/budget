package main

import (
	"back/app"
	"back/dic"
)

func main() {
	app.LoadEnv()
	dic.Init()
	app.Serv(app.SetupRouter())
}
