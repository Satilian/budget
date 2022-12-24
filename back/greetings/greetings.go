package greetings

import (
	"fmt"
	"os"
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

func MakeFile() {
	file, err := os.Create("confeve.txt")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer file.Close()
	fmt.Fprint(file, "Сегодня ")
	fmt.Fprintln(file, "хорошая погода")
}
