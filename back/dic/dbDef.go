package dic

import (
	"back/db"
	"database/sql"

	"github.com/sarulabs/di"
)

func getDbDef() di.Def {
	return di.Def{
		Name:  "DB",
		Scope: di.App,
		Build: func(ctn di.Container) (interface{}, error) {
			dataSource, err := db.NewDB()

			return dataSource, err
		},
		Close: func(dataSource interface{}) error {
			return dataSource.(*sql.DB).Close()
		},
	}
}
