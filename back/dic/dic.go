package dic

import (
	"github.com/sarulabs/di"
)

var Instance di.Container

func Init() {
	builder, _ := di.NewBuilder()

	builder.Add(getDbDef())

	if dic, err := builder.Build().SubContainer(); err != nil {
		panic("failed to create DI container")
	} else {
		Instance = dic
	}
}
