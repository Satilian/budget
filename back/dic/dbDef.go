package dic

import (
	"back/db"

	"github.com/sarulabs/di"
	"gorm.io/gorm"
)

func getDbDef() di.Def {
	return di.Def{
		Name:  "DB",
		Scope: di.App,
		Build: func(ctn di.Container) (interface{}, error) {
			obj, err := db.NewDB()

			return &obj, err
		},
		Close: func(obj interface{}) error {
			if DB, err := obj.(*gorm.DB).DB(); err == nil {
				return DB.Close()
			} else {
				return err
			}
		},
	}
}
