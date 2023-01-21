package greetings

import (
	"fmt"
)

type person struct {
	name string
	age  int
}

func (p person) hello() string {
	return fmt.Sprintf("Hi, %v. Welcome! Age: %v", p.name, p.age)
}

func Hello(name string) string {
	user := person{name, 37}
	return user.hello()
}
