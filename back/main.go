// @title Budget API
// @version 1.0
// @description Budget management API with authentication, expenses, and categories
// @termsOfService http://swagger.io/terms/

// @contact.name API Support
// @contact.url http://www.swagger.io/support
// @contact.email support@swagger.io

// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html

// @host localhost:8080
// @BasePath /api
// @schemes http https

// @securityDefinitions.apikey Bearer
// @in header
// @name Authorization

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
